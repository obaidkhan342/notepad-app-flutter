// ignore_for_file: unused_import, file_names

import 'package:flutter/material.dart';
import 'package:notepad/hive/boxes.dart';
import 'package:notepad/hive/pref.dart';
import 'package:provider/provider.dart';

class PrefProvider extends ChangeNotifier {
  bool _isDardMode = false;
  bool _isNotesCard = false;

  bool get isDarkMode => _isDardMode;
  bool get isNotesCard => _isNotesCard;

  void getSavePref() {
    final prefBox = Boxes.getPref();
    if (prefBox.isNotEmpty) {
      final pref = prefBox.getAt(0);
      _isDardMode = pref!.isDarkTheme;
      _isNotesCard = pref.isNoteCard;
    }
  }

  void toggleDarkMode({required bool value, Pref? pref}) {
    if (pref != null) {
      pref.isDarkTheme = value;
      pref.save();
    } else {
      final prefBox = Boxes.getPref();
      prefBox.put(0, Pref(isNoteCard: isNotesCard, isDarkTheme: value));
    }
    _isDardMode = value;
    notifyListeners();
  }

  void toggleNoteCard({required bool value, Pref? pref}) {
    if (pref != null) {
      pref.isNoteCard = value;
      pref.save();
    } else {
      final prefBox = Boxes.getPref();
      prefBox.put(0, Pref(isNoteCard: value, isDarkTheme: isDarkMode));
    }
    _isNotesCard = value;
    notifyListeners();
  }
}
