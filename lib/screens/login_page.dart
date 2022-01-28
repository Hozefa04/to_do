import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:to_do/utils/app_colors.dart';
import 'package:to_do/utils/app_methods.dart';
import 'package:to_do/utils/app_strings.dart';
import 'package:to_do/utils/text_styles.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildTitle(),
            buildLogo(),
            buildInkWell(context),
          ],
        ),
      ),
    );
  }

  InkWell buildInkWell(BuildContext context) {
    return InkWell(
      onTap: () => AppMethods.signInWithGoogle(context),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 14.0,
          horizontal: 8.0,
        ),
        width: 160,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.signInText,
              style: TextStyles.primaryRegular
                  .copyWith(color: AppColors.accentColor),
            ),
            const SizedBox(width: 20),
            Icon(
              FontAwesomeIcons.google,
              color: AppColors.accentColor,
            ),
          ],
        ),
      ),
    );
  }

  Container buildLogo() {
    return Container(
      padding: const EdgeInsets.all(80),
      child: Image.asset("assets/logo.png"),
    );
  }

  Text buildTitle() {
    return Text(
      AppStrings.welcomeText,
      style: TextStyles.heading,
    );
  }
}
