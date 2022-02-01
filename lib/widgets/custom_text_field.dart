import 'package:flutter/material.dart';
import 'package:to_do/utils/app_colors.dart';
import 'package:to_do/utils/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final bool isMultiLine;
  final String? text;
  const CustomTextField({
    Key? key,
    required this.controller,
    this.hintText,
    this.hintStyle,
    this.textStyle,
    required this.isMultiLine,
    this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller..text = text ?? "",
      style: textStyle ?? TextStyles.primaryBold,
      cursorColor: AppColors.primaryColor,
      maxLines: isMultiLine ? null : 1,
      decoration: InputDecoration.collapsed(
        hintText: hintText ?? "",
        hintStyle: hintStyle ??
            TextStyles.primaryBold.copyWith(
              color: AppColors.greyColor,
            ),
      ),
    );
  }
}
