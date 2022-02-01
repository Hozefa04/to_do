part of 'notes_cubit.dart';

abstract class NotesState extends Equatable {
  const NotesState();
}

class NotesLoading extends NotesState {
  const NotesLoading();
  @override
  List<Object> get props => [];
}

class NotesLoaded extends NotesState {
  final List<NotesModel> notesList;
  const NotesLoaded(this.notesList);

  @override
  List<Object?> get props => [notesList];
}
