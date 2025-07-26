import 'package:hive_flutter/hive_flutter.dart';

part 'pref.g.dart';

@HiveType(typeId: 1)
class Pref extends HiveObject {
  @HiveField(0)
  bool isNoteCard = false;

  @HiveField(1)
  bool isDarkTheme = false;

  Pref({required this.isNoteCard, required this.isDarkTheme});
  
}
