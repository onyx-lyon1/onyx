import 'package:hive_flutter/hive_flutter.dart';
import 'package:oloid2/model/authentication.dart';
import 'package:oloid2/model/day_model.dart';
import 'package:oloid2/model/event_model.dart';
import 'package:oloid2/model/grade_model.dart';
import 'package:oloid2/model/mail_model.dart';
import 'package:oloid2/model/settings.dart';
import 'package:oloid2/model/teacher_model.dart';
import 'package:oloid2/model/teaching_unit.dart';
import 'package:oloid2/model/text_model.dart';
import 'package:oloid2/model/wrapper/day_model_wrapper.dart';
import 'package:oloid2/model/wrapper/email_model_wrapper.dart';
import 'package:oloid2/model/wrapper/teaching_unit_model_wrapper.dart';

Future<void> hiveInit() async{
  Hive.registerAdapter(AuthenticationAdapter());
  Hive.registerAdapter(DayModelAdapter());
  Hive.registerAdapter(DayModelWrapperAdapter());
  Hive.registerAdapter(EventModelAdapter());
  Hive.registerAdapter(GradeModelAdapter());
  Hive.registerAdapter(EmailModelAdapter());
  Hive.registerAdapter(EmailModelWrapperAdapter());
  Hive.registerAdapter(SettingsModelAdapter());
  Hive.registerAdapter(TeacherModelAdapter());
  Hive.registerAdapter(TeachingUnitModelAdapter());
  Hive.registerAdapter(TeachingUnitModelWrapperAdapter());
  Hive.registerAdapter(TextModelAdapter());
  await Hive.initFlutter();
}