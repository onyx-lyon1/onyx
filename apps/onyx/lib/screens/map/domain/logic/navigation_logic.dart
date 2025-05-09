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
  static bool calculating = false;

  static Future<List<List<LatLng>>> navigateToBatimentFromLocation(
      BuildContext context, List<LatLng> latLngs,
      {bool useLastLocation = false}) async {
    final assetBundle = DefaultAssetBundle.of(context);
    List<List<LatLng>> paths = [];
    LatLng position =
        (await GeolocationLogic.getCurrentLocation(context: context))!;
    int state = 0; //0: unknow, 1: found local path, 2: found osrm path
    for (var latLng in latLngs) {
      if (position.inside(MapRes.minBound, MapRes.maxBound) &&
          latLng.inside(MapRes.minBound, MapRes.maxBound)) {
        await _loadGraph(assetBundle);
        compute(_findPathFromLocalGraph, (
          graph: graph!,
          start: position,
          vertig: latLng
        )).then((value) async {
          if (state != 2) {
            if (value.isNotEmpty) {
              state = 1;
              paths.add(value.map((e) => e.position).toList());
            } else {
              state = 2;
              paths.add(await _getOsrmRouteFromApi(position, latLng));
            }
          }
        });
        for (var i = 0; i < 10; i++) {
          if (state == 1) break;
          await Future.delayed(const Duration(milliseconds: 100));
        }
        if (state != 1) {
          state = 2;
          paths.add(await _getOsrmRouteFromApi(position, latLng));
        }
      } else {
        state = 2;
        paths.add(await _getOsrmRouteFromApi(position, latLng));
      }
    }
    return paths;
  }

  static Future<void> _loadGraph(AssetBundle assetBundle) async {
    if (graph == null) {
      ByteData data = await assetBundle.load(Res.graphPath);
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
      ({Graph graph, LatLng start, LatLng vertig}) input) {
    var s = _nearestNode(input.start, input.graph);
    var end = _nearestNode(input.vertig, input.graph);
    var predecessors = _findShortestPaths(input.graph, s, end);
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
