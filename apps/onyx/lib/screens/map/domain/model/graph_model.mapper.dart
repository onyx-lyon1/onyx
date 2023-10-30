// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'graph_model.dart';

class NodeMapper extends ClassMapperBase<Node> {
  NodeMapper._();

  static NodeMapper? _instance;
  static NodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NodeMapper._());
      _t$_R0Mapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Node';

  static int _$id(Node v) => v.id;
  static const Field<Node, int> _f$id = Field('id', _$id);
  static LatLng _$position(Node v) => v.position;
  static const Field<Node, LatLng> _f$position = Field('position', _$position);
  static List<_t$_R0<double, int>> _$neighbours(Node v) => v.neighbours;
  static const Field<Node, List<_t$_R0<double, int>>> _f$neighbours =
      Field('neighbours', _$neighbours);

  @override
  final Map<Symbol, Field<Node, dynamic>> fields = const {
    #id: _f$id,
    #position: _f$position,
    #neighbours: _f$neighbours,
  };

  static Node _instantiate(DecodingData data) {
    return Node(
        data.dec(_f$id), data.dec(_f$position), data.dec(_f$neighbours));
  }

  @override
  final Function instantiate = _instantiate;

  static Node fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Node>(map);
  }

  static Node deserialize(String json) {
    return ensureInitialized().decodeJson<Node>(json);
  }
}

mixin NodeMappable {
  String serialize() {
    return NodeMapper.ensureInitialized().encodeJson<Node>(this as Node);
  }

  Map<String, dynamic> toJson() {
    return NodeMapper.ensureInitialized().encodeMap<Node>(this as Node);
  }

  NodeCopyWith<Node, Node, Node> get copyWith =>
      _NodeCopyWithImpl(this as Node, $identity, $identity);
  @override
  String toString() {
    return NodeMapper.ensureInitialized().stringifyValue(this as Node);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NodeMapper.ensureInitialized().isValueEqual(this as Node, other));
  }

  @override
  int get hashCode {
    return NodeMapper.ensureInitialized().hashValue(this as Node);
  }
}

extension NodeValueCopy<$R, $Out> on ObjectCopyWith<$R, Node, $Out> {
  NodeCopyWith<$R, Node, $Out> get $asNode =>
      $base.as((v, t, t2) => _NodeCopyWithImpl(v, t, t2));
}

