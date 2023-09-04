// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../restaurant_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RestaurantListModelAdapter extends TypeAdapter<RestaurantListModel> {
  @override
  final int typeId = 39;

  @override
  RestaurantListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RestaurantListModel(
      restaurantList: (fields[0] as List).cast<RestaurantModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, RestaurantListModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.restaurantList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestaurantListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
