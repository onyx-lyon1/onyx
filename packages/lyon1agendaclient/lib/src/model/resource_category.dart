import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';

part 'generated/resource_category.g.dart';

@CopyWith()
class ResourceCategory extends Equatable {
  final String category;
  final List<ResourceAgenda> branch;

  ResourceCategory(this.category, this.branch);

  factory ResourceCategory.fromJson(Map<String, dynamic> json) {
    List<ResourceAgenda> branch = [];
    for (var i in json["branch"] as List) {
      branch.add(ResourceAgenda.fromJson(i));
    }
    return ResourceCategory(json['category'].toString(), branch);
  }

  @override
  List<Object?> get props => [category, branch];
}
