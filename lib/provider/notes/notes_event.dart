part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent {}
class NoteSuccessEvent extends NotesEvent {
  String id;
  String title;
  String content;

  NoteSuccessEvent({required this.id, required this.title, required this.content});
}
class NoteDeleteEvent extends NotesEvent{
  int id;

  NoteDeleteEvent({required this.id});
}
class NotegetEvent extends NotesEvent{
}
