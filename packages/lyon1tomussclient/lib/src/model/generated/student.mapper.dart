// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../student.dart';

class StudentMapper extends ClassMapperBase<Student> {
  StudentMapper._();

  static StudentMapper? _instance;
  static StudentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StudentMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Student';

  static String _$name(Student v) => v.name;
  static const Field<Student, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: "",
  );
  static String _$surname(Student v) => v.surname;
  static const Field<Student, String> _f$surname = Field(
    'surname',
    _$surname,
    opt: true,
    def: "",
  );
  static String _$email(Student v) => v.email;
  static const Field<Student, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
    def: "",
  );

  @override
  final MappableFields<Student> fields = const {
    #name: _f$name,
    #surname: _f$surname,
    #email: _f$email,
  };

  static Student _instantiate(DecodingData data) {
    return Student(
      name: data.dec(_f$name),
      surname: data.dec(_f$surname),
      email: data.dec(_f$email),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Student fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Student>(map);
  }

  static Student fromJson(String json) {
    return ensureInitialized().decodeJson<Student>(json);
  }
}

mixin StudentMappable {
  String toJson() {
    return StudentMapper.ensureInitialized().encodeJson<Student>(
      this as Student,
    );
  }

  Map<String, dynamic> toMap() {
    return StudentMapper.ensureInitialized().encodeMap<Student>(
      this as Student,
    );
  }

  StudentCopyWith<Student, Student, Student> get copyWith =>
      _StudentCopyWithImpl<Student, Student>(
        this as Student,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return StudentMapper.ensureInitialized().stringifyValue(this as Student);
  }

  @override
  bool operator ==(Object other) {
    return StudentMapper.ensureInitialized().equalsValue(
      this as Student,
      other,
    );
  }

  @override
  int get hashCode {
    return StudentMapper.ensureInitialized().hashValue(this as Student);
  }
}

extension StudentValueCopy<$R, $Out> on ObjectCopyWith<$R, Student, $Out> {
  StudentCopyWith<$R, Student, $Out> get $asStudent =>
      $base.as((v, t, t2) => _StudentCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class StudentCopyWith<$R, $In extends Student, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? surname, String? email});
  StudentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StudentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Student, $Out>
    implements StudentCopyWith<$R, Student, $Out> {
  _StudentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Student> $mapper =
      StudentMapper.ensureInitialized();
  @override
  $R call({String? name, String? surname, String? email}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (surname != null) #surname: surname,
      if (email != null) #email: email,
    }),
  );
  @override
  Student $make(CopyWithData data) => Student(
    name: data.get(#name, or: $value.name),
    surname: data.get(#surname, or: $value.surname),
    email: data.get(#email, or: $value.email),
  );

  @override
  StudentCopyWith<$R2, Student, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _StudentCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

