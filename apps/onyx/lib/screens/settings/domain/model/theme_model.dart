import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';

class ThemeModel extends Equatable {
  final String name;
  final ThemeData theme;

  const ThemeModel(this.name, this.theme);

  ThemeModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        theme = ThemeDecoder.decodeThemeData(json['theme']) ?? ThemeData();

  Map<String, dynamic> toJson() => {
        'name': name,
        'theme': ThemeEncoder.encodeThemeData(theme),
      };

  @override
  List<Object?> get props => [name, theme];

  @override
  bool get stringify => true;
}
