// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipies.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipesAdapter extends TypeAdapter<Recipes> {
  @override
  final int typeId = 2;

  @override
  Recipes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recipes(
      imagePath: fields[1] as String,
      recipeName: fields[2] as String,
      cookingTime: fields[3] as String,
      catogory: fields[4] as String,
      ingredients: fields[5] as String,
      directions: fields[6] as String,
      url: fields[7] as String,
    )..id = fields[0] as int?;
  }

  @override
  void write(BinaryWriter writer, Recipes obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imagePath)
      ..writeByte(2)
      ..write(obj.recipeName)
      ..writeByte(3)
      ..write(obj.cookingTime)
      ..writeByte(4)
      ..write(obj.catogory)
      ..writeByte(5)
      ..write(obj.ingredients)
      ..writeByte(6)
      ..write(obj.directions)
      ..writeByte(7)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