abstract class NodeCopyWith<$R, $In extends Node, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, _t$_R0<double, int>,
          ObjectCopyWith<$R, _t$_R0<double, int>, _t$_R0<double, int>>>
      get neighbours;
  $R call({int? id, LatLng? position, List<_t$_R0<double, int>>? neighbours});
  NodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NodeCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Node, $Out>
    implements NodeCopyWith<$R, Node, $Out> {
  _NodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Node> $mapper = NodeMapper.ensureInitialized();
  @override
  ListCopyWith<$R, _t$_R0<double, int>,
          ObjectCopyWith<$R, _t$_R0<double, int>, _t$_R0<double, int>>>
      get neighbours => ListCopyWith(
          $value.neighbours,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(neighbours: v));
  @override
  $R call({int? id, LatLng? position, List<_t$_R0<double, int>>? neighbours}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (position != null) #position: position,
        if (neighbours != null) #neighbours: neighbours
      }));
  @override
  Node $make(CopyWithData data) => Node(
      data.get(#id, or: $value.id),
      data.get(#position, or: $value.position),
      data.get(#neighbours, or: $value.neighbours));

  @override
  NodeCopyWith<$R2, Node, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _NodeCopyWithImpl($value, $cast, t);
}

class GraphMapper extends ClassMapperBase<Graph> {
  GraphMapper._();

  static GraphMapper? _instance;
  static GraphMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GraphMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Graph';

  static const Field<Graph, List<Map<String, dynamic>>> _f$graphData =
      Field('graphData', null, mode: FieldMode.param);
  static Map<int, Node> _$nodes(Graph v) => v.nodes;
  static const Field<Graph, Map<int, Node>> _f$nodes =
      Field('nodes', _$nodes, mode: FieldMode.member);

  @override
  final Map<Symbol, Field<Graph, dynamic>> fields = const {
    #graphData: _f$graphData,
    #nodes: _f$nodes,
  };

  static Graph _instantiate(DecodingData data) {
    return Graph(data.dec(_f$graphData));
  }

  @override
  final Function instantiate = _instantiate;

  static Graph fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Graph>(map);
  }

  static Graph deserialize(String json) {
    return ensureInitialized().decodeJson<Graph>(json);
  }
}

mixin GraphMappable {
  String serialize() {
    return GraphMapper.ensureInitialized().encodeJson<Graph>(this as Graph);
  }

  Map<String, dynamic> toJson() {
    return GraphMapper.ensureInitialized().encodeMap<Graph>(this as Graph);
  }

  GraphCopyWith<Graph, Graph, Graph> get copyWith =>
      _GraphCopyWithImpl(this as Graph, $identity, $identity);
  @override
  String toString() {
    return GraphMapper.ensureInitialized().stringifyValue(this as Graph);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            GraphMapper.ensureInitialized().isValueEqual(this as Graph, other));
  }

  @override
  int get hashCode {
    return GraphMapper.ensureInitialized().hashValue(this as Graph);
  }
}

extension GraphValueCopy<$R, $Out> on ObjectCopyWith<$R, Graph, $Out> {
  GraphCopyWith<$R, Graph, $Out> get $asGraph =>
      $base.as((v, t, t2) => _GraphCopyWithImpl(v, t, t2));
}

abstract class GraphCopyWith<$R, $In extends Graph, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({required List<Map<String, dynamic>> graphData});
  GraphCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GraphCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Graph, $Out>
    implements GraphCopyWith<$R, Graph, $Out> {
  _GraphCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Graph> $mapper = GraphMapper.ensureInitialized();
  @override
  $R call({required List<Map<String, dynamic>> graphData}) =>
      $apply(FieldCopyWithData({#graphData: graphData}));
  @override
  Graph $make(CopyWithData data) => Graph(data.get(#graphData));

  @override
  GraphCopyWith<$R2, Graph, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _GraphCopyWithImpl($value, $cast, t);
}

typedef _t$_R0<A, B> = ({A distance, B nodeId});

class _t$_R0Mapper extends RecordMapperBase<_t$_R0> {
  static _t$_R0Mapper? _instance;
  _t$_R0Mapper._();

  static _t$_R0Mapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = _t$_R0Mapper._());
      MapperBase.addType(<A, B>(f) => f<({A distance, B nodeId})>());
    }
    return _instance!;
  }

  static dynamic _$distance(_t$_R0 v) => v.distance;
  static dynamic _arg$distance<A, B>(f) => f<A>();
  static const Field<_t$_R0, dynamic> _f$distance =
      Field('distance', _$distance, arg: _arg$distance);
  static dynamic _$nodeId(_t$_R0 v) => v.nodeId;
  static dynamic _arg$nodeId<A, B>(f) => f<B>();
  static const Field<_t$_R0, dynamic> _f$nodeId =
      Field('nodeId', _$nodeId, arg: _arg$nodeId);

  @override
  final Map<Symbol, Field<_t$_R0, dynamic>> fields = const {
    #distance: _f$distance,
    #nodeId: _f$nodeId,
  };

  @override
  Function get typeFactory => <A, B>(f) => f<_t$_R0<A, B>>();

  static _t$_R0<A, B> _instantiate<A, B>(DecodingData<_t$_R0> data) {
    return (distance: data.dec(_f$distance), nodeId: data.dec(_f$nodeId));
  }

  @override
  final Function instantiate = _instantiate;

  static _t$_R0<A, B> fromJson<A, B>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<_t$_R0<A, B>>(map);
  }

  static _t$_R0<A, B> deserialize<A, B>(String json) {
    return ensureInitialized().decodeJson<_t$_R0<A, B>>(json);
  }
}
