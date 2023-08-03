// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../upload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UploadCWProxy {
  Upload title(String title);

  Upload author(String author);

  Upload date(DateTime? date);

  Upload position(double position);

  Upload comment(String comment);

  Upload uploadMax(int uploadMax);

  Upload fileUrl(String fileUrl);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Upload(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Upload(...).copyWith(id: 12, name: "My name")
  /// ````
  Upload call({
    String? title,
    String? author,
    DateTime? date,
    double? position,
    String? comment,
    int? uploadMax,
    String? fileUrl,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpload.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpload.copyWith.fieldName(...)`
class _$UploadCWProxyImpl implements _$UploadCWProxy {
  const _$UploadCWProxyImpl(this._value);

  final Upload _value;

  @override
  Upload title(String title) => this(title: title);

  @override
  Upload author(String author) => this(author: author);

  @override
  Upload date(DateTime? date) => this(date: date);

  @override
  Upload position(double position) => this(position: position);

  @override
  Upload comment(String comment) => this(comment: comment);

  @override
  Upload uploadMax(int uploadMax) => this(uploadMax: uploadMax);

  @override
  Upload fileUrl(String fileUrl) => this(fileUrl: fileUrl);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Upload(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Upload(...).copyWith(id: 12, name: "My name")
  /// ````
  Upload call({
    Object? title = const $CopyWithPlaceholder(),
    Object? author = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? position = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
    Object? uploadMax = const $CopyWithPlaceholder(),
    Object? fileUrl = const $CopyWithPlaceholder(),
  }) {
    return Upload(
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
      comment: comment == const $CopyWithPlaceholder() || comment == null
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String,
      uploadMax: uploadMax == const $CopyWithPlaceholder() || uploadMax == null
          ? _value.uploadMax
          // ignore: cast_nullable_to_non_nullable
          : uploadMax as int,
      fileUrl: fileUrl == const $CopyWithPlaceholder() || fileUrl == null
          ? _value.fileUrl
          // ignore: cast_nullable_to_non_nullable
          : fileUrl as String,
    );
  }
}

extension $UploadCopyWith on Upload {
  /// Returns a callable class that can be used as follows: `instanceOfUpload.copyWith(...)` or like so:`instanceOfUpload.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UploadCWProxy get copyWith => _$UploadCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UploadAdapter extends TypeAdapter<Upload> {
  @override
  final int typeId = 30;

  @override
  Upload read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Upload(
      title: fields[100] == null ? '' : fields[100] as String,
      author: fields[101] == null ? '' : fields[101] as String,
      date: fields[102] as DateTime?,
      position: fields[103] == null ? 0 : fields[103] as double,
      comment: fields[2] == null ? '' : fields[2] as String,
      uploadMax: fields[3] == null ? 0 : fields[3] as int,
      fileUrl: fields[5] == null ? '' : fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Upload obj) {
    writer
      ..writeByte(7)
      ..writeByte(2)
      ..write(obj.comment)
      ..writeByte(3)
      ..write(obj.uploadMax)
      ..writeByte(5)
      ..write(obj.fileUrl)
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
      other is UploadAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
