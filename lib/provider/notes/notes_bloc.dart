import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../database/table/notes_table.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitial()) {
    on<NoteSuccessEvent>((event, emit) {
      emit(NotesLoading());
      try{
        Map<String, dynamic> data = {
          'id': event.id,
          'title': event.title,
          'content': event.content,
        };
        // Call insert function to insert data into the table
        NotesTable().insert(data);
        print("data ${data}");
        emit(NotesInitial());
      }catch(e){
print(e);
      }

    });
    on<NotegetEvent>((event, emit) async {
      emit(NotesLoading());
      try {
        List<Map<String, dynamic>> loadedNotes = await NotesTable().getNotes();
       emit(NotesSuccess(loadedNotes));
      }catch(e){
       print(e);
      }

    });
    on<NoteDeleteEvent>((event, emit) async {
      emit(NotesLoading());
      try {
        await NotesTable().deleteNote(event.id);

      } catch (e) {
        print("Error deleting note: $e");
      }

    });

  }
}
