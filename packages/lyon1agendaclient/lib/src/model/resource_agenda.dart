import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'generated/resource_agenda.g.dart';

@CopyWith()
class ResourceAgenda extends Equatable {
  final int id;
  final String name;
  final List<ResourceAgenda>? branch;

  ResourceAgenda(this.id, this.name, this.branch);

  factory ResourceAgenda.fromJson(Map<String, dynamic> json) {
    List<ResourceAgenda>? branch;
    if (json.containsKey("branch")) {
      branch = [];
      for (var i in json["branch"] as List) {
        branch.add(ResourceAgenda.fromJson(i));
      }
    }
    return ResourceAgenda(
        json['id'] as int, (json['name'] ?? "") as String, branch);
  }

  @override
  List<Object?> get props => [id, name, branch];
}
