import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:onyx/core/extensions/lat_lng_extension.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/map/domain/model/graph_model.dart';
import 'package:onyx/screens/map/domain/model/priority_queue.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:requests_plus/requests_plus.dart';

class NavigationLogic {
  static Graph? graph;

  static Future<List<List<LatLng>>> navigateToBatimentFromLocation(
      BuildContext context, List<LatLng> latLngs,
      {bool useLastLocation = false}) async {
    List<List<LatLng>> paths = [];
    LatLng position = (useLastLocation && GeolocationLogic.lastLocation != null)
        ? GeolocationLogic.lastLocation!
        : (await GeolocationLogic.getCurrentLocation(context: context))!;
    for (var latLng in latLngs) {
      if (position.inside(MapRes.minBound, MapRes.maxBound) &&
          latLng.inside(MapRes.minBound, MapRes.maxBound)) {
        // ignore: use_build_context_synchronously
        await _loadGraph(context);
        List<Node> path = _findPathFromLocalGraph(graph!, position, latLng);
        if (path.isNotEmpty) {
          paths.add(path.map((e) => e.position).toList());
        } else {
          paths.add(await _getOsrmRouteFromApi(position, latLng));
        }
      } else {
        paths.add(await _getOsrmRouteFromApi(position, latLng));
      }
    }
    return paths;
  }

  static Future<void> _loadGraph(BuildContext context) async {
    if (graph == null) {
      ByteData data =
          await DefaultAssetBundle.of(context).load('assets/map/graph.json.gz');
      final bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      final decodedData = jsonDecode(String.fromCharCodes(gzip.decode(bytes)));
      if (decodedData is List<dynamic>) {
        final List<Map<String, dynamic>> graphData = decodedData
            .map((e) => e.map<String, dynamic>(
                  (key, value) => MapEntry<String, dynamic>(
                    key,
                    value,
                  ),
                ))
            .toList()
            .cast<Map<String, dynamic>>();
        graph = Graph(graphData);
      }
    }
  }

  static Node _nearestNode(LatLng position, Graph graph) {
    Node nearestNode = graph.nodes.values.first;
    double nearestDistance = double.maxFinite;
    for (var node in graph.nodes.values) {
      double distance = position.distance(node.position);
      if (distance < nearestDistance) {
        nearestNode = node;
        nearestDistance = distance;
      }
    }
    return nearestNode;
  }

  static Map<Node, Node> _findShortestPaths(Graph graph, Node s, Node end) {
    var predecessors = <Node, Node>{};
    var costs = <Node, double>{};
    costs[s] = 0;

    var open = PriorityQueue();
    open.add(s, 0);

    while (open.isNotEmpty) {
      var closest = open.pop();
      var u = closest.item;
      var costOfSToU = closest.priority;

      var adjacentNodes = u.neighbours.map((e) => e.nodeId).toList();

      for (var nodeId in adjacentNodes) {
        Node node = graph.nodes[nodeId]!;
        var costOfE = u.neighbours
            .firstWhere((element) => element.nodeId == nodeId)
            .distance;

        var costOfSToUPlusCostOfE = costOfSToU + costOfE;

        var costOfSToV = costs[node] ?? double.infinity;
        var firstVisit = costs[node] == null;
        if (firstVisit || costOfSToV > costOfSToUPlusCostOfE) {
          costs[node] = costOfSToUPlusCostOfE;
          open.add(node, costOfSToUPlusCostOfE);
          predecessors[node] = u;
        }
      }
    }

    if (costs[end] == null) {
      Res.logger.e('Could not find a path');
    }

    return predecessors;
  }

  static List<Node> _extractShortestPathFromPredecessorList(
      Map<Node, Node> predecessors, Node end) {
    var nodes = <Node>[];
    Node? u = end;
    while (u != null) {
      nodes.add(u);
      u = predecessors[u];
    }
    if (nodes.length == 1) return [];
    return nodes.reversed.toList();
  }

  static List<Node> _findPathFromLocalGraph(
      Graph graph, LatLng start, LatLng vertig) {
    var s = _nearestNode(start, graph);
    var end = _nearestNode(vertig, graph);
    var predecessors = _findShortestPaths(graph, s, end);
    return _extractShortestPathFromPredecessorList(predecessors, end);
  }

  static Future<List<LatLng>> _getOsrmRouteFromApi(
      LatLng departure, LatLng arrival) async {
    var url =
        'https://routing.openstreetmap.de/routed-foot/route/v1/driving/${departure.longitude},${departure.latitude};${arrival.longitude},${arrival.latitude}?overview=false&alternatives=false&steps=true';
    var r = await RequestsPlus.get(url);
    var json = jsonDecode(r.content());
    List steps = json['routes'][0]['legs'][0]['steps'];
    List<LatLng> points = [];
    for (var step in steps) {
      points.add(LatLng(
          step['maneuver']['location'][1], step['maneuver']['location'][0]));
    }
    return points;
  }
}
