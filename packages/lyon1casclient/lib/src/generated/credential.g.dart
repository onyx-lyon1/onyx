// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../credential.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CredentialCWProxy {
  Credential username(String username);

  Credential password(String password);

  Credential tgcToken(String tgcToken);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Credential(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Credential(...).copyWith(id: 12, name: "My name")
  /// ````
  Credential call({
    String? username,
    String? password,
    String? tgcToken,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCredential.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCredential.copyWith.fieldName(...)`
class _$CredentialCWProxyImpl implements _$CredentialCWProxy {
  const _$CredentialCWProxyImpl(this._value);

  final Credential _value;

  @override
  Credential username(String username) => this(username: username);

  @override
  Credential password(String password) => this(password: password);

  @override
  Credential tgcToken(String tgcToken) => this(tgcToken: tgcToken);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Credential(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Credential(...).copyWith(id: 12, name: "My name")
  /// ````
  Credential call({
    Object? username = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? tgcToken = const $CopyWithPlaceholder(),
  }) {
    return Credential(
      username == const $CopyWithPlaceholder() || username == null
          ? _value.username
          // ignore: cast_nullable_to_non_nullable
          : username as String,
      password == const $CopyWithPlaceholder() || password == null
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
      tgcToken: tgcToken == const $CopyWithPlaceholder() || tgcToken == null
          ? _value.tgcToken
          // ignore: cast_nullable_to_non_nullable
          : tgcToken as String,
    );
  }
}

extension $CredentialCopyWith on Credential {
  /// Returns a callable class that can be used as follows: `instanceOfCredential.copyWith(...)` or like so:`instanceOfCredential.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CredentialCWProxy get copyWith => _$CredentialCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CredentialAdapter extends TypeAdapter<Credential> {
  @override
  final int typeId = 4;

  @override
  Credential read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Credential(
      fields[0] as String,
      fields[1] as String,
      tgcToken: fields[2] == null ? '' : fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Credential obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.tgcToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CredentialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
