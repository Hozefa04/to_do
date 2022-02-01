import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(const NotesLoading());

  void getNotes(String uid) {
    emit(const NotesLoading());
    var snapshot = FirebaseFirestore.instance
        .collection("notes")
        .doc(uid)
        .collection("user_notes")
        .snapshots();
    emit(NotesLoaded(snapshot));
  }

}