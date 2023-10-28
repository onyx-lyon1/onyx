// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'teacher.dart';

class TeacherMapper extends ClassMapperBase<Teacher> {
  TeacherMapper._();

  static TeacherMapper? _instance;
  static TeacherMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TeacherMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Teacher';

  static String _$name(Teacher v) => v.name;
  static const Field<Teacher, String> _f$name =
      Field('name', _$name, opt: true, def: "");
  static String _$email(Teacher v) => v.email;
  static const Field<Teacher, String> _f$email =
      Field('email', _$email, opt: true, def: "");

  @override
  final Map<Symbol, Field<Teacher, dynamic>> fields = const {
    #name: _f$name,
    #email: _f$email,
  };

  static Teacher _instantiate(DecodingData data) {
    return Teacher.mappableConstruct(
        name: data.dec(_f$name), email: data.dec(_f$email));
  }

  @override
  final Function instantiate = _instantiate;

  static Teacher fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Teacher>(map);
  }

  static Teacher fromJson(String json) {
    return ensureInitialized().decodeJson<Teacher>(json);
  }
}

mixin TeacherMappable {
  String toJson() {
    return TeacherMapper.ensureInitialized()
        .encodeJson<Teacher>(this as Teacher);
  }

  Map<String, dynamic> toMap() {
    return TeacherMapper.ensureInitialized()
        .encodeMap<Teacher>(this as Teacher);
  }

  TeacherCopyWith<Teacher, Teacher, Teacher> get copyWith =>
      _TeacherCopyWithImpl(this as Teacher, $identity, $identity);
  @override
  String toString() {
    return TeacherMapper.ensureInitialized().stringifyValue(this as Teacher);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            TeacherMapper.ensureInitialized()
                .isValueEqual(this as Teacher, other));
  }

  @override
  int get hashCode {
    return TeacherMapper.ensureInitialized().hashValue(this as Teacher);
  }
}

extension TeacherValueCopy<$R, $Out> on ObjectCopyWith<$R, Teacher, $Out> {
  TeacherCopyWith<$R, Teacher, $Out> get $asTeacher =>
      $base.as((v, t, t2) => _TeacherCopyWithImpl(v, t, t2));
}

abstract class TeacherCopyWith<$R, $In extends Teacher, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? email});
  TeacherCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TeacherCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Teacher, $Out>
    implements TeacherCopyWith<$R, Teacher, $Out> {
  _TeacherCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Teacher> $mapper =
      TeacherMapper.ensureInitialized();
  @override
  $R call({String? name, String? email}) => $apply(FieldCopyWithData(
      {if (name != null) #name: name, if (email != null) #email: email}));
  @override
  Teacher $make(CopyWithData data) => Teacher.mappableConstruct(
      name: data.get(#name, or: $value.name),
      email: data.get(#email, or: $value.email));

  @override
  TeacherCopyWith<$R2, Teacher, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _TeacherCopyWithImpl($value, $cast, t);
}
