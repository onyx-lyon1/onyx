// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../restaurant_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantListModel _$RestaurantListModelFromJson(Map<String, dynamic> json) =>
    RestaurantListModel(
      restaurantList: (json['restaurantList'] as List<dynamic>)
          .map((e) => RestaurantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RestaurantListModelToJson(
  RestaurantListModel instance,
) => <String, dynamic>{'restaurantList': instance.restaurantList};
