// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'student_colloscope.dart';

class StudentColloscopeMapper extends ClassMapperBase<StudentColloscope> {
  StudentColloscopeMapper._();

  static StudentColloscopeMapper? _instance;
  static StudentColloscopeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StudentColloscopeMapper._());
      StudentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'StudentColloscope';

  static Student _$student(StudentColloscope v) => v.student;
  static const Field<StudentColloscope, Student> _f$student =
      Field('student', _$student);
  static int _$trinomeId(StudentColloscope v) => v.trinomeId;
  static const Field<StudentColloscope, int> _f$trinomeId =
      Field('trinomeId', _$trinomeId);
  static List<dynamic> _$kholles(StudentColloscope v) => v.kholles;
  static const Field<StudentColloscope, List<dynamic>> _f$kholles =
      Field('kholles', _$kholles);

  @override
  final Map<Symbol, Field<StudentColloscope, dynamic>> fields = const {
    #student: _f$student,
    #trinomeId: _f$trinomeId,
    #kholles: _f$kholles,
  };

  static StudentColloscope _instantiate(DecodingData data) {
    return StudentColloscope(
        data.dec(_f$student), data.dec(_f$trinomeId), data.dec(_f$kholles));
  }

  @override
  final Function instantiate = _instantiate;

  static StudentColloscope fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StudentColloscope>(map);
  }

  static StudentColloscope fromJson(String json) {
    return ensureInitialized().decodeJson<StudentColloscope>(json);
  }
}

mixin StudentColloscopeMappable {
  String toJson() {
    return StudentColloscopeMapper.ensureInitialized()
        .encodeJson<StudentColloscope>(this as StudentColloscope);
  }

  Map<String, dynamic> toMap() {
    return StudentColloscopeMapper.ensureInitialized()
        .encodeMap<StudentColloscope>(this as StudentColloscope);
  }

  StudentColloscopeCopyWith<StudentColloscope, StudentColloscope,
          StudentColloscope>
      get copyWith => _StudentColloscopeCopyWithImpl(
          this as StudentColloscope, $identity, $identity);
  @override
  String toString() {
    return StudentColloscopeMapper.ensureInitialized()
        .stringifyValue(this as StudentColloscope);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StudentColloscopeMapper.ensureInitialized()
                .isValueEqual(this as StudentColloscope, other));
  }

  @override
  int get hashCode {
    return StudentColloscopeMapper.ensureInitialized()
        .hashValue(this as StudentColloscope);
  }
}

extension StudentColloscopeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StudentColloscope, $Out> {
  StudentColloscopeCopyWith<$R, StudentColloscope, $Out>
      get $asStudentColloscope =>
          $base.as((v, t, t2) => _StudentColloscopeCopyWithImpl(v, t, t2));
}

abstract class StudentColloscopeCopyWith<$R, $In extends StudentColloscope,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  StudentCopyWith<$R, Student, Student> get student;
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>> get kholles;
  $R call({Student? student, int? trinomeId, List<dynamic>? kholles});
  StudentColloscopeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StudentColloscopeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StudentColloscope, $Out>
    implements StudentColloscopeCopyWith<$R, StudentColloscope, $Out> {
  _StudentColloscopeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StudentColloscope> $mapper =
      StudentColloscopeMapper.ensureInitialized();
  @override
  StudentCopyWith<$R, Student, Student> get student =>
      $value.student.copyWith.$chain((v) => call(student: v));
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>> get kholles =>
      ListCopyWith($value.kholles, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(kholles: v));
  @override
  $R call({Student? student, int? trinomeId, List<dynamic>? kholles}) =>
      $apply(FieldCopyWithData({
        if (student != null) #student: student,
        if (trinomeId != null) #trinomeId: trinomeId,
        if (kholles != null) #kholles: kholles
      }));
  @override
  StudentColloscope $make(CopyWithData data) => StudentColloscope(
      data.get(#student, or: $value.student),
      data.get(#trinomeId, or: $value.trinomeId),
      data.get(#kholles, or: $value.kholles));

  @override
  StudentColloscopeCopyWith<$R2, StudentColloscope, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StudentColloscopeCopyWithImpl($value, $cast, t);
}
