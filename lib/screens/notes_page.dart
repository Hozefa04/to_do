import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/cubit/color_picker/color_cubit.dart';
import 'package:to_do/cubit/notes/notes_cubit.dart';
import 'package:to_do/models/notes_model.dart';
import 'package:to_do/utils/app_colors.dart';
import 'package:to_do/utils/app_methods.dart';
import 'package:to_do/utils/app_strings.dart';
import 'package:to_do/widgets/bloc_color_picker.dart';
import 'package:to_do/widgets/custom_app_bar.dart';
import 'package:to_do/widgets/custom_floating_button.dart';
import 'package:to_do/widgets/notes_field.dart';
import 'package:to_do/widgets/title_field.dart';

class NotesPage extends StatelessWidget {
  final bool isUpdate;
  final NotesModel? note;
  const NotesPage({Key? key, this.isUpdate = false, this.note})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final notesController = TextEditingController();

    var _notesCubit = BlocProvider.of<NotesCubit>(context);

    return BlocProvider(
      create: (_) => ColorCubit(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: isUpdate ? AppStrings.updateNoteTitle : AppStrings.addNoteTitle,
          actions: [
            isUpdate ? DeleteNotesButton(noteId: note?.id ?? "") : Container(),
            BlocColorPicker(color: note?.color ?? 4278190080),
          ],
          hasBackButton: true,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Column(
            children: [
              const SizedBox(height: 22.0),
              TitleField(
                controller: titleController,
                title: isUpdate ? note?.title : "",
              ),
              const SizedBox(height: 22.0),
              NotesField(
                controller: notesController,
                notes: isUpdate ? note?.notes : "",
              ),
            ],
          ),
        ),
        floatingActionButton: Builder(builder: (ctx) {
          return CustomFloatingButton(
            onPressed: () {
              if (isUpdate) {
                AppMethods.updateNote(
                  ctx,
                  note?.id,
                  titleController.text,
                  notesController.text,
                );
              } else {
                if (titleController.text != "") {
                  _notesCubit.addNotes(
                      ctx, titleController.text, notesController.text);
                } else {
                  Scaffold.of(ctx).showSnackBar(
                    SnackBar(content: Text(AppStrings.snackBarTitleError)),
                  );
                }
              }
            },
            icon: isUpdate ? Icons.update_rounded : Icons.check_rounded,
          );
        }),
      ),
    );
  }
}

class DeleteNotesButton extends StatelessWidget {
  final String noteId;
  const DeleteNotesButton({Key? key, required this.noteId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => AppMethods.showDeleteWarning(context, noteId),
      icon: Icon(
        Icons.delete_rounded,
        color: AppColors.primaryColor,
      ),
    );
  }
}
