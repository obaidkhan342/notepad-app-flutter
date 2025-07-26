// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pref.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrefAdapter extends TypeAdapter<Pref> {
  @override
  final int typeId = 1;

  @override
  Pref read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pref(
      isNoteCard: fields[0] as bool,
      isDarkTheme: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Pref obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.isNoteCard)
      ..writeByte(1)
      ..write(obj.isDarkTheme);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrefAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
