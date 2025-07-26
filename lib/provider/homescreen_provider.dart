import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notepad/hive/notes_model.dart';

class HomescreenProvider extends ChangeNotifier {
  bool isMultiSelection = false;
  HashSet<NotesModel> selectedItem = HashSet();
  late Box<NotesModel> notesBox;

  bool _isSearchEnable = false;

  bool get isSearchEnable => _isSearchEnable;

  void setSearch(bool value) {
    _isSearchEnable = value;
    notifyListeners();
  }

  String _selectedCategory = 'All';

  String get selectedCategory => _selectedCategory;

  void setFilterCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }

  void setMultiSelection(bool value) {
    isMultiSelection = value;
    notifyListeners();
  }

  void toggleSelection(NotesModel noteModel) {
    if (selectedItem.contains(noteModel)) {
      selectedItem.remove(noteModel);
    } else {
      selectedItem.add(noteModel);
    }
    notifyListeners();
  }

  void clearSelection() {
    selectedItem.clear();
    setMultiSelection(false);
    notifyListeners();
  }

  void toggleSelectAll() {
    if (selectedCategory == "All"
        ? selectedItem.length == notesBox.length
        : selectedItem.length ==
            notesBox.values.where((note) {
              return note.category == selectedCategory.toString();
            }).length) {
      clearSelection();
    } else {
      selectedCategory == "All"
          ? selectedItem.addAll(notesBox.values.cast<NotesModel>())
          : selectedItem
              .addAll(notesBox.values.cast<NotesModel>().where((note) {
              return note.category == selectedCategory.toString();
            }));
      notifyListeners();
    }
  }

  String getSelectedItemCount() {
    return selectedCategory == "All"
        ? '${selectedItem.length}/${notesBox.length}'
        : '${selectedItem.length}/${notesBox.values.where((note) {
              return note.category == _selectedCategory;
            }).toList().length}';
  }

  setNotesBox(Box<NotesModel> box) {
    notesBox = box;
    notifyListeners();
  }

  void delete(NotesModel notesModel) async {
    await notesModel.delete();
    notifyListeners();
  }
}
