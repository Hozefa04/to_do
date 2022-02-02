import 'package:flutter/material.dart';
import 'package:to_do/utils/app_colors.dart';
import 'package:to_do/utils/app_strings.dart';
import 'package:to_do/utils/text_styles.dart';
import 'custom_text_field.dart';

class NotesField extends StatelessWidget {
  final TextEditingController controller;
  final String? notes;
  const NotesField({Key? key, required this.controller, this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        controller: controller,
        text: notes,
        hintText: AppStrings.noteHint,
        hintStyle: TextStyles.primaryRegular.copyWith(
          color: AppColors.greyColor,
          fontSize: 18.0,
        ),
        textStyle: TextStyles.primaryRegular.copyWith(
          fontSize: 18.0,
        ),
        isMultiLine: true,
      ),
    );
  }
}