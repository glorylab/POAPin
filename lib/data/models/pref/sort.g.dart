// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SortPrefAdapter extends TypeAdapter<SortPref> {
  @override
  final int typeId = 5;

  @override
  SortPref read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SortPref.timeAsc;
      case 1:
        return SortPref.timeDesc;
      default:
        return SortPref.timeAsc;
    }
  }

  @override
  void write(BinaryWriter writer, SortPref obj) {
    switch (obj) {
      case SortPref.timeAsc:
        writer.writeByte(0);
        break;
      case SortPref.timeDesc:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SortPrefAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
