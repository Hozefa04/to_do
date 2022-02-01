part of 'color_cubit.dart';

@immutable
abstract class ColorState extends Equatable {
  const ColorState();

  @override
  List<Object> get props => [];

}

class ColorInitial extends ColorState {
  const ColorInitial();

  @override
  List<Object> get props => [];

}

class ColorPicked extends ColorState {
  final Color pickedColor;
  const ColorPicked(this.pickedColor);

  Color get selectedColor => pickedColor;

  @override
  List<Object> get props => [pickedColor];

}
