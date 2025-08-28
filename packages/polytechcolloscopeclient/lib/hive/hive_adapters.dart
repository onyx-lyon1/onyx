import 'package:hive_ce/hive.dart';
import 'package:polytechcolloscopeclient/src/models/kholle.dart';
import 'package:polytechcolloscopeclient/src/models/student.dart';
import 'package:polytechcolloscopeclient/src/models/student_colloscope.dart';
import 'package:polytechcolloscopeclient/src/models/year.dart';

@GenerateAdapters([
  AdapterSpec<Student>(),
  AdapterSpec<Kholle>(),
  AdapterSpec<StudentColloscope>(),
  AdapterSpec<Year>(),
])
part 'generated/hive_adapters.g.dart';
