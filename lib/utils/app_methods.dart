import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:to_do/cubit/auth/auth_cubit.dart';
import 'package:to_do/cubit/color_picker/color_cubit.dart';
import 'package:to_do/cubit/nav/nav_cubit.dart';
import 'package:to_do/utils/app_colors.dart';
import 'package:to_do/utils/app_strings.dart';
import 'package:to_do/utils/text_styles.dart';

class AppMethods {
  static final _auth = FirebaseAuth.instance;
  static final _firestoreInstance = FirebaseFirestore.instance;

  //google signin
  static Future<void> signInWithGoogle(BuildContext context) async {
    var _cubit = BlocProvider.of<AuthCubit>(context);
    try {
      await _cubit.googleSignIn();
    } catch (e) {
      print(e.toString());
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.authError),
        ),
      );
    }
  }

  //google logout
  static Future<void> logout(BuildContext context) async {
    var _cubit = BlocProvider.of<AuthCubit>(context);
    try {
      await _cubit.logout();
    } catch (e) {
      print(e.toString());
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.authError),
        ),
      );
    }
  }

  //get user id
  static String? getUid() => _auth.currentUser?.uid;

  //get profile image url
  static String? getPhotoUrl() => _auth.currentUser?.photoURL;

  //get timestamp
  static int getTimeStamp() => DateTime.now().microsecondsSinceEpoch;

  //get converted time
  static String getConvertedTime(int timestamp) {
    var convertedDate = DateTime.fromMicrosecondsSinceEpoch(timestamp);
    var format = DateFormat.yMEd().format(convertedDate).toString();
    return format;
  }

  //retrieve notes from firebase
  static Stream<QuerySnapshot<Map<String, dynamic>>> getNotes() {
    return _firestoreInstance
        .collection("notes")
        .doc(getUid())
        .collection("user_notes")
        .snapshots();
  }

  //retrieve note
  static Future<DocumentSnapshot<Map<String, dynamic>>> getNote(
      BuildContext context, String noteId) {
    return _firestoreInstance
        .collection("notes")
        .doc(getUid())
        .collection("user_notes")
        .doc(noteId)
        .get();
  }

  //update note
  static void updateNote(
      BuildContext context, String noteId, String title, String notes) {
    bool isDone;
    var _cubit = BlocProvider.of<ColorCubit>(context);
    _firestoreInstance
        .collection("notes")
        .doc(getUid())
        .collection("user_notes")
        .doc(noteId)
        .update({
      'timestamp': getTimeStamp(),
      'title': title,
      'notes': notes,
      'color': _cubit.pickedColor?.value ?? AppColors.primaryColor.value,
    }).onError((error, stackTrace) => isDone = false);

    isDone = true;
    if (isDone) {
      Scaffold.of(context)
          .showSnackBar(const SnackBar(content: Text("Note Updated")));
    } else {
      Scaffold.of(context).showSnackBar(const SnackBar(
        content: Text("There was some error updating the note"),
      ));
    }
  }

  //delete note
  static void deleteNote(BuildContext context, String noteId) {
    _firestoreInstance
        .collection("notes")
        .doc(getUid())
        .collection("user_notes")
        .doc(noteId)
        .delete()
        .onError((error, stackTrace) {
      Scaffold.of(context).showSnackBar(const SnackBar(
        content: Text("There was some error deleting the note"),
      ));
      return;
    });
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  //delete alert
  static void showDeleteWarning(BuildContext context, String noteId) {
    AlertDialog alert = AlertDialog(
      title: const Text("Warning"),
      content: const Text("Are you sure you want to delete the note?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "Cancel",
            style: TextStyles.primaryRegular.copyWith(
              fontSize: 14.0,
            ),
          ),
        ),
        TextButton(
          onPressed: () => deleteNote(context, noteId),
          child: Text(
            "Delete",
            style: TextStyles.primaryRegular.copyWith(
              fontSize: 14.0,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (ctx) {
          return alert;
        });
  }

  //color picker dialog
  static void openColorPicker(BuildContext context, [Color? pickedColor]) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            'Pick a color!',
            style: TextStyles.primaryRegular,
          ),
          content: SingleChildScrollView(
            child: ColorPicker(
              onColorChanged: (color) => changeColor(color, context),
              pickerColor: pickedColor ?? AppColors.redColor,
              paletteType: PaletteType.hueWheel,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.check_rounded,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        );
      },
    );
  }

  static void changeColor(Color color, BuildContext context) {
    final colorCubit = BlocProvider.of<ColorCubit>(context);
    colorCubit.setColor(color);
  }
}
