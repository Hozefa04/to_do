import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do/utils/app_colors.dart';
import 'package:to_do/utils/app_methods.dart';
import 'package:to_do/widgets/bloc_color_picker.dart';
import 'package:to_do/widgets/custom_app_bar.dart';
import 'package:to_do/widgets/custom_floating_button.dart';
import 'package:to_do/widgets/custom_loading.dart';
import 'package:to_do/widgets/notes_field.dart';
import 'package:to_do/widgets/title_field.dart';

class UpdateNotesPage extends StatelessWidget {
  final String noteId;
  const UpdateNotesPage({Key? key, required this.noteId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final notesController = TextEditingController();

    return Scaffold(
      appBar: CustomAppBar(
        title: "Update Note",
        hasBackButton: true,
        actions: [
          DeleteNotesButton(noteId: noteId),
          const BlocColorPicker(),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: NoteBuilder(
          noteId: noteId,
          titleController: titleController,
          notesController: notesController,
        ),
      ),
      floatingActionButton: Builder(builder: (ctx) {
        return CustomFloatingButton(
          onPressed: () => AppMethods.updateNote(
            ctx,
            noteId,
            titleController.text,
            notesController.text,
          ),
          icon: Icons.update_rounded,
        );
      }),
    );
  }
}

class NoteBuilder extends StatelessWidget {
  final String noteId;
  final TextEditingController titleController;
  final TextEditingController notesController;
  const NoteBuilder({
    Key? key,
    required this.noteId,
    required this.titleController,
    required this.notesController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: AppMethods.getNote(context, noteId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              const SizedBox(height: 22.0),
              TitleField(
                controller: titleController,
                title: snapshot.data?["title"],
              ),
              const SizedBox(height: 22.0),
              NotesField(
                controller: notesController,
                notes: snapshot.data?["notes"],
              ),
            ],
          );
        }
        return const Center(child: CustomLoading());
      },
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
