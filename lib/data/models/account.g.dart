// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountAdapter extends TypeAdapter<Account> {
  @override
  final int typeId = 1;

  @override
  Account read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Account(
      id: fields[0] as String,
      addresses: (fields[1] as List).cast<Address>(),
      eth: fields[2] as String?,
      ens: fields[3] as String?,
      name: fields[4] as String?,
      isDispensed: fields[5] as bool?,
      claimLink: fields[6] as String?,
      poapToken: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Account obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.addresses)
      ..writeByte(2)
      ..write(obj.eth)
      ..writeByte(3)
      ..write(obj.ens)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.isDispensed)
      ..writeByte(6)
      ..write(obj.claimLink)
      ..writeByte(7)
      ..write(obj.poapToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
