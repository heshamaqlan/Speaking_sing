// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimationModelAdapter extends TypeAdapter<AnimationModel> {
  @override
  final int typeId = 0;

  @override
  AnimationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnimationModel(
      nameAr: fields[0] as String,
      animationCode: fields[1] as String,
      category: fields[2] as String,
      isFavorite: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AnimationModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.nameAr)
      ..writeByte(1)
      ..write(obj.animationCode)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
