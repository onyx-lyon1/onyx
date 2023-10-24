import 'package:dart_mappable/dart_mappable.dart';

part 'cb_model.mapper.dart';

@MappableClass()
class CbModel with CbModelMappable {
  final String name;
  final String id;

  CbModel(this.name, this.id);
}
