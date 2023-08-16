// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../enumeration.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EnumerationCWProxy {
  Enumeration title(String title);

  Enumeration author(String author);

  Enumeration date(DateTime? date);

  Enumeration position(double position);

  Enumeration value(String? value);

  Enumeration values(List<String> values);

  Enumeration comment(String comment);

  Enumeration theId(String theId);

  Enumeration lineId(String lineId);

  Enumeration ue(String ue);

  Enumeration semester(String semester);

  Enumeration year(String year);

  Enumeration modifiable(bool modifiable);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Enumeration(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Enumeration(...).copyWith(id: 12, name: "My name")
  /// ````
  Enumeration call({
    String? title,
    String? author,
    DateTime? date,
    double? position,
    String? value,
    List<String>? values,
    String? comment,
    String? theId,
    String? lineId,
    String? ue,
    String? semester,
    String? year,
    bool? modifiable,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfEnumeration.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfEnumeration.copyWith.fieldName(...)`
class _$EnumerationCWProxyImpl implements _$EnumerationCWProxy {
  const _$EnumerationCWProxyImpl(this._value);

  final Enumeration _value;

  @override
  Enumeration title(String title) => this(title: title);

  @override
  Enumeration author(String author) => this(author: author);

  @override
  Enumeration date(DateTime? date) => this(date: date);

  @override
  Enumeration position(double position) => this(position: position);

  @override
  Enumeration value(String? value) => this(value: value);

  @override
  Enumeration values(List<String> values) => this(values: values);

  @override
  Enumeration comment(String comment) => this(comment: comment);

  @override
  Enumeration theId(String theId) => this(theId: theId);

  @override
  Enumeration lineId(String lineId) => this(lineId: lineId);

  @override
  Enumeration ue(String ue) => this(ue: ue);

  @override
  Enumeration semester(String semester) => this(semester: semester);

  @override
  Enumeration year(String year) => this(year: year);

  @override
  Enumeration modifiable(bool modifiable) => this(modifiable: modifiable);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Enumeration(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Enumeration(...).copyWith(id: 12, name: "My name")
  /// ````
  Enumeration call({
    Object? title = const $CopyWithPlaceholder(),
    Object? author = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? position = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
    Object? values = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
    Object? theId = const $CopyWithPlaceholder(),
    Object? lineId = const $CopyWithPlaceholder(),
    Object? ue = const $CopyWithPlaceholder(),
    Object? semester = const $CopyWithPlaceholder(),
    Object? year = const $CopyWithPlaceholder(),
    Object? modifiable = const $CopyWithPlaceholder(),
  }) {
    return Enumeration(
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      author: author == const $CopyWithPlaceholder() || author == null
          ? _value.author
          // ignore: cast_nullable_to_non_nullable
          : author as String,
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as DateTime?,
      position: position == const $CopyWithPlaceholder() || position == null
          ? _value.position
          // ignore: cast_nullable_to_non_nullable
          : position as double,
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as String?,
      values: values == const $CopyWithPlaceholder() || values == null
          ? _value.values
          // ignore: cast_nullable_to_non_nullable
          : values as List<String>,
      comment: comment == const $CopyWithPlaceholder() || comment == null
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String,
      theId: theId == const $CopyWithPlaceholder() || theId == null
          ? _value.theId
          // ignore: cast_nullable_to_non_nullable
          : theId as String,
      lineId: lineId == const $CopyWithPlaceholder() || lineId == null
          ? _value.lineId
          // ignore: cast_nullable_to_non_nullable
          : lineId as String,
      ue: ue == const $CopyWithPlaceholder() || ue == null
          ? _value.ue
          // ignore: cast_nullable_to_non_nullable
          : ue as String,
      semester: semester == const $CopyWithPlaceholder() || semester == null
          ? _value.semester
          // ignore: cast_nullable_to_non_nullable
          : semester as String,
      year: year == const $CopyWithPlaceholder() || year == null
          ? _value.year
          // ignore: cast_nullable_to_non_nullable
          : year as String,
      modifiable:
          modifiable == const $CopyWithPlaceholder() || modifiable == null
              ? _value.modifiable
              // ignore: cast_nullable_to_non_nullable
              : modifiable as bool,
    );
  }
}

extension $EnumerationCopyWith on Enumeration {
  /// Returns a callable class that can be used as follows: `instanceOfEnumeration.copyWith(...)` or like so:`instanceOfEnumeration.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EnumerationCWProxy get copyWith => _$EnumerationCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnumerationAdapter extends TypeAdapter<Enumeration> {
  @override
  final int typeId = 25;

  @override
  Enumeration read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Enumeration(
      title: fields[100] == null ? '' : fields[100] as String,
      author: fields[101] == null ? '' : fields[101] as String,
      date: fields[102] as DateTime?,
      position: fields[103] == null ? 0 : fields[103] as double,
      value: fields[1] as String?,
      values: fields[2] == null ? [] : (fields[2] as List).cast<String>(),
      comment: fields[4] == null ? '' : fields[4] as String,
      theId: fields[6] == null ? '' : fields[6] as String,
      lineId: fields[7] == null ? '' : fields[7] as String,
      ue: fields[8] == null ? '' : fields[8] as String,
      semester: fields[9] == null ? '' : fields[9] as String,
      year: fields[10] == null ? '' : fields[10] as String,
      modifiable: fields[12] == null ? true : fields[12] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Enumeration obj) {
    writer
      ..writeByte(13)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.values)
      ..writeByte(4)
      ..write(obj.comment)
      ..writeByte(6)
      ..write(obj.theId)
      ..writeByte(7)
      ..write(obj.lineId)
      ..writeByte(8)
      ..write(obj.ue)
      ..writeByte(9)
      ..write(obj.semester)
      ..writeByte(10)
      ..write(obj.year)
      ..writeByte(12)
      ..write(obj.modifiable)
      ..writeByte(100)
      ..write(obj.title)
      ..writeByte(101)
      ..write(obj.author)
      ..writeByte(102)
      ..write(obj.date)
      ..writeByte(103)
      ..write(obj.position);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnumerationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
