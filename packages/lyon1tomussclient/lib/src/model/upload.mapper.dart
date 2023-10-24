// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'upload.dart';

class UploadMapper extends SubClassMapperBase<Upload> {
  UploadMapper._();

  static UploadMapper? _instance;
  static UploadMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UploadMapper._());
      TeachingUnitElementMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'Upload';

  static String _$title(Upload v) => v.title;
  static const Field<Upload, String> _f$title =
      Field('title', _$title, opt: true, def: "");
  static String _$author(Upload v) => v.author;
  static const Field<Upload, String> _f$author =
      Field('author', _$author, opt: true, def: "");
  static DateTime? _$date(Upload v) => v.date;
  static const Field<Upload, DateTime> _f$date =
      Field('date', _$date, opt: true);
  static double _$position(Upload v) => v.position;
  static const Field<Upload, double> _f$position =
      Field('position', _$position, opt: true, def: 0);
  static String _$comment(Upload v) => v.comment;
  static const Field<Upload, String> _f$comment =
      Field('comment', _$comment, opt: true, def: "");
  static int _$uploadMax(Upload v) => v.uploadMax;
  static const Field<Upload, int> _f$uploadMax =
      Field('uploadMax', _$uploadMax, opt: true, def: 0);
  static String _$fileUrl(Upload v) => v.fileUrl;
  static const Field<Upload, String> _f$fileUrl =
      Field('fileUrl', _$fileUrl, opt: true, def: "");

  @override
  final Map<Symbol, Field<Upload, dynamic>> fields = const {
    #title: _f$title,
    #author: _f$author,
    #date: _f$date,
    #position: _f$position,
    #comment: _f$comment,
    #uploadMax: _f$uploadMax,
    #fileUrl: _f$fileUrl,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'Upload';
  @override
  late final ClassMapperBase superMapper =
      TeachingUnitElementMapper.ensureInitialized();

  static Upload _instantiate(DecodingData data) {
    return Upload.mappableConstruct(
        title: data.dec(_f$title),
        author: data.dec(_f$author),
        date: data.dec(_f$date),
        position: data.dec(_f$position),
        comment: data.dec(_f$comment),
        uploadMax: data.dec(_f$uploadMax),
        fileUrl: data.dec(_f$fileUrl));
  }

  @override
  final Function instantiate = _instantiate;

  static Upload fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Upload>(map);
  }

  static Upload fromJson(String json) {
    return ensureInitialized().decodeJson<Upload>(json);
  }
}

mixin UploadMappable {
  String toJson() {
    return UploadMapper.ensureInitialized().encodeJson<Upload>(this as Upload);
  }

  Map<String, dynamic> toMap() {
    return UploadMapper.ensureInitialized().encodeMap<Upload>(this as Upload);
  }

  UploadCopyWith<Upload, Upload, Upload> get copyWith =>
      _UploadCopyWithImpl(this as Upload, $identity, $identity);
  @override
  String toString() {
    return UploadMapper.ensureInitialized().stringifyValue(this as Upload);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            UploadMapper.ensureInitialized()
                .isValueEqual(this as Upload, other));
  }

  @override
  int get hashCode {
    return UploadMapper.ensureInitialized().hashValue(this as Upload);
  }
}

extension UploadValueCopy<$R, $Out> on ObjectCopyWith<$R, Upload, $Out> {
  UploadCopyWith<$R, Upload, $Out> get $asUpload =>
      $base.as((v, t, t2) => _UploadCopyWithImpl(v, t, t2));
}

abstract class UploadCopyWith<$R, $In extends Upload, $Out>
    implements TeachingUnitElementCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? title,
      String? author,
      DateTime? date,
      double? position,
      String? comment,
      int? uploadMax,
      String? fileUrl});
  UploadCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UploadCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Upload, $Out>
    implements UploadCopyWith<$R, Upload, $Out> {
  _UploadCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Upload> $mapper = UploadMapper.ensureInitialized();
  @override
  $R call(
          {String? title,
          String? author,
          Object? date = $none,
          double? position,
          String? comment,
          int? uploadMax,
          String? fileUrl}) =>
      $apply(FieldCopyWithData({
        if (title != null) #title: title,
        if (author != null) #author: author,
        if (date != $none) #date: date,
        if (position != null) #position: position,
        if (comment != null) #comment: comment,
        if (uploadMax != null) #uploadMax: uploadMax,
        if (fileUrl != null) #fileUrl: fileUrl
      }));
  @override
  Upload $make(CopyWithData data) => Upload.mappableConstruct(
      title: data.get(#title, or: $value.title),
      author: data.get(#author, or: $value.author),
      date: data.get(#date, or: $value.date),
      position: data.get(#position, or: $value.position),
      comment: data.get(#comment, or: $value.comment),
      uploadMax: data.get(#uploadMax, or: $value.uploadMax),
      fileUrl: data.get(#fileUrl, or: $value.fileUrl));

  @override
  UploadCopyWith<$R2, Upload, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _UploadCopyWithImpl($value, $cast, t);
}
