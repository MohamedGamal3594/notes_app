// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_note_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveNoteModelAdapter extends TypeAdapter<HiveNoteModel> {
  @override
  final int typeId = 0;

  @override
  HiveNoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveNoteModel(
      id: fields[0] as String,
      title: fields[1] as String,
      subTitle: fields[2] as String,
      date: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveNoteModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.subTitle)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveNoteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
