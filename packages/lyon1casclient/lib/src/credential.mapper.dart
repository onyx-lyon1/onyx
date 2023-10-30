// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'credential.dart';

class CredentialMapper extends ClassMapperBase<Credential> {
  CredentialMapper._();

  static CredentialMapper? _instance;
  static CredentialMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CredentialMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Credential';

  static String _$username(Credential v) => v.username;
  static const Field<Credential, String> _f$username =
      Field('username', _$username);
  static String _$password(Credential v) => v.password;
  static const Field<Credential, String> _f$password =
      Field('password', _$password);
  static String _$tgcToken(Credential v) => v.tgcToken;
  static const Field<Credential, String> _f$tgcToken =
      Field('tgcToken', _$tgcToken, opt: true, def: "");

  @override
  final Map<Symbol, Field<Credential, dynamic>> fields = const {
    #username: _f$username,
    #password: _f$password,
    #tgcToken: _f$tgcToken,
  };

  static Credential _instantiate(DecodingData data) {
    return Credential(data.dec(_f$username), data.dec(_f$password),
        tgcToken: data.dec(_f$tgcToken));
  }

  @override
  final Function instantiate = _instantiate;

  static Credential fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Credential>(map);
  }

  static Credential deserialize(String json) {
    return ensureInitialized().decodeJson<Credential>(json);
  }
}

mixin CredentialMappable {
  String serialize() {
    return CredentialMapper.ensureInitialized()
        .encodeJson<Credential>(this as Credential);
  }

  Map<String, dynamic> toJson() {
    return CredentialMapper.ensureInitialized()
        .encodeMap<Credential>(this as Credential);
  }

  CredentialCopyWith<Credential, Credential, Credential> get copyWith =>
      _CredentialCopyWithImpl(this as Credential, $identity, $identity);
  @override
  String toString() {
    return CredentialMapper.ensureInitialized()
        .stringifyValue(this as Credential);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            CredentialMapper.ensureInitialized()
                .isValueEqual(this as Credential, other));
  }

  @override
  int get hashCode {
    return CredentialMapper.ensureInitialized().hashValue(this as Credential);
  }
}

extension CredentialValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Credential, $Out> {
  CredentialCopyWith<$R, Credential, $Out> get $asCredential =>
      $base.as((v, t, t2) => _CredentialCopyWithImpl(v, t, t2));
}

abstract class CredentialCopyWith<$R, $In extends Credential, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? username, String? password, String? tgcToken});
  CredentialCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CredentialCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Credential, $Out>
    implements CredentialCopyWith<$R, Credential, $Out> {
  _CredentialCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Credential> $mapper =
      CredentialMapper.ensureInitialized();
  @override
  $R call({String? username, String? password, String? tgcToken}) =>
      $apply(FieldCopyWithData({
        if (username != null) #username: username,
        if (password != null) #password: password,
        if (tgcToken != null) #tgcToken: tgcToken
      }));
  @override
  Credential $make(CopyWithData data) => Credential(
      data.get(#username, or: $value.username),
      data.get(#password, or: $value.password),
      tgcToken: data.get(#tgcToken, or: $value.tgcToken));

  @override
  CredentialCopyWith<$R2, Credential, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CredentialCopyWithImpl($value, $cast, t);
}
