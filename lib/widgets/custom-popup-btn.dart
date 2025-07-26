// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:notepad/provider/homescreen_provider.dart';
import 'package:notepad/screens/add_note.dart';
import 'package:notepad/widgets/notes-pdf.dart';
import 'package:provider/provider.dart';

import '../hive/notes_model.dart';
import '../provider/addnotes_provider.dart';

class CustomPopUpMenu extends StatelessWidget {
  final NotesModel? note;
  // final bool? isEdit;
  CustomPopUpMenu({super.key, this.note});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomescreenProvider>(context, listen: true);
    return PopupMenuButton(
        icon: Icon(Icons.more_vert),
        itemBuilder: (context) => [
              PopupMenuItem(
                child: TextButton.icon(
                  onPressed: () {
                    generateAndSaveNotesPdf(
                        downloadOnly: false,
                        noteModel: note!,
                        context: context);
                  },
                  label: Text('share'),
                  icon: Icon(Icons.share),
                ),
                value: 1,
                onTap: () {
                  generateAndSaveNotesPdf(
                      downloadOnly: false, noteModel: note!, context: context);
                },
              ),
              PopupMenuItem(
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (_) => AddNotesProvider(
                                notesModel: note, editMode: true),
                            child: AddNote(),
                          ),
                        ));
                  },
                  label: Text('Edit'),
                  icon: Icon(Icons.edit),
                ),
                // value: 2,
              ),
              PopupMenuItem(
                child: Builder(
                  builder: (popupContext) => TextButton.icon(
                    onPressed: () {
                      provider.delete(note!);
                      Navigator.of(popupContext).pop(); // Closes the popup
                    },
                    label: Text('Delete'),
                    icon: Icon(Icons.delete),
                  ),
                ),
              ),
            ]);
  }
}
