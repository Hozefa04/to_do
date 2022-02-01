import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/cubit/color_picker/color_cubit.dart';
import 'package:to_do/utils/app_colors.dart';
import 'package:to_do/utils/app_methods.dart';
import 'package:to_do/utils/text_styles.dart';
import 'package:to_do/widgets/custom_floating_button.dart';
import 'package:to_do/widgets/custom_text_field.dart';

class AddNotesPage extends StatelessWidget {
  const AddNotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final notesController = TextEditingController();

    return BlocProvider(
      create: (_) => ColorCubit(),
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Column(
            children: [
              const SizedBox(height: 22.0),
              TitleField(controller: titleController),
              const SizedBox(height: 22.0),
              NotesField(controller: notesController),
            ],
          ),
        ),
        floatingActionButton: Builder(builder: (ctx) {
          return CustomFloatingButton(
            onPressed: () {
              if (titleController.text != "") {
                AppMethods.addNotes(
                    ctx, titleController.text, notesController.text);
              } else {
                Scaffold.of(ctx).showSnackBar(
                  const SnackBar(content: Text("Title cannot be empty")),
                );
              }
            },
            icon: Icons.check_rounded,
          );
        }),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.transparentColor,
      elevation: 0,
      title: Text(
        "Add a note",
        style: TextStyles.primaryBold,
      ),
      leading: const BackButton(),
      actions: const [
        BlocColorPicker(),
      ],
    );
  }
}

class NotesField extends StatelessWidget {
  final TextEditingController controller;
  const NotesField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        controller: controller,
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

class TitleField extends StatelessWidget {
  final TextEditingController controller;
  const TitleField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: "Title",
      isMultiLine: false,
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

class BlocColorPicker extends StatelessWidget {
  const BlocColorPicker({Key? key}) : super(key: key);

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
                color: AppColors.primaryColor,
              ),
              child: const Icon(Icons.color_lens_rounded),
            ),
          );
        }
      },
    );
  }
}
