import 'package:hive_flutter/hive_flutter.dart';
import 'package:oloid2/screens/mails/domain/model/attachment_model.dart';
import 'package:oloid2/screens/login/domain/model/authentication.dart';
import 'package:oloid2/screens/tomuss/domain/model/grade_model.dart';
import 'package:oloid2/screens/mails/domain/model/mail_model.dart';
import 'package:oloid2/screens/settings/domain/model/settings.dart';
import 'package:oloid2/screens/tomuss/domain/model/teacher_model.dart';
import 'package:oloid2/screens/tomuss/domain/model/school_subject_model.dart';
import 'package:oloid2/screens/mails/domain/model/email_model_wrapper.dart';
import 'package:oloid2/screens/tomuss/domain/model/school_subject_model_wrapper.dart';

import 'package:oloid2/screens/agenda/agenda_includes.dart';


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
  Hive.registerAdapter(SchoolSubjectModelAdapter());
  Hive.registerAdapter(SchoolSubjectModelWrapperAdapter());
  Hive.registerAdapter(AttachmentModelAdapter());
  await Hive.initFlutter();
}