// ignore_for_file: unused_local_variable, unnecessary_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notepad/hive/boxes.dart';
import 'package:notepad/hive/pref.dart';
import 'package:notepad/utils/constants.dart';
import '../hive/notes_model.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;

class AddNotesProvider extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  FocusNode focusNode = FocusNode();
  NotesModel? notesModel;
  bool editMode;

  bool _isTitleRightSided = false;

  bool get isTitleRightSided => _isTitleRightSided;

  bool _isNotesRightSided = false;

  bool get isNotesRightSided => _isNotesRightSided;

  void checkTitleTextDirection(String text) {
    final rtlChars = RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]');
    _isTitleRightSided = rtlChars.hasMatch(text);
    notifyListeners();
  }

  void checkNotesTextDirection(String text) {
    final rtlChars = RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]');
    _isNotesRightSided = rtlChars.hasMatch(text);
    notifyListeners();
  }

  AddNotesProvider({this.notesModel, this.editMode = false}) {
    noteController.text = notesModel?.notes ?? '';
    titleController.text = notesModel?.title ?? '';
    focusNode.requestFocus();

    noteController.addListener(() {
      notifyListeners();
    });

    titleController.addListener(() {
      notifyListeners();
    });
  }

  int selectedIndex = 0;
  List<String> categories = ['Work', 'Personal', 'Idea'];

  Map<String, IconData> categoryIcon = {
    'Work': Icons.work,
    'Personal': Icons.person,
    'Idea': Icons.psychology,
  };

  Map<String, Color> categoryColor = {
    'Work': const Color(0xFF4FC3F7),
    'Personal': Color(0xFFFF8A65),
    'Idea': Color(0xFFFFD54F),
  };

  void setCurrentIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void updateNote() {
    if (editMode) {
      notesModel!.notes = noteController.text;
      notesModel!.category = categories[selectedIndex];
      notesModel!.title = titleController.text;
      notesModel!.isTitleRightSided = _isTitleRightSided;
      notesModel!.isNotesRightSided = _isNotesRightSided;
      notesModel!.save();
    }
  }

  void saveNote() {
    {
      final data = NotesModel(
        notes: noteController.text,
        title: titleController.text,
        date: DateTime.now(),
        category: categories.isNotEmpty ? categories[selectedIndex] : '',
        isTitleRightSided: _isTitleRightSided,
        isNotesRightSided: _isNotesRightSided,
      );
      final box = Boxes.getData();
      box.add(data);
      data.save();
    }
    noteController.clear();
    titleController.clear();
    notifyListeners();
  }

  static initHive() async {
    final dir = await path.getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    await Hive.initFlutter(Constants.notesDB);
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(NotesModelAdapter());
      await Hive.openBox<NotesModel>(Constants.notesBox);
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(PrefAdapter());
      await Hive.openBox<Pref>(Constants.prefBox);
    }
  }
  //init Hive
  // static initHive() async {
  // final dir = await path.getApplicationDocumentsDirectory();

  //   Hive.init(dir.path);
  //   await Hive.initFlutter('Notes.db');

  //   if (!Hive.isAdapterRegistered(0)) {
  //     Hive.registerAdapter(NotesModelAdapter());
  //     await Hive.openBox<NotesModel>('notes');
  //   }
  // }
}
