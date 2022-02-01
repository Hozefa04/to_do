import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/cubit/color_picker/color_cubit.dart';
import 'package:to_do/utils/app_methods.dart';
import 'package:to_do/widgets/bloc_color_picker.dart';
import 'package:to_do/widgets/custom_app_bar.dart';
import 'package:to_do/widgets/custom_floating_button.dart';
import 'package:to_do/widgets/notes_field.dart';
import 'package:to_do/widgets/title_field.dart';

class AddNotesPage extends StatelessWidget {
  const AddNotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final notesController = TextEditingController();

    return BlocProvider(
      create: (_) => ColorCubit(),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Add a note",
          actions: [
            BlocColorPicker(),
          ],
          hasBackButton: true,
        ),
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