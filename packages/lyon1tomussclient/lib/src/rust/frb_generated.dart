// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.7.0.

// ignore_for_file: unused_import, unused_element, unnecessary_import, duplicate_ignore, invalid_use_of_internal_member, annotate_overrides, non_constant_identifier_names, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables, unused_field

import 'cas.dart';
import 'dart:async';
import 'dart:convert';
import 'frb_generated.dart';
import 'frb_generated.io.dart'
    if (dart.library.js_interop) 'frb_generated.web.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

/// Main entrypoint of the Rust API
class RustLib extends BaseEntrypoint<RustLibApi, RustLibApiImpl, RustLibWire> {
  @internal
  static final instance = RustLib._();

  RustLib._();

  /// Initialize flutter_rust_bridge
  static Future<void> init({
    RustLibApi? api,
    BaseHandler? handler,
    ExternalLibrary? externalLibrary,
  }) async {
    await instance.initImpl(
      api: api,
      handler: handler,
      externalLibrary: externalLibrary,
    );
  }

  /// Initialize flutter_rust_bridge in mock mode.
  /// No libraries for FFI are loaded.
  static void initMock({
    required RustLibApi api,
  }) {
    instance.initMockImpl(
      api: api,
    );
  }

  /// Dispose flutter_rust_bridge
  ///
  /// The call to this function is optional, since flutter_rust_bridge (and everything else)
  /// is automatically disposed when the app stops.
  static void dispose() => instance.disposeImpl();

  @override
  ApiImplConstructor<RustLibApiImpl, RustLibWire> get apiImplConstructor =>
      RustLibApiImpl.new;

  @override
  WireConstructor<RustLibWire> get wireConstructor =>
      RustLibWire.fromExternalLibrary;

  @override
  Future<void> executeRustInitializers() async {
    await api.crateCasInitApp();
  }

  @override
  ExternalLibraryLoaderConfig get defaultExternalLibraryLoaderConfig =>
      kDefaultExternalLibraryLoaderConfig;

  @override
  String get codegenVersion => '2.7.0';

  @override
  int get rustContentHash => -641462736;

  static const kDefaultExternalLibraryLoaderConfig =
      ExternalLibraryLoaderConfig(
    stem: 'lyon1_cas_client',
    ioDirectory: '../lyon1_cas_client_rs/target/release/',
    webPrefix: 'pkg/',
  );
}

abstract class RustLibApi extends BaseApi {
  Future<bool> crateCasLyon1CasClientAuthenticateUser(
      {required Lyon1CasClient that,
      required String username,
      required String password});

  bool crateCasLyon1CasClientAuthenticated({required Lyon1CasClient that});

  Future<bool> crateCasLyon1CasClientLogout({required Lyon1CasClient that});

  Lyon1CasClient crateCasLyon1CasClientNew();

  Future<String> crateCasLyon1CasClientServiceRequest(
      {required Lyon1CasClient that,
      required String service,
      required bool unsafeReq,
      required bool wrap});

  Future<void> crateCasInitApp();

  RustArcIncrementStrongCountFnType
      get rust_arc_increment_strong_count_Lyon1CasClient;

  RustArcDecrementStrongCountFnType
      get rust_arc_decrement_strong_count_Lyon1CasClient;

  CrossPlatformFinalizerArg
      get rust_arc_decrement_strong_count_Lyon1CasClientPtr;
}

class RustLibApiImpl extends RustLibApiImplPlatform implements RustLibApi {
  RustLibApiImpl({
    required super.handler,
    required super.wire,
    required super.generalizedFrbRustBinding,
    required super.portManager,
  });

