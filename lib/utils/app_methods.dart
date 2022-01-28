import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/cubit/auth/auth_cubit.dart';
import 'package:to_do/utils/app_strings.dart';

class AppMethods {
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
}
