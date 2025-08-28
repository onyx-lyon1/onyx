import 'package:hive_ce/hive.dart';
import 'package:lyon1tomussclient/src/model/enumeration.dart';
import 'package:lyon1tomussclient/src/model/grade.dart';
import 'package:lyon1tomussclient/src/model/presence.dart';
import 'package:lyon1tomussclient/src/model/semester.dart';
import 'package:lyon1tomussclient/src/model/semester_list.dart';
import 'package:lyon1tomussclient/src/model/stage_code.dart';
import 'package:lyon1tomussclient/src/model/student.dart';
import 'package:lyon1tomussclient/src/model/teacher.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit_list.dart';
import 'package:lyon1tomussclient/src/model/tomuss_text.dart';
import 'package:lyon1tomussclient/src/model/upload.dart';
import 'package:lyon1tomussclient/src/model/url.dart';

@GenerateAdapters([
  AdapterSpec<Grade>(),
  AdapterSpec<TeachingUnit>(),
  AdapterSpec<TeachingUnitList>(),
  AdapterSpec<Teacher>(),
  AdapterSpec<Semester>(),
  AdapterSpec<SemesterList>(),
  AdapterSpec<Enumeration>(),
  AdapterSpec<PresenceColor>(),
  AdapterSpec<Presence>(),
  AdapterSpec<StageCode>(),
  AdapterSpec<TomussText>(),
  AdapterSpec<Upload>(),
  AdapterSpec<URL>(),
  AdapterSpec<Student>(),
])
part 'generated/hive_adapters.g.dart';
