import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/cubit/auth/auth_cubit.dart';
import 'package:to_do/utils/app_methods.dart';
import 'package:to_do/utils/app_strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: buildLogoutButton(context),
      ),
    );
  }

  ElevatedButton buildLogoutButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () => AppMethods.logout(context),
        child: Text(AppStrings.logoutText),
      );
  }
}
