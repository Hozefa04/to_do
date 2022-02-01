import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:to_do/cubit/nav/nav_cubit.dart';
import 'package:to_do/screens/add_notes_page.dart';
import 'package:to_do/screens/update_notes_page.dart';
import 'package:to_do/utils/app_colors.dart';
import 'package:to_do/utils/app_methods.dart';
import 'package:to_do/utils/app_strings.dart';
import 'package:to_do/utils/text_styles.dart';
import 'package:to_do/widgets/custom_app_bar.dart';
import 'package:to_do/widgets/custom_floating_button.dart';
import 'package:to_do/widgets/custom_loading.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _navCubit = BlocProvider.of<NavCubit>(context);
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Notes",
          actions: [
            ProfileButton(),
          ],
        ),
        floatingActionButton: CustomFloatingButton(
          onPressed: () => _navCubit.routeToPage(context, const AddNotesPage()),
          icon: Icons.note_add_rounded,
        ),
        body: const NotesBuilder(),
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  const ProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppMethods.logout(context),
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: CircleAvatar(
          radius: 18.0,
          backgroundImage: NetworkImage(
            AppMethods.getPhotoUrl() ?? AppStrings.defaultAvatarUrl,
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}

class NotesBuilder extends StatelessWidget {
  const NotesBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: AppMethods.getNotes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 22.0,
              bottom: 12.0,
            ),
            child: MasonryGridView.builder(
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 12.0,
              itemCount: snapshot.data?.docs.length,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return NotesCard(snapshot: snapshot.data?.docs[index]);
              },
            ),
          );
        }
        return const CustomLoading();
      },
    );
  }
}

class NotesCard extends StatelessWidget {
  final QueryDocumentSnapshot? snapshot;
  const NotesCard({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _navCubit = BlocProvider.of<NavCubit>(context);
    var _notesId = snapshot?.reference.id ?? "Null";
    return InkWell(
      onTap: () =>
          _navCubit.routeToPage(context, UpdateNotesPage(noteId: _notesId)),
      child: Container(
        padding: const EdgeInsets.all(22.0),
        decoration: BoxDecoration(
          color: Color(snapshot?['color']),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NoteTitle(title: snapshot?["title"]),
            const SizedBox(height: 16.0),
            NoteSummary(summary: snapshot?["notes"]),
            const SizedBox(height: 16.0),
            NoteDate(timestamp: snapshot?['timestamp']),
          ],
        ),
      ),
    );
  }
}

class NoteTitle extends StatelessWidget {
  final String title;
  const NoteTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyles.notesHeading,
    );
  }
}

class NoteSummary extends StatelessWidget {
  final String summary;
  const NoteSummary({Key? key, required this.summary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      summary,
      style: TextStyles.notesSummary,
      overflow: TextOverflow.ellipsis,
      maxLines: 10,
    );
  }
}

class NoteDate extends StatelessWidget {
  final int timestamp;
  const NoteDate({Key? key, required this.timestamp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: AppColors.accentColor,
          )),
      child: Text(
        AppMethods.getConvertedTime(timestamp),
        style: TextStyles.notesDate,
      ),
    );
  }
}
