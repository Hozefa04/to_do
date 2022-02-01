import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/cubit/color_picker/color_cubit.dart';
import 'package:to_do/models/notes_model.dart';
import 'package:to_do/utils/app_colors.dart';
import 'package:to_do/utils/app_methods.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(const NotesLoading());

  Future<void> getNotes(String uid) async {
    emit(const NotesLoading());
    var snapshot = await FirebaseFirestore.instance
        .collection("notes")
        .doc(uid)
        .collection("user_notes")
        .get();

    List<NotesModel> notesList = snapshot.docs
        .map<NotesModel>((doc) => NotesModel.fromFirestore(doc))
        .toList();
    emit(NotesLoaded(notesList));
  }

  //add notes
  void addNotes(BuildContext context, String title, String notes) {
    bool isDone;

    var _firestoreInstance = FirebaseFirestore.instance;

    var _colorCubit = BlocProvider.of<ColorCubit>(context);

    var docId = _firestoreInstance
        .collection("notes")
        .doc(AppMethods.getUid())
        .collection("user_notes")
        .doc()
        .id;

    _firestoreInstance
        .collection("notes")
        .doc(AppMethods.getUid())
        .collection("user_notes")
        .doc(docId)
        .set({
      'timestamp': AppMethods.getTimeStamp(),
      'title': title,
      'notes': notes,
      'color': _colorCubit.pickedColor?.value ?? AppColors.primaryColor.value,
      'id': docId,
    }).onError((error, stackTrace) => isDone = false);
    isDone = true;

    if (isDone) {
      Scaffold.of(context)
          .showSnackBar(const SnackBar(content: Text("Note Added")));
    } else {
      Scaffold.of(context).showSnackBar(const SnackBar(
        content: Text("There was some error adding the note"),
      ));
    }
  }

}
