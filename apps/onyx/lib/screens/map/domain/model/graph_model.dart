import 'package:dart_mappable/dart_mappable.dart';
import 'package:latlong2/latlong.dart';

part 'graph_model.mapper.dart';

@MappableClass()
class Node with NodeMappable {
  final int id;
  final LatLng position;
  final List<({int nodeId, double distance})> neighbours;

  const Node(this.id, this.position, this.neighbours);
}

@MappableClass()
class Graph with GraphMappable {
  final Map<int, Node> nodes = {};

  Graph(List<Map<String, dynamic>> graphData) {
    for (var i in graphData) {
      Node node = Node(
          i['id'],
          LatLng(i['lat'], i['lon']),
          i['connected_nodes']
              .map<({int nodeId, double distance})>((e) =>
                  (nodeId: e['id'] as int, distance: e['distance'] as double))
              .toList());
      nodes[node.id] = node;
    }
  }
}
