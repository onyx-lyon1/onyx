import 'package:dart_mappable/dart_mappable.dart';

part 'dir_model.mapper.dart';

@MappableClass(
    generateMethods: GenerateMethods.equals |
        GenerateMethods.stringify |
        GenerateMethods.encode |
        GenerateMethods.copy)
class DirModel with DirModelMappable {
  final String name;
  final int identifier;
  final List<DirModel>? children;

  const DirModel({
    required this.name,
    required this.identifier,
    this.children,
  });

  DirModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        identifier = int.parse(json['identifier'].toString()),
        children = (json['children'] == null)
            ? null
            : (json['children'] as List<dynamic>)
                .map((e) => DirModel.fromJson(e))
                .toList();
}
