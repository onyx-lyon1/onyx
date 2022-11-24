// ignore_for_file: hash_and_equals

import 'package:hive_flutter/hive_flutter.dart';

part 'attachment_model.g.dart';

@HiveType(typeId: 13)
class AttachmentModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<int> data;

  AttachmentModel({
    required this.name,
    required this.data,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttachmentModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          data == other.data;

  @override
  String toString() {
    return 'AttachmentModel{name: $name, data: $data}';
  }
}
