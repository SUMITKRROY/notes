import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/utils/colors.dart';
import 'package:notes/view/weather_screen.dart';
import '../database/table/notes_table.dart';
import '../provider/notes/notes_bloc.dart';
import 'add_note.dart';
import 'edit_page.dart'; // Import your AddNoteScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<NotesBloc>(context).add(
    //     NotegetEvent(
    //     ));
    _loadNotes();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh notes whenever dependencies change
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    BlocProvider.of<NotesBloc>(context).add(
        NotegetEvent(
        ));
  }

  Future<void> _deleteNoteFromDatabase(int noteId) async {
    BlocProvider.of<NotesBloc>(context).add(
        NoteDeleteEvent(id: noteId
        ));
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.black12,
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.white),
        backgroundColor: CustomColors.black12,
        title: Text(
          "Note Pad",
          style: TextStyle(color: CustomColors.white),
        ),
      ),
      drawer: Drawer(),

      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state is NotesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(state is NotesSuccess){
            notes = state.notes;
            return _buildScreen(context);
          }
         return _buildScreen(context);
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add note screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddNoteScreen(index: "${notes.length + 1}",),
            ),
          ).then((newNote) {
            if (newNote != null) {
              setState(() {
                notes.add(newNote);
              });
            }
          });
        },
        child: Icon(Icons.add),
        backgroundColor: CustomColors.grey,
      ),
    );
  }
  _buildScreen(BuildContext context){
    return RefreshIndicator(
      onRefresh: () async {
        _loadNotes();
        await Future.delayed(Duration(seconds: 2));
      },
      child: notes.isEmpty
          ? Center(
        child: Text(
          'Please add notes',
          style: TextStyle(color: Colors.white),
        ),
      )
          : ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final title = notes[index][NotesTable.title] ?? 'No title';
          final id = notes[index][NotesTable.id] as int? ?? -1;

          return Container(
            decoration: BoxDecoration(
                border: Border.all(color: CustomColors.grey),
                borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.all(08.0),
            child: ListTile(
              title: Text(
                title,
                style: TextStyle(color: CustomColors.white),
              ),
              onTap: () {
                // Navigate to edit note screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditNoteScreen(noteId: id),
                  ),
                );
              },
              trailing: IconButton(
                icon: Icon(Icons.delete, color: CustomColors.white),
                onPressed: () {
                  _deleteNoteFromDatabase(id);
                },
              ),
            ),
          );
        },
      ),
    );
  }

}
