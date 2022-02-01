import 'package:flutter/material.dart';
import 'package:to_do/utils/app_colors.dart';
import 'package:to_do/utils/text_styles.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final bool hasBackButton;
  const CustomAppBar({
    Key? key,
    required this.title,
    required this.actions,
    this.hasBackButton = false,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.transparentColor,
      elevation: 0,
      title: Text(
        title,
        style: TextStyles.primaryBold,
      ),
      leading: hasBackButton? const BackButton() : null,
      actions: actions,
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: Icon(
        Icons.arrow_back_ios_new_rounded,
        color: AppColors.primaryColor,
      ),
    );
  }
}
