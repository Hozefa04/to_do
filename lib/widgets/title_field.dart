import 'package:flutter/material.dart';
import 'package:to_do/widgets/custom_text_field.dart';

class TitleField extends StatelessWidget {
  final TextEditingController controller;
  final String? title;
  const TitleField({Key? key, required this.controller, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      text: title,
      hintText: "Title",
      isMultiLine: false,
    );
  }
}