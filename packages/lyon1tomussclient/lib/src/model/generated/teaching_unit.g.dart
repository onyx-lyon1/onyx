// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../teaching_unit.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TeachingUnitCWProxy {
  TeachingUnit title(String title);

  TeachingUnit masters(List<Teacher> masters);

  TeachingUnit grades(List<Grade> grades);

  TeachingUnit textValues(List<TomussText> textValues);

  TeachingUnit enumerations(List<Enumeration> enumerations);

  TeachingUnit presences(List<Presence> presences);

  TeachingUnit stageCodes(List<StageCode> stageCodes);

  TeachingUnit uploads(List<Upload> uploads);

  TeachingUnit urls(List<URL> urls);

  TeachingUnit ticket(String ticket);

  TeachingUnit ue(String ue);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TeachingUnit(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TeachingUnit(...).copyWith(id: 12, name: "My name")
  /// ````
  TeachingUnit call({
    String? title,
    List<Teacher>? masters,
    List<Grade>? grades,
    List<TomussText>? textValues,
    List<Enumeration>? enumerations,
    List<Presence>? presences,
    List<StageCode>? stageCodes,
    List<Upload>? uploads,
    List<URL>? urls,
    String? ticket,
    String? ue,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTeachingUnit.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTeachingUnit.copyWith.fieldName(...)`
class _$TeachingUnitCWProxyImpl implements _$TeachingUnitCWProxy {
  const _$TeachingUnitCWProxyImpl(this._value);

  final TeachingUnit _value;

  @override
  TeachingUnit title(String title) => this(title: title);

  @override
  TeachingUnit masters(List<Teacher> masters) => this(masters: masters);

  @override
  TeachingUnit grades(List<Grade> grades) => this(grades: grades);

  @override
  TeachingUnit textValues(List<TomussText> textValues) =>
      this(textValues: textValues);

  @override
  TeachingUnit enumerations(List<Enumeration> enumerations) =>
      this(enumerations: enumerations);

  @override
  TeachingUnit presences(List<Presence> presences) =>
      this(presences: presences);

  @override
  TeachingUnit stageCodes(List<StageCode> stageCodes) =>
      this(stageCodes: stageCodes);

  @override
  TeachingUnit uploads(List<Upload> uploads) => this(uploads: uploads);

  @override
  TeachingUnit urls(List<URL> urls) => this(urls: urls);

  @override
  TeachingUnit ticket(String ticket) => this(ticket: ticket);

  @override
  TeachingUnit ue(String ue) => this(ue: ue);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TeachingUnit(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TeachingUnit(...).copyWith(id: 12, name: "My name")
  /// ````
  TeachingUnit call({
    Object? title = const $CopyWithPlaceholder(),
    Object? masters = const $CopyWithPlaceholder(),
    Object? grades = const $CopyWithPlaceholder(),
    Object? textValues = const $CopyWithPlaceholder(),
    Object? enumerations = const $CopyWithPlaceholder(),
    Object? presences = const $CopyWithPlaceholder(),
    Object? stageCodes = const $CopyWithPlaceholder(),
    Object? uploads = const $CopyWithPlaceholder(),
    Object? urls = const $CopyWithPlaceholder(),
    Object? ticket = const $CopyWithPlaceholder(),
    Object? ue = const $CopyWithPlaceholder(),
  }) {
    return TeachingUnit(
      title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      masters == const $CopyWithPlaceholder() || masters == null
          ? _value.masters
          // ignore: cast_nullable_to_non_nullable
          : masters as List<Teacher>,
      grades == const $CopyWithPlaceholder() || grades == null
          ? _value.grades
          // ignore: cast_nullable_to_non_nullable
          : grades as List<Grade>,
      textValues == const $CopyWithPlaceholder() || textValues == null
          ? _value.textValues
          // ignore: cast_nullable_to_non_nullable
          : textValues as List<TomussText>,
      enumerations == const $CopyWithPlaceholder() || enumerations == null
          ? _value.enumerations
          // ignore: cast_nullable_to_non_nullable
          : enumerations as List<Enumeration>,
      presences == const $CopyWithPlaceholder() || presences == null
          ? _value.presences
          // ignore: cast_nullable_to_non_nullable
          : presences as List<Presence>,
      stageCodes == const $CopyWithPlaceholder() || stageCodes == null
          ? _value.stageCodes
          // ignore: cast_nullable_to_non_nullable
          : stageCodes as List<StageCode>,
      uploads == const $CopyWithPlaceholder() || uploads == null
          ? _value.uploads
          // ignore: cast_nullable_to_non_nullable
          : uploads as List<Upload>,
      urls == const $CopyWithPlaceholder() || urls == null
          ? _value.urls
          // ignore: cast_nullable_to_non_nullable
          : urls as List<URL>,
      ticket == const $CopyWithPlaceholder() || ticket == null
          ? _value.ticket
          // ignore: cast_nullable_to_non_nullable
          : ticket as String,
      ue == const $CopyWithPlaceholder() || ue == null
          ? _value.ue
          // ignore: cast_nullable_to_non_nullable
          : ue as String,
    );
  }
}

extension $TeachingUnitCopyWith on TeachingUnit {
  /// Returns a callable class that can be used as follows: `instanceOfTeachingUnit.copyWith(...)` or like so:`instanceOfTeachingUnit.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TeachingUnitCWProxy get copyWith => _$TeachingUnitCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TeachingUnitAdapter extends TypeAdapter<TeachingUnit> {
  @override
  final int typeId = 10;

  @override
  TeachingUnit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeachingUnit(
      fields[0] == null ? '' : fields[0] as String,
      fields[1] == null ? [] : (fields[1] as List).cast<Teacher>(),
      fields[2] == null ? [] : (fields[2] as List).cast<Grade>(),
      fields[6] == null ? [] : (fields[6] as List).cast<TomussText>(),
      fields[7] == null ? [] : (fields[7] as List).cast<Enumeration>(),
      fields[8] == null ? [] : (fields[8] as List).cast<Presence>(),
      fields[9] == null ? [] : (fields[9] as List).cast<StageCode>(),
      fields[10] == null ? [] : (fields[10] as List).cast<Upload>(),
      fields[11] == null ? [] : (fields[11] as List).cast<URL>(),
      fields[12] == null ? '' : fields[12] as String,
      fields[13] == null ? '' : fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TeachingUnit obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.masters)
      ..writeByte(2)
      ..write(obj.grades)
      ..writeByte(6)
      ..write(obj.textValues)
      ..writeByte(7)
      ..write(obj.enumerations)
      ..writeByte(8)
      ..write(obj.presences)
      ..writeByte(9)
      ..write(obj.stageCodes)
      ..writeByte(10)
      ..write(obj.uploads)
      ..writeByte(11)
      ..write(obj.urls)
      ..writeByte(12)
      ..write(obj.ticket)
      ..writeByte(13)
      ..write(obj.ue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeachingUnitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
