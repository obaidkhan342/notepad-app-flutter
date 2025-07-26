import 'package:hive_flutter/hive_flutter.dart';
import 'package:notepad/hive/pref.dart';
import 'package:notepad/utils/constants.dart';
import 'notes_model.dart';

class Boxes {
  static Box<NotesModel> getData() => Hive.box<NotesModel>(Constants.notesBox);
  static Box<Pref> getPref() => Hive.box<Pref>(Constants.prefBox);
}
