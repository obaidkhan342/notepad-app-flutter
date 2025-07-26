// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors, deprecated_member_use, unused_local_variable, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notepad/provider/addnotes_provider.dart';
import 'package:notepad/screens/add_note.dart';
import 'package:notepad/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../hive/notes_model.dart';
import '../provider/homescreen_provider.dart';
import '../widgets/notes-pdf.dart';

class ReadingScreen extends StatefulWidget {
  NotesModel? noteModel;
  ReadingScreen({this.noteModel});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomescreenProvider>(context, listen: false).notesBox;
  }

  @override
  Widget build(BuildContext context) {
    AddNotesProvider provider =
        Provider.of<AddNotesProvider>(context, listen: false);
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      // size: 40,
                    ),
                  ),
                  Text('Reading')
                ],
              ),
              actions: [
                TextButton.icon(
                  onPressed: () {
                    generateAndSaveNotesPdf(
                        downloadOnly: false,
                        noteModel: widget.noteModel!,
                        context: context);
                  },
                  icon: Icon(Icons.share),
                  label: Text("PDF"),
                ),
              ],
            ),
            body: InkWell(
              onTap: () async {
                final updateNote = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                              create: (_) => AddNotesProvider(
                                  notesModel: widget.noteModel, editMode: true),
                              child: AddNote(),
                            )));
                if (updateNote != null) {
                  setState(() {
                    widget.noteModel = updateNote;
                  });
                }
              },
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // SizedBox(
                          //   width: 10,
                          // ),
                          Text(
                            widget.noteModel!.category!,
                            style: TextStyle(
                                color: provider
                                    .categoryColor[widget.noteModel!.category]),
                          ),
                          SizedBox(width: 10),
                          Text(widget.noteModel!.date != null
                              ? '${DateFormat.yMd().format(widget.noteModel!.date!)}'
                              : ''),
                        ],
                      ),
                      Text(
                        widget.noteModel!.title.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.noteModel!.notes.toString(),
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  )),
            )));
  }
}
