// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../izly_credential.dart';

class IzlyCredentialMapper extends ClassMapperBase<IzlyCredential> {
  IzlyCredentialMapper._();

  static IzlyCredentialMapper? _instance;
  static IzlyCredentialMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IzlyCredentialMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'IzlyCredential';

  static String _$username(IzlyCredential v) => v.username;
  static const Field<IzlyCredential, String> _f$username = Field(
    'username',
    _$username,
  );
  static String _$password(IzlyCredential v) => v.password;
  static const Field<IzlyCredential, String> _f$password = Field(
    'password',
    _$password,
  );

  @override
  final MappableFields<IzlyCredential> fields = const {
    #username: _f$username,
    #password: _f$password,
  };

  static IzlyCredential _instantiate(DecodingData data) {
    return IzlyCredential(
      username: data.dec(_f$username),
      password: data.dec(_f$password),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static IzlyCredential fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IzlyCredential>(map);
  }

  static IzlyCredential fromJson(String json) {
    return ensureInitialized().decodeJson<IzlyCredential>(json);
  }
}

mixin IzlyCredentialMappable {
  String toJson() {
    return IzlyCredentialMapper.ensureInitialized().encodeJson<IzlyCredential>(
      this as IzlyCredential,
    );
  }

  Map<String, dynamic> toMap() {
    return IzlyCredentialMapper.ensureInitialized().encodeMap<IzlyCredential>(
      this as IzlyCredential,
    );
  }

  IzlyCredentialCopyWith<IzlyCredential, IzlyCredential, IzlyCredential>
  get copyWith => _IzlyCredentialCopyWithImpl<IzlyCredential, IzlyCredential>(
    this as IzlyCredential,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return IzlyCredentialMapper.ensureInitialized().stringifyValue(
      this as IzlyCredential,
    );
  }

  @override
  bool operator ==(Object other) {
    return IzlyCredentialMapper.ensureInitialized().equalsValue(
      this as IzlyCredential,
      other,
    );
  }

  @override
  int get hashCode {
    return IzlyCredentialMapper.ensureInitialized().hashValue(
      this as IzlyCredential,
    );
  }
}

extension IzlyCredentialValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IzlyCredential, $Out> {
  IzlyCredentialCopyWith<$R, IzlyCredential, $Out> get $asIzlyCredential =>
      $base.as((v, t, t2) => _IzlyCredentialCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class IzlyCredentialCopyWith<$R, $In extends IzlyCredential, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? username, String? password});
  IzlyCredentialCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _IzlyCredentialCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IzlyCredential, $Out>
    implements IzlyCredentialCopyWith<$R, IzlyCredential, $Out> {
  _IzlyCredentialCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IzlyCredential> $mapper =
      IzlyCredentialMapper.ensureInitialized();
  @override
  $R call({String? username, String? password}) => $apply(
    FieldCopyWithData({
      if (username != null) #username: username,
      if (password != null) #password: password,
    }),
  );
  @override
  IzlyCredential $make(CopyWithData data) => IzlyCredential(
    username: data.get(#username, or: $value.username),
    password: data.get(#password, or: $value.password),
  );

  @override
  IzlyCredentialCopyWith<$R2, IzlyCredential, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _IzlyCredentialCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

