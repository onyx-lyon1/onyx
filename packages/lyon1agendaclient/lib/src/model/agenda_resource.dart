import 'package:dart_mappable/dart_mappable.dart';

part 'generated/agenda_resource.mapper.dart';

@MappableClass()
class AgendaResource with AgendaResourceMappable {
  final int? id;
  final String name;
  final List<AgendaResource>? children;

  AgendaResource(this.id, this.name, this.children);

  factory AgendaResource.fromJson(Map<String, dynamic> json) {
    List<AgendaResource>? branch;
    String key;
    if (json.containsKey("branch") || json.containsKey("leaf")) {
      key = json.containsKey("branch") ? "branch" : "leaf";
      branch = [];
      for (var i in json[key] as List) {
        branch.add(AgendaResource.fromJson(i));
      }

      branch.sort((a, b) => a.name.compareTo(b.name));
    }
    return AgendaResource(
      json['id'] as int?,
      (json['name'] ?? json['category'] ?? "") as String,
      branch,
    );
  }
}
