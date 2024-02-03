part of 'notes_bloc.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}
class NotesLoading extends NotesState {}
class NotesSuccess extends NotesState {
  List<Map<String, dynamic>> notes = [];

  NotesSuccess(this.notes);
}
