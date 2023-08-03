// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../grade.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GradeCWProxy {
  Grade title(String title);

  Grade author(String author);

  Grade date(DateTime? date);

  Grade position(double position);

  Grade numerator(double numerator);

  Grade denominator(double denominator);

  Grade rank(int rank);

  Grade average(double average);

  Grade mediane(double mediane);

  Grade isValid(bool isValid);

  Grade groupeSize(int groupeSize);

  Grade children(List<Grade> children);

  Grade coef(double coef);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Grade(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Grade(...).copyWith(id: 12, name: "My name")
  /// ````
  Grade call({
    String? title,
    String? author,
    DateTime? date,
    double? position,
    double? numerator,
    double? denominator,
    int? rank,
    double? average,
    double? mediane,
    bool? isValid,
    int? groupeSize,
    List<Grade>? children,
    double? coef,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfGrade.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfGrade.copyWith.fieldName(...)`
class _$GradeCWProxyImpl implements _$GradeCWProxy {
  const _$GradeCWProxyImpl(this._value);

  final Grade _value;

  @override
  Grade title(String title) => this(title: title);

  @override
  Grade author(String author) => this(author: author);

  @override
  Grade date(DateTime? date) => this(date: date);

  @override
  Grade position(double position) => this(position: position);

  @override
  Grade numerator(double numerator) => this(numerator: numerator);

  @override
  Grade denominator(double denominator) => this(denominator: denominator);

  @override
  Grade rank(int rank) => this(rank: rank);

  @override
  Grade average(double average) => this(average: average);

  @override
  Grade mediane(double mediane) => this(mediane: mediane);

  @override
  Grade isValid(bool isValid) => this(isValid: isValid);

  @override
  Grade groupeSize(int groupeSize) => this(groupeSize: groupeSize);

  @override
  Grade children(List<Grade> children) => this(children: children);

  @override
  Grade coef(double coef) => this(coef: coef);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Grade(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Grade(...).copyWith(id: 12, name: "My name")
  /// ````
  Grade call({
    Object? title = const $CopyWithPlaceholder(),
    Object? author = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? position = const $CopyWithPlaceholder(),
    Object? numerator = const $CopyWithPlaceholder(),
    Object? denominator = const $CopyWithPlaceholder(),
    Object? rank = const $CopyWithPlaceholder(),
    Object? average = const $CopyWithPlaceholder(),
    Object? mediane = const $CopyWithPlaceholder(),
    Object? isValid = const $CopyWithPlaceholder(),
    Object? groupeSize = const $CopyWithPlaceholder(),
    Object? children = const $CopyWithPlaceholder(),
    Object? coef = const $CopyWithPlaceholder(),
  }) {
    return Grade(
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
      numerator: numerator == const $CopyWithPlaceholder() || numerator == null
          ? _value.numerator
          // ignore: cast_nullable_to_non_nullable
          : numerator as double,
      denominator:
          denominator == const $CopyWithPlaceholder() || denominator == null
              ? _value.denominator
              // ignore: cast_nullable_to_non_nullable
              : denominator as double,
      rank: rank == const $CopyWithPlaceholder() || rank == null
          ? _value.rank
          // ignore: cast_nullable_to_non_nullable
          : rank as int,
      average: average == const $CopyWithPlaceholder() || average == null
          ? _value.average
          // ignore: cast_nullable_to_non_nullable
          : average as double,
      mediane: mediane == const $CopyWithPlaceholder() || mediane == null
          ? _value.mediane
          // ignore: cast_nullable_to_non_nullable
          : mediane as double,
      isValid: isValid == const $CopyWithPlaceholder() || isValid == null
          ? _value.isValid
          // ignore: cast_nullable_to_non_nullable
          : isValid as bool,
      groupeSize:
          groupeSize == const $CopyWithPlaceholder() || groupeSize == null
              ? _value.groupeSize
              // ignore: cast_nullable_to_non_nullable
              : groupeSize as int,
      children: children == const $CopyWithPlaceholder() || children == null
          ? _value.children
          // ignore: cast_nullable_to_non_nullable
          : children as List<Grade>,
      coef: coef == const $CopyWithPlaceholder() || coef == null
          ? _value.coef
          // ignore: cast_nullable_to_non_nullable
          : coef as double,
    );
  }
}

extension $GradeCopyWith on Grade {
  /// Returns a callable class that can be used as follows: `instanceOfGrade.copyWith(...)` or like so:`instanceOfGrade.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$GradeCWProxy get copyWith => _$GradeCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GradeAdapter extends TypeAdapter<Grade> {
  @override
  final int typeId = 9;

  @override
  Grade read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Grade(
      title: fields[100] == null ? '' : fields[100] as String,
      author: fields[101] == null ? '' : fields[101] as String,
      date: fields[102] as DateTime?,
      position: fields[103] == null ? 0 : fields[103] as double,
      numerator: fields[2] == null ? 0.0 : fields[2] as double,
      denominator: fields[3] == null ? 20.0 : fields[3] as double,
      rank: fields[4] == null ? -1 : fields[4] as int,
      average: fields[5] == null ? 10.0 : fields[5] as double,
      mediane: fields[6] == null ? 10.0 : fields[6] as double,
      isValid: fields[8] == null ? false : fields[8] as bool,
      groupeSize: fields[7] == null ? -1 : fields[7] as int,
      children: fields[9] == null ? [] : (fields[9] as List).cast<Grade>(),
      coef: fields[10] == null ? 1.0 : fields[10] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Grade obj) {
    writer
      ..writeByte(13)
      ..writeByte(2)
      ..write(obj.numerator)
      ..writeByte(3)
      ..write(obj.denominator)
      ..writeByte(4)
      ..write(obj.rank)
      ..writeByte(5)
      ..write(obj.average)
      ..writeByte(6)
      ..write(obj.mediane)
      ..writeByte(7)
      ..write(obj.groupeSize)
      ..writeByte(8)
      ..write(obj.isValid)
      ..writeByte(10)
      ..write(obj.coef)
      ..writeByte(9)
      ..write(obj.children)
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
      other is GradeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
