// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:notepad/provider/addnotes_provider.dart';
import 'package:provider/provider.dart';
import '../hive/notes_model.dart';
import '../utils/utils.dart';
// import '../utils/utils.dart';

class AddNote extends StatefulWidget {
  NotesModel? noteModel;
  bool? editMode;

  AddNote({this.noteModel, this.editMode = false});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  void initState() {
    super.initState();
    Provider.of<AddNotesProvider>(context, listen: false).noteController;
    Provider.of<AddNotesProvider>(context, listen: false).focusNode;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNotesProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    // child: Text('Cancel')
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  Spacer(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        provider.editMode
                            ? provider.updateNote()
                            : provider.saveNote();
                        Navigator.pop(context, provider.notesModel);
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                ],
              )),
          body: SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                    controller: provider.titleController,
                    onChanged: (value) {
                      // You may call setState here if the widget isn't updating on its own
                      provider.notifyListeners();
                      provider
                          .checkTitleTextDirection(value); // if using Provider
                    },
                    decoration: InputDecoration(
                      hintText: 'Type Title',
                      border: InputBorder.none,
                    ),
                    textDirection:
                        getTextDirection(provider.titleController.text),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                      style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                    ),
                    controller: provider.noteController,
                    onChanged: (value) {
                      // You may call setState here if the widget isn't updating on its own
                      provider.notifyListeners();
                      provider.checkNotesTextDirection(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Type Title',
                      border: InputBorder.none,
                    ),
                    textDirection:
                        getTextDirection(provider.noteController.text),
                    keyboardType:
                        TextInputType.multiline, // 👈 allows multiple lines
                    textInputAction: TextInputAction.newline,
                    maxLines: null,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: provider.selectedIndex,
              onTap: provider.setCurrentIndex,
              items: provider.categories.map((ctg) {
                return BottomNavigationBarItem(
                    icon: Icon(
                      provider.categoryIcon[ctg],
                      color: provider.categoryColor[ctg],
                    ),
                    label: ctg);
              }).toList()),
        );
      },
    );
  }
}