  @override
  Future<bool> crateCasLyon1CasClientAuthenticateUser(
      {required Lyon1CasClient that,
      required String username,
      required String password}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_Auto_RefMut_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLyon1CasClient(
            that, serializer);
        sse_encode_String(username, serializer);
        sse_encode_String(password, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 1, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_bool,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateCasLyon1CasClientAuthenticateUserConstMeta,
      argValues: [that, username, password],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateCasLyon1CasClientAuthenticateUserConstMeta =>
      const TaskConstMeta(
        debugName: "Lyon1CasClient_authenticate_user",
        argNames: ["that", "username", "password"],
      );

  @override
  bool crateCasLyon1CasClientAuthenticated({required Lyon1CasClient that}) {
    return handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_Auto_Ref_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLyon1CasClient(
            that, serializer);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 2)!;
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_bool,
        decodeErrorData: null,
      ),
      constMeta: kCrateCasLyon1CasClientAuthenticatedConstMeta,
      argValues: [that],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateCasLyon1CasClientAuthenticatedConstMeta =>
      const TaskConstMeta(
        debugName: "Lyon1CasClient_authenticated",
        argNames: ["that"],
      );

  @override
  Future<bool> crateCasLyon1CasClientLogout({required Lyon1CasClient that}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_Auto_RefMut_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLyon1CasClient(
            that, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 3, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_bool,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateCasLyon1CasClientLogoutConstMeta,
      argValues: [that],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateCasLyon1CasClientLogoutConstMeta =>
      const TaskConstMeta(
        debugName: "Lyon1CasClient_logout",
        argNames: ["that"],
      );

  @override
  Lyon1CasClient crateCasLyon1CasClientNew() {
    return handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 4)!;
      },
      codec: SseCodec(
        decodeSuccessData:
            sse_decode_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLyon1CasClient,
        decodeErrorData: null,
      ),
      constMeta: kCrateCasLyon1CasClientNewConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateCasLyon1CasClientNewConstMeta => const TaskConstMeta(
        debugName: "Lyon1CasClient_new",
        argNames: [],
      );

  @override
  Future<String> crateCasLyon1CasClientServiceRequest(
      {required Lyon1CasClient that,
      required String service,
      required bool unsafeReq,
      required bool wrap}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_Auto_Ref_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLyon1CasClient(
            that, serializer);
        sse_encode_String(service, serializer);
        sse_encode_bool(unsafeReq, serializer);
        sse_encode_bool(wrap, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 5, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_String,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateCasLyon1CasClientServiceRequestConstMeta,
      argValues: [that, service, unsafeReq, wrap],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateCasLyon1CasClientServiceRequestConstMeta =>
      const TaskConstMeta(
        debugName: "Lyon1CasClient_service_request",
        argNames: ["that", "service", "unsafeReq", "wrap"],
      );

  @override
  Future<void> crateCasInitApp() {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 6, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: null,
      ),
      constMeta: kCrateCasInitAppConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateCasInitAppConstMeta => const TaskConstMeta(
        debugName: "init_app",
        argNames: [],
      );

  RustArcIncrementStrongCountFnType
      get rust_arc_increment_strong_count_Lyon1CasClient => wire
          .rust_arc_increment_strong_count_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLyon1CasClient;

  RustArcDecrementStrongCountFnType
      get rust_arc_decrement_strong_count_Lyon1CasClient => wire
          .rust_arc_decrement_strong_count_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLyon1CasClient;

  @protected
  AnyhowException dco_decode_AnyhowException(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return AnyhowException(raw as String);
  }

  @protected
  Lyon1CasClient
      dco_decode_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLyon1CasClient(
          dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return Lyon1CasClientImpl.frbInternalDcoDecode(raw as List<dynamic>);
  }

  @protected
  Lyon1CasClient
      dco_decode_Auto_RefMut_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLyon1CasClient(
          dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return Lyon1CasClientImpl.frbInternalDcoDecode(raw as List<dynamic>);
  }

  @protected
  Lyon1CasClient
      dco_decode_Auto_Ref_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLyon1CasClient(
          dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return Lyon1CasClientImpl.frbInternalDcoDecode(raw as List<dynamic>);
  }

  @protected
  Lyon1CasClient
      dco_decode_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLyon1CasClient(
          dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return Lyon1CasClientImpl.frbInternalDcoDecode(raw as List<dynamic>);
  }

  @protected
  String dco_decode_String(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as String;
  }

  @protected
  bool dco_decode_bool(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as bool;
  }

  @protected
  Uint8List dco_decode_list_prim_u_8_strict(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as Uint8List;
  }

  @protected
  int dco_decode_u_8(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as int;
  }

  @protected
  void dco_decode_unit(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return;
  }

  @protected
  BigInt dco_decode_usize(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return dcoDecodeU64(raw);
  }

  @protected
  AnyhowException sse_decode_AnyhowException(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var inner = sse_decode_String(deserializer);
    return AnyhowException(inner);
  }

  @protected
  Lyon1CasClient
      sse_decode_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLyon1CasClient(
          SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return Lyon1CasClientImpl.frbInternalSseDecode(
        sse_decode_usize(deserializer), sse_decode_i_32(deserializer));
  }

  @protected
  Lyon1CasClient
      sse_decode_Auto_RefMut_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLyon1CasClient(
          SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return Lyon1CasClientImpl.frbInternalSseDecode(
        sse_decode_usize(deserializer), sse_decode_i_32(deserializer));
  }

  @protected
  Lyon1CasClient
      sse_decode_Auto_Ref_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLyon1CasClient(
          SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return Lyon1CasClientImpl.frbInternalSseDecode(
        sse_decode_usize(deserializer), sse_decode_i_32(deserializer));
  }

  @protected
  Lyon1CasClient
      sse_decode_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLyon1CasClient(
          SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return Lyon1CasClientImpl.frbInternalSseDecode(
        sse_decode_usize(deserializer), sse_decode_i_32(deserializer));
  }

  @protected
  String sse_decode_String(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var inner = sse_decode_list_prim_u_8_strict(deserializer);
    return utf8.decoder.convert(inner);
  }

  @protected
  bool sse_decode_bool(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getUint8() != 0;
  }

  @protected
  Uint8List sse_decode_list_prim_u_8_strict(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var len_ = sse_decode_i_32(deserializer);
    return deserializer.buffer.getUint8List(len_);
  }

  @protected
  int sse_decode_u_8(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getUint8();
  }

  @protected
  void sse_decode_unit(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
  }

  @protected
  BigInt sse_decode_usize(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getBigUint64();
  }

  @protected
  int sse_decode_i_32(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getInt32();
  }

  @protected
  void sse_encode_AnyhowException(
      AnyhowException self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(self.message, serializer);
  }

  @protected
  void
      sse_encode_Auto_Owned_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLyon1CasClient(
          Lyon1CasClient self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_usize(
        (self as Lyon1CasClientImpl).frbInternalSseEncode(move: true),
        serializer);
  }

  @protected
  void
      sse_encode_Auto_RefMut_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLyon1CasClient(
          Lyon1CasClient self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_usize(
        (self as Lyon1CasClientImpl).frbInternalSseEncode(move: false),
        serializer);
  }

  @protected
  void
      sse_encode_Auto_Ref_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLyon1CasClient(
          Lyon1CasClient self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_usize(
        (self as Lyon1CasClientImpl).frbInternalSseEncode(move: false),
        serializer);
  }

  @protected
  void
      sse_encode_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLyon1CasClient(
          Lyon1CasClient self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_usize(
        (self as Lyon1CasClientImpl).frbInternalSseEncode(move: null),
        serializer);
  }

  @protected
  void sse_encode_String(String self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_list_prim_u_8_strict(utf8.encoder.convert(self), serializer);
  }

  @protected
  void sse_encode_bool(bool self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putUint8(self ? 1 : 0);
  }

  @protected
  void sse_encode_list_prim_u_8_strict(
      Uint8List self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_i_32(self.length, serializer);
    serializer.buffer.putUint8List(self);
  }

  @protected
  void sse_encode_u_8(int self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putUint8(self);
  }

  @protected
  void sse_encode_unit(void self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
  }

  @protected
  void sse_encode_usize(BigInt self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putBigUint64(self);
  }

  @protected
  void sse_encode_i_32(int self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putInt32(self);
  }
}

@sealed
class Lyon1CasClientImpl extends RustOpaque implements Lyon1CasClient {
  // Not to be used by end users
  Lyon1CasClientImpl.frbInternalDcoDecode(List<dynamic> wire)
      : super.frbInternalDcoDecode(wire, _kStaticData);

  // Not to be used by end users
  Lyon1CasClientImpl.frbInternalSseDecode(BigInt ptr, int externalSizeOnNative)
      : super.frbInternalSseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount:
        RustLib.instance.api.rust_arc_increment_strong_count_Lyon1CasClient,
    rustArcDecrementStrongCount:
        RustLib.instance.api.rust_arc_decrement_strong_count_Lyon1CasClient,
    rustArcDecrementStrongCountPtr:
        RustLib.instance.api.rust_arc_decrement_strong_count_Lyon1CasClientPtr,
  );

  Future<bool> authenticateUser(
          {required String username, required String password}) =>
      RustLib.instance.api.crateCasLyon1CasClientAuthenticateUser(
          that: this, username: username, password: password);

  bool authenticated() =>
      RustLib.instance.api.crateCasLyon1CasClientAuthenticated(
        that: this,
      );

  Future<bool> logout() => RustLib.instance.api.crateCasLyon1CasClientLogout(
        that: this,
      );

  Future<String> serviceRequest(
          {required String service,
          required bool unsafeReq,
          required bool wrap}) =>
      RustLib.instance.api.crateCasLyon1CasClientServiceRequest(
          that: this, service: service, unsafeReq: unsafeReq, wrap: wrap);
}