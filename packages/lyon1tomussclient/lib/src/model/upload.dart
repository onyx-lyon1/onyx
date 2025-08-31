import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1tomussclient/src/constant/constants.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit_element.dart';
import 'package:requests_plus/requests_plus.dart';

part 'generated/upload.mapper.dart';

@MappableClass()
class Upload extends TeachingUnitElement with UploadMappable {
  late final String comment;
  late final int uploadMax;
  late final String fileUrl;

  Upload.fromJSON(
    int id,
    Map<String, dynamic> json,
    Map<String, dynamic> stats,
    List<dynamic> line,
    Map<String, dynamic> column,
    String user,
  ) : super.fromJson(id, json, stats, line, column, user) {
    comment = json['comment'] ?? "";
    uploadMax = int.tryParse(json['upload_max'] ?? "") ?? 0;
    //https://tomuss.univ-lyon1.fr/2023/Printemps/codeUE/upload_get/theId/lineId/codeUE_uploadName_filename?unsafe=1&ticket=ST-6037266-YbrFlIZeqewEEE1TjBgy-cas.univ-lyon1.fr
    if (line[id].isNotEmpty) {
      fileUrl =
          "${Constants.tomuss}/${column['year']}/${column['semester']}/${column['ue']}/upload_get/${json["the_id"]}/${column['line_id']}/${column['ue']}_${title}_${(line[id] as List).elementAtOrNull(3)?.toString().split(" ").last}";
    } else {
      fileUrl = "";
    }
  }

  @MappableConstructor()
  Upload({
    required super.title,
    required super.author,
    required super.date,
    required super.position,
    this.comment = "",
    this.uploadMax = 0,
    this.fileUrl = "",
  });

  Future<List<int>> getContent(String ticket) async {
    var response = await RequestsPlus.get("$fileUrl?unsafe=1&ticket=$ticket");
    if (response.statusCode == 200) {
      return response.bytes().toList();
    }
    throw Exception("Error while getting file");
  }

  @override
  bool get isVisible => true;

  @override
  List<Object?> get customProps => [comment, uploadMax, fileUrl];
}
