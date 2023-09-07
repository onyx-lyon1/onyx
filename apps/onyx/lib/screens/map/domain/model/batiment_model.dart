import 'package:latlong2/latlong.dart';

class BatimentModel {
  String name;
  LatLng position;

  BatimentModel(this.name, this.position);

  BatimentModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        position = LatLng(json['coordinates'][1], json['coordinates'][0]);

  @override
  String toString() {
    return 'BatimentModel{name: $name, position: $position}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BatimentModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          position == other.position;

  @override
  int get hashCode => name.hashCode ^ position.hashCode;
}
