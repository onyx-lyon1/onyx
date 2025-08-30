import "dart:typed_data";

import "package:json_annotation/json_annotation.dart";

/// Converts to and from [Uint8List] and [List]<[int]>.
class Uint8ListConverter implements JsonConverter<Uint8List, List<int>> {
  /// Create a new instance of [Uint8ListConverter].
  const Uint8ListConverter();

  @override
  Uint8List fromJson(List<int> json) {
    return Uint8List.fromList(json);
  }

  @override
  List<int> toJson(Uint8List object) {
    return object.toList();
  }
}
