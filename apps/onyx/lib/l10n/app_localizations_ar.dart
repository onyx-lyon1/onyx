// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get onyx => 'الجزع';

  @override
  String get initialization => 'التهيئة';

  @override
  String get yes => 'نعم';

  @override
  String get no => 'لا';

  @override
  String get onyxSubTitle => 'ل ليون 1';

  @override
  String get authentication => 'المصادقة';

  @override
  String get privacy => 'سرية';

  @override
  String get wrongIdFormat => 'المعرف ليس بالتنسيق الصحيح';

  @override
  String get discoverApp => 'اكتشف التطبيق';

  @override
  String get yourAuthentificated => 'لقد تمت مصادقةك';

  @override
  String get loginError => 'خطأ في الإتصال';

  @override
  String get fatalError => 'خطأ مميت';

  @override
  String get error => 'خطأ';

  @override
  String get casConnexion => 'اتصال بالقضية';

  @override
  String get mockUsername => 'اسم المستخدم المحاكاة';

  @override
  String get mockPassword => 'كلمة المرور المحاكاة';

  @override
  String get accessingExams => 'الوصول إلى الامتحانات';

  @override
  String get errorAccessingExams => 'خطأ عند الوصول إلى الامتحانات';

  @override
  String get mockStudent => 'طالب محاكاة';

  @override
  String get mockSchoolSubject => 'محاكاة';

  @override
  String get mockTutorialLeader => 'مقلد خلور';

  @override
  String get mockMessage => 'رسالة محاكاة';

  @override
  String get mockRoom => 'غرفة محاكاة';

  @override
  String get mockTitle => 'عنوان محاكاة';

  @override
  String get mockCodeName => 'اسم رمز محاكاة';

  @override
  String get exams => 'الامتحانات';

  @override
  String get sit => 'مكان';

  @override
  String get agendaSelection => 'حدد جدول الأعمال';

  @override
  String get enabled => 'نشطة';

  @override
  String get disabled => 'تعطيل';

  @override
  String get settings => 'الإعدادات';

  @override
  String get showMiniCalendar =>
      'إظهار التقويم المصغر في الجزء العلوي من الصفحة';

  @override
  String get calendarUpdateNotification => 'الإخطار في حالة تحديث جدول الأعمال';

  @override
  String get agendaPageBottomToTop => 'عرض جدول الاسبوع من أسفل إلى أعلى';

  @override
  String get agendaWeekLength => 'عدد الأيام المعروضة في الجدول الأسبوعي';

  @override
  String get agendaWeekReference => 'اليوم المرجعي في الوضع الأسبوعي';

  @override
  String get today => 'اليوم';

  @override
  String get agendaWeekReferenceAlignement => 'محاذاة اليوم المرجعي';

  @override
  String get disabledDays => 'أيام خفية';

  @override
  String get cantHideAllDays => 'لا يمكنك الاختباء كل يوم';

  @override
  String get root => 'راسين';

  @override
  String get folder => 'ملف';

  @override
  String get subFolder => 'المجلد الفرعي';

  @override
  String get anotherRoot => 'جذر آخر';

  @override
  String get loadingAgendaList => 'تحميل قائمة جداول الأعمال';

  @override
  String get errorAppeared => 'حدث خطأ';

  @override
  String get searchInCalendars => 'ابحث في جدول أعمال';

  @override
  String get needCameraToScanQrCode =>
      'نحتاج إلى الكاميرا لمسح رمز الاستجابة السريعة';

  @override
  String get forLyon1 => 'ل ليون 1';

  @override
  String get username => 'إسم المستخدم';

  @override
  String get password => 'كلمة السر';

  @override
  String get login => 'login';

  @override
  String get logout => 'logout';

  @override
  String get pleaseEnterUsername => 'الرجاء إدخال الهوية';

  @override
  String get pleaseEnterAValidEmail => 'يرجى إدخال البريد الإلكتروني الصحيح';

  @override
  String get pleaseEnterPassword => 'الرجاء إدخال كلمة المرور';

  @override
  String get passwordShouldBeANumber => 'يجب أن تكون كلمة المرور رقمًا';

  @override
  String get connecting => 'جاري الاتصال';

  @override
  String get thereWasAnErrorWhileConnecting => 'حدث خطأ عند الاتصال';

  @override
  String get loading => 'تحميل ...';

  @override
  String available(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString رموز QR متاحة',
      one: '1 رمز الاستجابة السريعة متاح',
      zero: 'لا يتوفر رمز الاستجابة السريعة',
    );
    return '$_temp0';
  }

  @override
  String get qrCode => 'رمز الاستجابة السريعة';

  @override
  String get offline => 'خارج التغطية';

  @override
  String get izly => 'Izly';

  @override
  String get youAreNotConnectedToIzly => 'لم تكن متصلاً بـ Izly';

  @override
  String get paymentHistory => 'سجل الدفع';

  @override
  String get refillWithBankCard => 'إعادة الشحن ببطاقة مصرفية';

  @override
  String get refillWithBankTransfer => 'النقل عن طريق النقل';

  @override
  String get pay => 'دافع';

  @override
  String get pleaseSelectAnAmount => 'تفضل';

  @override
  String minimumAmountIs(int countEuros) {
    final intl.NumberFormat countEurosNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countEurosString = countEurosNumberFormat.format(countEuros);

    return 'الحد الأدنى للمبلغ هو $countEurosString €';
  }

  @override
  String get bankTransfer => 'قسط';

  @override
  String get bankCard => 'بطاقة بنكية';

  @override
  String get thirdParty => 'إعادة الشحن من قبل طرف ثالث';

  @override
  String get mail => 'بريد';

  @override
  String get message => 'رسالة';

  @override
  String get transfer => 'لينقل';

  @override
  String get recharging => 'مسؤول عن';

  @override
  String get pleaseWait => 'من فضلك انتظر';

  @override
  String get from => 'ل';

  @override
  String get to => 'الى';

  @override
  String get me => 'موي';

  @override
  String get mailSendPageErrorTitle => 'يرجى ملء جميع الحقول بشكل صحيح';

  @override
  String get subject => 'موضوع';

  @override
  String get reply => 'إجابة';

  @override
  String get mailServerConnection => 'اتصال بخادم البريد';

  @override
  String get mailServerConnectionError => 'خطأ في تحميل البريد الإلكتروني';

  @override
  String get loadingMails => 'تحميل';

  @override
  String get errorOccured => 'حدث خطأ';

  @override
  String get sendingEmail => 'إرسال البريد';

  @override
  String get loadMoreMails => 'تحميل 20 رسالة بريد إلكتروني إضافية';

  @override
  String get tomussConnection => 'اتصال توموس';

  @override
  String get loadingGrades => 'تحميل الملاحظات';

  @override
  String get loadingGradesError => 'ملاحظات تحميل الخطأ';

  @override
  String get newEvent => 'حدث جديد';

  @override
  String nDayModified(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'لديك $countString يوما معدلة',
      one: 'لديك يوم واحد تم تعديله',
      zero: 'لم يتم تعديل أي أيام لديك',
    );
    return '$_temp0';
  }

  @override
  String newEventAt(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'لديك حدث جديد: \$ $dateString';
  }

  @override
  String get newEmail => 'بريد إلكتروني جديد';

  @override
  String youHaveANewEmail(String sender, String excerpt) {
    return 'لديك بريد إلكتروني جديد من $sender\n\n $excerpt';
  }

  @override
  String get defaultSemester => 'الفصل الافتراضي';

  @override
  String get newGrade => 'ملاحظة جديدة';

  @override
  String youHaveANewGrade(double numerator, double denominator, String title) {
    final intl.NumberFormat numeratorNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String numeratorString = numeratorNumberFormat.format(numerator);
    final intl.NumberFormat denominatorNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String denominatorString = denominatorNumberFormat.format(
      denominator,
    );

    return 'كان لديك $numeratorString/$denominatorString في: $title';
  }

  @override
  String get grades => 'ملحوظات';

  @override
  String get agenda => 'جدول أعمال';

  @override
  String get mails => 'البريد';

  @override
  String get map => 'خريطة';

  @override
  String get ok => 'نعم';

  @override
  String get warningSelectShouldAgenda =>
      'يتم اختيار جدول الأعمال تلقائيًا.هذا يمكن أن يكون غير دقيق ،\nخاصة لطلاب التكنولوجيا الفنية.\nلا تتردد في تحديدها يدويًا من الإعدادات.';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get dataCollection => 'جمع البيانات';

  @override
  String get dataSafety => 'أمن البيانات';

  @override
  String get contactUs => 'اتصل بنا';

  @override
  String get weTakeCareOfYourData =>
      'تم تصميم تطبيقنا لتوفير الوصول عبر الإنترنت إلى خدمات جامعة ليون 1. نأخذ حماية معلوماتك الشخصية على محمل الجد ونحن مصممون على ضمان سرية معلوماتك.';

  @override
  String get dataOnlyStoredOnYourDevice =>
      'تطبيقنا لا يجمع أي معلومات شخصية.يتم تخزين بيانات الاتصال فقط على هاتف المستخدم ويتم توصيلها فقط مع خوادم الجامعة ، والتي لسنا مسؤولين عنها.';

  @override
  String get ourSecurityMeasures =>
      'نتخذ تدابير أمان معقولة لحماية معلوماتك الشخصية من الخسارة والاستخدام المسيء والوصول غير المصرح به والتعديل والإفصاح.ومع ذلك ، لا توجد طريقة للإرسال على الإنترنت أو التخزين الإلكتروني موثوقًا بنسبة 100 ٪.لذلك ، على الرغم من أننا نحاول حماية معلوماتك الشخصية ، إلا أنه لا يمكننا ضمان الأمان المطلق لمعلوماتك المنقولة إلى تطبيقنا وتقوم بذلك على مسؤوليتك الخاصة.';

  @override
  String get modificationOfThePrivacyPolicy => 'تعديل سياسة الخصوصية هذه';

  @override
  String get weCanModifyRules =>
      'نحن نحتفظ بالحق في تعديل سياسة الخصوصية هذه من وقت لآخر.سيتم نشر أي تعديل على هذه الصفحة وسيؤدي سريانه مباشرة بعد نشره.تقع على عاتقك مسؤولية استشارة هذه الصفحة بانتظام لإبقائك على اطلاع بالتعديلات التي تم إجراؤها على سياسة الخصوصية الخاصة بنا.';

  @override
  String get ifQuestionThenGithub =>
      'إذا كان لديك أي أسئلة حول سياسة الخصوصية هذه ، فيرجى الاتصال بنا على Github';

  @override
  String kholleOf(String teacher) {
    return 'خولة من $teacher';
  }

  @override
  String examOf(String title) {
    return 'الامتحان: $title';
  }

  @override
  String examLocationPlace(String location, num place) {
    final intl.NumberFormat placeNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String placeString = placeNumberFormat.format(place);

    return '$location ، المكان: $placeString';
  }

  @override
  String get warning => 'انتباه';

  @override
  String get loadingAgenda => 'تحميل جدول الأعمال';

  @override
  String get agendaError => 'خطأ عند تحميل جدول الأعمال';

  @override
  String get monthViewSoon => 'العرض الشهري قريب';

  @override
  String get eventDetails => 'تفاصيل الحدث';

  @override
  String get loadingBuildings => 'تحميل المباني';

  @override
  String get route => 'مسار الرحلة';

  @override
  String weekNumberShort(int weekNumber) {
    final intl.NumberFormat weekNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String weekNumberString = weekNumberNumberFormat.format(weekNumber);

    return 'س: $weekNumberString';
  }

  @override
  String get inbox => 'صندوق الاستقبال';

  @override
  String get archive => 'أرشيف';

  @override
  String get delete => 'يمسح';

  @override
  String get toArchive => 'أرشيف';

  @override
  String get markAsReadUnread => 'علامة';

  @override
  String get moveTo => 'متحرك';

  @override
  String get markAsImportant => 'النتيجة بنفس الأهمية';

  @override
  String searchInTheNLastEmails(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    return 'ابحث في $countString رسائل البريد الإلكتروني الأخيرة';
  }

  @override
  String minuteCompact(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '$minutesString دقيقة';
  }

  @override
  String hourCompact(int hours) {
    final intl.NumberFormat hoursNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String hoursString = hoursNumberFormat.format(hours);

    return '$hoursString ح';
  }

  @override
  String dayCompact(int days) {
    final intl.NumberFormat daysNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String daysString = daysNumberFormat.format(days);

    return '$daysString j';
  }

  @override
  String get now => 'الآن';

  @override
  String flagedEmail(String subject) {
    return 'تم وضع علامة على البريد: $subject';
  }

  @override
  String unflagedEmail(String subject) {
    return 'البريد الإلكتروني غير المميز: $subject';
  }

  @override
  String get addAttachment => 'إضافة مرفق';

  @override
  String get deleteAttachmentConfirmation => 'إزالة المرفق؟';

  @override
  String get cancel => 'يلغي';

  @override
  String get emailAddressHint =>
      'المستلم: pxxxxxxxx ، name.nom@status.univ-lyon1.fr';

  @override
  String get building => 'مبنى';

  @override
  String menuOf(String restaurant) {
    return 'قائمة DE $restaurant';
  }

  @override
  String get noMenuForThisRestaurant => 'لا توجد قائمة لهذا المطعم';

  @override
  String get close => 'اغلاق';

  @override
  String get system => 'نظام';

  @override
  String get dark => 'غامق';

  @override
  String get light => 'فاتح';

  @override
  String get chooseTheme => 'اختر السمة';

  @override
  String get cache => 'مخبأ';

  @override
  String get clearIzlyCache => 'تفريغ ذاكرة التخزين المؤقت لـ Izly';

  @override
  String get notifications => 'إشعارات';

  @override
  String get checkForNewNotifications => 'تحقق من الإشعارات الجديدة';

  @override
  String get changeTheme => 'غير الخلفية';

  @override
  String get favoriteTheme => 'الموضوع المفضل';

  @override
  String get lightTheme => 'موضوع واضح';

  @override
  String get darkTheme => 'موضوع مظلم';

  @override
  String get examenAddToAgenda => 'أضف الامتحانات إلى جدول الأعمال';

  @override
  String get enableColloscope => 'تفعيل الكولوسكوب';

  @override
  String get forceYear => 'فرض العام';

  @override
  String forceYearValue(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'السنة $countString',
      one: 'السنة الأولى',
      zero: 'تلقائي',
    );
    return '$_temp0';
  }

  @override
  String get forceStudentId => 'فرض ID';

  @override
  String get emptyToDisable => '(فارغة لإلغاء التنشيط)';

  @override
  String get yetNothingToConfigure => 'لا شيء لتكوينه في الوقت الحالي';

  @override
  String get enablebiometricAuth => 'تنشيط مصادقة البصمة';

  @override
  String get unableToEnableBiometricAuth => 'من المستحيل تنشيط مصادقة البصمات';

  @override
  String get enableBiometricAuthDisableNotifications =>
      'مصادقة بصمة الرقمية تعطل الإخطارات';

  @override
  String get autoChangeTheme => 'التغيير تلقائيا إلى السمة المحددة';

  @override
  String get recentGradeDuration => 'مدة الدرجة الحديثة';

  @override
  String nDays(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString ايام',
      one: '1 يوم',
      zero: '0 يوم',
    );
    return '$_temp0';
  }

  @override
  String get selectSemester => 'حدد الفصل الدراسي';

  @override
  String noteDescription(
    double average,
    double mediane,
    int rank,
    int groupeSize,
    String author,
  ) {
    final intl.NumberFormat averageNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String averageString = averageNumberFormat.format(average);
    final intl.NumberFormat medianeNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String medianeString = medianeNumberFormat.format(mediane);
    final intl.NumberFormat rankNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String rankString = rankNumberFormat.format(rank);
    final intl.NumberFormat groupeSizeNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String groupeSizeString = groupeSizeNumberFormat.format(groupeSize);

    return 'المتوسط: $averageString · الوسيط: $medianeString\nالترتيب: $rankString/$groupeSizeString\nالبروفيسور: $author';
  }

  @override
  String get tomuss => 'توموس';

  @override
  String hereMyGrade(String title) {
    return 'هنا ملاحظتي في $title';
  }

  @override
  String get darkDefault => 'الظلام (افتراضي)';

  @override
  String get lightDefault => 'واضح (افتراضي)';

  @override
  String get nichiHachi => 'اليوم 8';

  @override
  String get blueSky => 'سماء زرقاء';

  @override
  String get ultrakill => 'قتل المتطرف';

  @override
  String get stardewValley => 'وادي ستاردو';

  @override
  String get badApple => 'تفاحة فاسدة';

  @override
  String get moonLight => 'ضوء القمر';

  @override
  String eventSubtitle(String duration, String location) {
    return '$duration • $location';
  }

  @override
  String get pleaseEnterId => 'الرجاء إدخال المعرف';

  @override
  String get general => 'عام';

  @override
  String get clearGradeCache => 'تفريغ ذاكرة التخزين المؤقت للدرجات';

  @override
  String get clearAgendaCache => 'تفريغ ذاكرة التخزين المؤقت لجدول الأعمال';

  @override
  String get clearEmailCache => 'تفريغ ذاكرة التخزين المؤقت للبريد الإلكتروني';

  @override
  String get fetchAgendaAuto => 'استعادة جدول الأعمال تلقائيًا';

  @override
  String get notifIfNewEmail => 'الإخطار في حالة بريد إلكتروني جديد';

  @override
  String get forceMailTheme => 'فرض موضوع رسائل البريد الإلكتروني';

  @override
  String get blockTrackers => 'منع التعقب';

  @override
  String get logoutIzly => 'فصل Izly';

  @override
  String get notifIfNewGrade => 'الإخطار في حالة وجود ملاحظة جديدة';

  @override
  String get forceGreenGrade => 'تحجب الدرجات باللون الأخضر';

  @override
  String get showHiddenUE => 'عرض EUS المخفية';

  @override
  String get modify => 'المعدل';

  @override
  String get pleaseSelectOutputFile => 'الرجاء تحديد ملف الإخراج';

  @override
  String get unableToOpenLink => 'من المستحيل فتح الرابط';

  @override
  String get chooseLanguage => 'اختر اللغة';

  @override
  String get auto => 'تلقائي';

  @override
  String get realyQuit => 'حقيقة تريد الاستقالة؟';

  @override
  String get response => 'استجابة';

  @override
  String get enableIzlyNotif => 'تمكين إخطارات Izly';

  @override
  String get izlyNotEnoughMoneyTitle => 'رصيد حساب إيزلي منخفض';

  @override
  String izlyNotEnoughMoneyBody(double money) {
    final intl.NumberFormat moneyNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String moneyString = moneyNumberFormat.format(money);

    return 'لديك فقط $moneyString€ متبقية في حساب إيزلي الخاص بك';
  }

  @override
  String get mailSendPageDiscardTitle => 'تجاهل التغييرات؟';

  @override
  String get mailSendPageDiscardContent =>
      'هل تريد بالتأكيد تجاهل التغييرات التي أدخلتها؟';

  @override
  String get discard => 'غادر';

  @override
  String get more => 'أكثر';

  @override
  String get unHideQrCode => 'إظهار رمز الاستجابة السريعة';
}
