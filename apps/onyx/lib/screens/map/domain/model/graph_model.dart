import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class Node extends Equatable {
  final int id;
  final LatLng position;
  final List<({int nodeId, double distance})> neighbours;

  const Node(this.id, this.position, this.neighbours);

  @override
  List<Object> get props => [id, position, neighbours];

  @override
  bool get stringify => true;
}

class Graph extends Equatable {
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

  @override
  List<Object> get props => [nodes];

  @override
  bool get stringify => true;
}
