// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visibility.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VisibilityPrefAdapter extends TypeAdapter<VisibilityPref> {
  @override
  final int typeId = 15;

  @override
  VisibilityPref read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return VisibilityPref.hideDuplicates;
      case 1:
        return VisibilityPref.showAll;
      default:
        return VisibilityPref.hideDuplicates;
    }
  }

  @override
  void write(BinaryWriter writer, VisibilityPref obj) {
    switch (obj) {
      case VisibilityPref.hideDuplicates:
        writer.writeByte(0);
        break;
      case VisibilityPref.showAll:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VisibilityPrefAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
