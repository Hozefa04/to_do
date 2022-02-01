import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'nav_state.dart';

class NavCubit extends Cubit<NavState> {
  NavCubit() : super(const NavInitial());

  Widget? routeToPage(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return page;
    }));
  }

}
