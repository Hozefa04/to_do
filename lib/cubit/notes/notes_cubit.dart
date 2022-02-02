import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/models/notes_model.dart';
part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(const NotesLoading());

  Future<void> getNotes(String uid) async {
    emit(const NotesLoading());
    var snapshot = await FirebaseFirestore.instance
        .collection("notes")
        .doc(uid)
        .collection("user_notes")
        .get();

    List<NotesModel> notesList = snapshot.docs
        .map<NotesModel>((doc) => NotesModel.fromFirestore(doc))
        .toList();
    emit(NotesLoaded(notesList));
  }

}
