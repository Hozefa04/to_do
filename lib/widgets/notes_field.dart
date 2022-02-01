import 'package:flutter/material.dart';
import 'package:to_do/utils/app_colors.dart';
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
        hintText: "Add your note",
        hintStyle: TextStyles.primaryRegular.copyWith(
          color: AppColors.greyColor,
        ),
        textStyle: TextStyles.primaryRegular,
        isMultiLine: true,
      ),
    );
  }
}