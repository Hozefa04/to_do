import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/cubit/color_picker/color_cubit.dart';
import 'package:to_do/utils/app_methods.dart';

class BlocColorPicker extends StatelessWidget {
  final int color;
  const BlocColorPicker({Key? key, this.color = 4278190080}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorCubit, ColorState>(
      builder: (context, state) {
        if (state is ColorPicked) {
          return InkWell(
            onTap: () => AppMethods.openColorPicker(context, state.pickedColor),
            child: Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: state.pickedColor,
              ),
              child: const Icon(Icons.color_lens_rounded),
            ),
          );
        } else {
          return InkWell(
            onTap: () => AppMethods.openColorPicker(context),
            child: Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(color),
              ),
              child: const Icon(Icons.color_lens_rounded),
            ),
          );
        }
      },
    );
  }
}