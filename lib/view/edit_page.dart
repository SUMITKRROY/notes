import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../database/table/notes_table.dart'; // Import your NotesTable
import '../provider/notes/notes_bloc.dart';
import '../utils/colors.dart';
import '../utils/widgets/button.dart';
import '../utils/widgets/custom_TextFeild.dart';

class EditNoteScreen extends StatefulWidget {
  final int noteId;

  const EditNoteScreen({Key? key, required this.noteId}) : super(key: key);

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();

    // Load existing note details when the edit page is initialized
    loadNoteDetails();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> loadNoteDetails() async {
    // Retrieve existing note details from the database based on the note ID
    Map<String, dynamic> noteDetails = await NotesTable().getNoteById(widget.noteId);
    setState(() {
      _titleController.text = noteDetails[NotesTable.title];
      _contentController.text = noteDetails[NotesTable.content];
    });
  }

  Future<void> saveChanges() async {
    // Save changes to the database
    Map<String, dynamic> updatedNote = {
      NotesTable.id: widget.noteId,
      NotesTable.title: _titleController.text,
      NotesTable.content: _contentController.text,
    };
    await NotesTable().updateNote(updatedNote);


    BlocProvider.of<NotesBloc>(context).add(
        NotegetEvent(
        ));

    // Navigate back to the previous screen
    Navigator.pop(context, true); // Pass 'true' to indicate that the note was updated
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.black),
        backgroundColor: CustomColors.white,
        title: Text('Edit Note',style: TextStyle(color: CustomColors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              label: 'Email',
              onChanged: (val) => {},
              controller: _titleController,
              keyboardType: TextInputType.text, validatorLable: 'title',

            ),
            SizedBox(height: 12.0),
            CustomTextField(
              label: 'Content',
              onChanged: (val) => {},
              controller: _contentController,
              keyboardType: TextInputType.text, validatorLable: 'Content',maxline: 5,

            ),
            SizedBox(height: 12.0),
            CustomButton(onPressed: saveChanges, label: "Update")

          ],
        ),
      ),
    );
  }
}
