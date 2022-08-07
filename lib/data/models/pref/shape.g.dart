// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shape.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShapePrefAdapter extends TypeAdapter<ShapePref> {
  @override
  final int typeId = 4;

  @override
  ShapePref read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ShapePref.square;
      case 1:
        return ShapePref.round;
      default:
        return ShapePref.square;
    }
  }

  @override
  void write(BinaryWriter writer, ShapePref obj) {
    switch (obj) {
      case ShapePref.square:
        writer.writeByte(0);
        break;
      case ShapePref.round:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShapePrefAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
