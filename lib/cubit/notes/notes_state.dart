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
  final Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot;
  const NotesLoaded(this.querySnapshot);

  @override
  List<Object?> get props => [querySnapshot];
}
