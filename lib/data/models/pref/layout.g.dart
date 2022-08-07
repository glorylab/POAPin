// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LayoutPrefAdapter extends TypeAdapter<LayoutPref> {
  @override
  final int typeId = 3;

  @override
  LayoutPref read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LayoutPref.grid;
      case 1:
        return LayoutPref.list;
      case 2:
        return LayoutPref.timeline;
      default:
        return LayoutPref.grid;
    }
  }

  @override
  void write(BinaryWriter writer, LayoutPref obj) {
    switch (obj) {
      case LayoutPref.grid:
        writer.writeByte(0);
        break;
      case LayoutPref.list:
        writer.writeByte(1);
        break;
      case LayoutPref.timeline:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LayoutPrefAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
