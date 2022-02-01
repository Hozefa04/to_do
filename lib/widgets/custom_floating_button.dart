import 'package:flutter/material.dart';
import 'package:to_do/utils/app_colors.dart';

class CustomFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  const CustomFloatingButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppColors.primaryColor,
      child: Icon(icon),
    );
  }
}
