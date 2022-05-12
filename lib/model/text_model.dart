import 'package:dartus/tomuss.dart';

class TextModel {
  late String _name;
  late String _value;
  late String _author;
  late String _comment;

  TextModel.fromText(Text t) {
    _name = t.name;
    _value = t.value;
    _author = t.author;
    _comment = t.comment;
  }

  String get name => _name;
  String get value => _value;
  String get author => _author;
  String get comment => _comment;
}
