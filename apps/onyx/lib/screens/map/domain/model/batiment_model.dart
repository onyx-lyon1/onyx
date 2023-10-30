import 'package:dart_mappable/dart_mappable.dart';
import 'package:latlong2/latlong.dart';

part 'batiment_model.mapper.dart';

@MappableClass(
    generateMethods: GenerateMethods.equals |
    GenerateMethods.stringify |
    GenerateMethods.encode |
    GenerateMethods.copy)
class BatimentModel with BatimentModelMappable {
  String name;
  LatLng position;

  BatimentModel(this.name, this.position);

  BatimentModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        position = LatLng(json['coordinates'][1], json['coordinates'][0]);
}
