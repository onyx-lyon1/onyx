import 'package:dartus/tomuss.dart';
import 'package:hive_flutter/adapters.dart';

part 'text_model.g.dart';

@HiveType(typeId: 9)
class TextModel {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String value;
  @HiveField(2)
  late String author;
  @HiveField(3)
  late String comment;

  TextModel(
      {required this.name,
      required this.value,
      required this.author,
      required this.comment});

  TextModel.fromText(Text t) {
    name = t.name;
    value = t.value;
    author = t.author;
    comment = t.comment;
  }
}
