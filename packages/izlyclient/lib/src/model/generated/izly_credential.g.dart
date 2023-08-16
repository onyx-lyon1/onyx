// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../izly_credential.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$IzlyCredentialCWProxy {
  IzlyCredential username(String username);

  IzlyCredential password(String password);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `IzlyCredential(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// IzlyCredential(...).copyWith(id: 12, name: "My name")
  /// ````
  IzlyCredential call({
    String? username,
    String? password,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfIzlyCredential.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfIzlyCredential.copyWith.fieldName(...)`
class _$IzlyCredentialCWProxyImpl implements _$IzlyCredentialCWProxy {
  const _$IzlyCredentialCWProxyImpl(this._value);

  final IzlyCredential _value;

  @override
  IzlyCredential username(String username) => this(username: username);

  @override
  IzlyCredential password(String password) => this(password: password);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `IzlyCredential(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// IzlyCredential(...).copyWith(id: 12, name: "My name")
  /// ````
  IzlyCredential call({
    Object? username = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
  }) {
    return IzlyCredential(
      username: username == const $CopyWithPlaceholder() || username == null
          ? _value.username
          // ignore: cast_nullable_to_non_nullable
          : username as String,
      password: password == const $CopyWithPlaceholder() || password == null
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
    );
  }
}

extension $IzlyCredentialCopyWith on IzlyCredential {
  /// Returns a callable class that can be used as follows: `instanceOfIzlyCredential.copyWith(...)` or like so:`instanceOfIzlyCredential.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$IzlyCredentialCWProxy get copyWith => _$IzlyCredentialCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IzlyCredentialAdapter extends TypeAdapter<IzlyCredential> {
  @override
  final int typeId = 15;

  @override
  IzlyCredential read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IzlyCredential(
      username: fields[0] as String,
      password: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, IzlyCredential obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IzlyCredentialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
