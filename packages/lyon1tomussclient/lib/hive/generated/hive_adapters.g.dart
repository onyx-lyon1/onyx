// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class GradeAdapter extends TypeAdapter<Grade> {
  @override
  final typeId = 9;

  @override
  Grade read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Grade(
      title: fields[100] as String,
      author: fields[101] as String,
      date: fields[102] as DateTime?,
      position: (fields[103] as num).toDouble(),
      numerator: fields[2] == null ? 0.0 : (fields[2] as num).toDouble(),
      denominator: fields[3] == null ? 20.0 : (fields[3] as num).toDouble(),
      rank: fields[4] == null ? -1 : (fields[4] as num).toInt(),
      average: fields[5] == null ? 10.0 : (fields[5] as num).toDouble(),
      mediane: fields[6] == null ? 10.0 : (fields[6] as num).toDouble(),
      isValid: fields[8] == null ? false : fields[8] as bool,
      groupeSize: fields[7] == null ? -1 : (fields[7] as num).toInt(),
      children:
          fields[9] == null ? const [] : (fields[9] as List).cast<Grade>(),
      coef: fields[10] == null ? 1.0 : (fields[10] as num).toDouble(),
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
      ..writeByte(9)
      ..write(obj.children)
      ..writeByte(10)
      ..write(obj.coef)
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

class TeachingUnitAdapter extends TypeAdapter<TeachingUnit> {
  @override
  final typeId = 10;

  @override
  TeachingUnit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeachingUnit(
      title: fields[0] == null ? "" : fields[0] as String,
      masters:
          fields[1] == null ? const [] : (fields[1] as List).cast<Teacher>(),
      grades: fields[2] == null ? const [] : (fields[2] as List).cast<Grade>(),
      textValues:
          fields[6] == null ? const [] : (fields[6] as List).cast<TomussText>(),
      enumerations: fields[7] == null
          ? const []
          : (fields[7] as List).cast<Enumeration>(),
      presences:
          fields[8] == null ? const [] : (fields[8] as List).cast<Presence>(),
      stageCodes:
          fields[9] == null ? const [] : (fields[9] as List).cast<StageCode>(),
      uploads:
          fields[10] == null ? const [] : (fields[10] as List).cast<Upload>(),
      urls: fields[11] == null ? const [] : (fields[11] as List).cast<URL>(),
      ticket: fields[12] == null ? "" : fields[12] as String,
      ue: fields[13] == null ? "" : fields[13] as String,
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

class TeachingUnitListAdapter extends TypeAdapter<TeachingUnitList> {
  @override
  final typeId = 11;

  @override
  TeachingUnitList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeachingUnitList(
      (fields[0] as List).cast<TeachingUnit>(),
      (fields[1] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, TeachingUnitList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.teachingUnitModels)
      ..writeByte(1)
      ..write(obj.semesterIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeachingUnitListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TeacherAdapter extends TypeAdapter<Teacher> {
  @override
  final typeId = 12;

  @override
  Teacher read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Teacher(
      name: fields[0] == null ? "" : fields[0] as String,
      email: fields[1] == null ? "" : fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Teacher obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeacherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SemesterAdapter extends TypeAdapter<Semester> {
  @override
  final typeId = 13;

  @override
  Semester read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Semester(
      title: fields[0] == null ? "" : fields[0] as String,
      url: fields[1] == null ? "" : fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Semester obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SemesterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SemesterListAdapter extends TypeAdapter<SemesterList> {
  @override
  final typeId = 14;

  @override
  SemesterList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SemesterList(
      (fields[0] as List).cast<Semester>(),
      currentSemesterIndex: fields[1] == null ? 0 : (fields[1] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, SemesterList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.semestres)
      ..writeByte(1)
      ..write(obj.currentSemesterIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SemesterListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EnumerationAdapter extends TypeAdapter<Enumeration> {
  @override
  final typeId = 25;

  @override
  Enumeration read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Enumeration(
      title: fields[100] as String,
      author: fields[101] as String,
      date: fields[102] as DateTime?,
      position: (fields[103] as num).toDouble(),
      value: fields[1] as String?,
      values: fields[2] == null ? const [] : (fields[2] as List).cast<String>(),
      comment: fields[4] == null ? "" : fields[4] as String,
      theId: fields[6] == null ? "" : fields[6] as String,
      lineId: fields[7] == null ? "" : fields[7] as String,
      ue: fields[8] == null ? "" : fields[8] as String,
      semester: fields[9] == null ? "" : fields[9] as String,
      year: fields[10] == null ? "" : fields[10] as String,
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

class PresenceColorAdapter extends TypeAdapter<PresenceColor> {
  @override
  final typeId = 26;

  @override
  PresenceColor read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PresenceColor.green;
      case 1:
        return PresenceColor.red;
      case 2:
        return PresenceColor.unset;
      default:
        return PresenceColor.green;
    }
  }

  @override
  void write(BinaryWriter writer, PresenceColor obj) {
    switch (obj) {
      case PresenceColor.green:
        writer.writeByte(0);
      case PresenceColor.red:
        writer.writeByte(1);
      case PresenceColor.unset:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PresenceColorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PresenceAdapter extends TypeAdapter<Presence> {
  @override
  final typeId = 27;

  @override
  Presence read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Presence(
      title: fields[100] as String,
      author: fields[101] as String,
      date: fields[102] as DateTime?,
      position: (fields[103] as num).toDouble(),
      value: fields[1] == null ? "" : fields[1] as String,
      emptyIs: fields[3] == null ? "" : fields[3] as String?,
      color:
          fields[4] == null ? PresenceColor.unset : fields[4] as PresenceColor,
      visibilityDate: fields[5] as DateTime?,
      visible: fields[6] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Presence obj) {
    writer
      ..writeByte(9)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(3)
      ..write(obj.emptyIs)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.visibilityDate)
      ..writeByte(6)
      ..write(obj.visible)
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
      other is PresenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StageCodeAdapter extends TypeAdapter<StageCode> {
  @override
  final typeId = 28;

  @override
  StageCode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StageCode(
      title: fields[100] as String,
      author: fields[101] as String,
      date: fields[102] as DateTime?,
      position: (fields[103] as num).toDouble(),
      value: fields[1] == null ? "" : fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StageCode obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.value)
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
      other is StageCodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TomussTextAdapter extends TypeAdapter<TomussText> {
  @override
  final typeId = 29;

  @override
  TomussText read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TomussText(
      title: fields[100] as String,
      author: fields[101] as String,
      date: fields[102] as DateTime?,
      position: (fields[103] as num).toDouble(),
      value: fields[1] == null ? "" : fields[1] as String,
      comment: fields[3] == null ? "" : fields[3] as String,
      isValidText: fields[4] == null ? false : fields[4] as bool,
      isHidden: fields[6] == null ? false : fields[6] as bool,
      theId: fields[7] == null ? "" : fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TomussText obj) {
    writer
      ..writeByte(9)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(3)
      ..write(obj.comment)
      ..writeByte(4)
      ..write(obj.isValidText)
      ..writeByte(6)
      ..write(obj.isHidden)
      ..writeByte(7)
      ..write(obj.theId)
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
      other is TomussTextAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UploadAdapter extends TypeAdapter<Upload> {
  @override
  final typeId = 30;

  @override
  Upload read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Upload(
      title: fields[100] as String,
      author: fields[101] as String,
      date: fields[102] as DateTime?,
      position: (fields[103] as num).toDouble(),
      comment: fields[2] == null ? "" : fields[2] as String,
      uploadMax: fields[3] == null ? 0 : (fields[3] as num).toInt(),
      fileUrl: fields[5] == null ? "" : fields[5] as String,
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

class URLAdapter extends TypeAdapter<URL> {
  @override
  final typeId = 31;

  @override
  URL read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return URL(
      title: fields[100] as String,
      author: fields[101] as String,
      date: fields[102] as DateTime?,
      position: (fields[103] as num).toDouble(),
      value: fields[2] == null ? "" : fields[2] as String,
      isModifiable: fields[3] == null ? false : fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, URL obj) {
    writer
      ..writeByte(6)
      ..writeByte(2)
      ..write(obj.value)
      ..writeByte(3)
      ..write(obj.isModifiable)
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
      other is URLAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StudentAdapter extends TypeAdapter<Student> {
  @override
  final typeId = 43;

  @override
  Student read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Student(
      name: fields[0] == null ? "" : fields[0] as String,
      surname: fields[1] == null ? "" : fields[1] as String,
      email: fields[2] == null ? "" : fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.surname)
      ..writeByte(2)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
