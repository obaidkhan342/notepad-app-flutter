import 'package:hive/hive.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 0)
class NotesModel extends HiveObject {
  @HiveField(0)
  String? title;

  @HiveField(1)
  String notes;

  @HiveField(2)
  DateTime? date;

  @HiveField(3)
  String? category;

  @HiveField(4)
  bool? isTitleRightSided;

  @HiveField(5)
  bool? isNotesRightSided;

  NotesModel(
      {this.title,
      required this.notes,
      this.date,
      this.category,
      this.isTitleRightSided,
      this.isNotesRightSided});

  @override
  bool operator ==(covariant NotesModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.notes == notes &&
        other.date == date &&
        other.category == category;
  }

  @override
  int get hashCode =>
      title.hashCode ^ notes.hashCode ^ date.hashCode ^ category.hashCode;
}
