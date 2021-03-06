import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'color_state.dart';

class ColorCubit extends Cubit<ColorState> {
  Color? pickedColor;

  ColorCubit() : super(const ColorInitial());

  Color? get selectedColor => pickedColor;

  void setColor(Color color) {
    pickedColor = color;
    emit(ColorPicked(color));
  }

}
