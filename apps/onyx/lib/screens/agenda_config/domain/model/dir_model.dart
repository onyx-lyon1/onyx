class DirModel {
  final String name;
  final int id;
  List<DirModel> children;

  DirModel({
    required this.name,
    required this.id,
    this.children = const [],
  });

  DirModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        children = (json['children'] as List<dynamic>)
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
          id == other.id &&
          children == other.children;

  @override
  int get hashCode => name.hashCode ^ id.hashCode ^ children.hashCode;
}
