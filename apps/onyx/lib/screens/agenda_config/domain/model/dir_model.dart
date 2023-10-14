class DirModel {
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

  @override
  String toString() {
    return 'DirModel{name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DirModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          identifier == other.identifier &&
          children == other.children;

  @override
  int get hashCode => name.hashCode ^ identifier.hashCode ^ children.hashCode;
}
