// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get onyx => 'Onyx';

  @override
  String get initialization => 'Initialization';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get onyxSubTitle => 'For Lyon 1';

  @override
  String get authentication => 'Authentication';

  @override
  String get privacy => 'Privacy';

  @override
  String get wrongIdFormat => 'The id is not in the right format';

  @override
  String get discoverApp => 'Discover the app';

  @override
  String get yourAuthentificated => 'You are authenticated';

  @override
  String get loginError => 'Login error';

  @override
  String get fatalError => 'Fatal error';

  @override
  String get error => 'Error';

  @override
  String get casConnexion => 'CAS connection';

  @override
  String get mockUsername => 'Mock username';

  @override
  String get mockPassword => 'Mock password';

  @override
  String get accessingExams => 'Accessing exams';

  @override
  String get errorAccessingExams => 'Error accessing exams';

  @override
  String get mockStudent => 'Mock student';

  @override
  String get mockSchoolSubject => 'Mock school subject';

  @override
  String get mockTutorialLeader => 'Mock tutorial leader';

  @override
  String get mockMessage => 'Mock message';

  @override
  String get mockRoom => 'Mock room';

  @override
  String get mockTitle => 'Mock title';

  @override
  String get mockCodeName => 'Mock code name';

  @override
  String get exams => 'Exams';

  @override
  String get sit => 'sit';

  @override
  String get agendaSelection => 'Select the agenda';

  @override
  String get enabled => 'Enabled';

  @override
  String get disabled => 'Disabled';

  @override
  String get settings => 'Settings';

  @override
  String get showMiniCalendar => 'Show the mini calendar at the top of the page';

  @override
  String get calendarUpdateNotification => 'Notification in case of calendar update';

  @override
  String get agendaPageBottomToTop => 'Display the agendas from bottom to top';

  @override
  String get agendaWeekLength => 'Number of days displayed in week mode';

  @override
  String get agendaWeekReference => 'Reference day in week mode';

  @override
  String get today => 'Today';

  @override
  String get agendaWeekReferenceAlignement => 'Reference day alignment';

  @override
  String get disabledDays => 'Hidden days';

  @override
  String get cantHideAllDays => 'You can\'t hide all the days';

  @override
  String get root => 'Root';

  @override
  String get folder => 'Folder';

  @override
  String get subFolder => 'Sub folder';

  @override
  String get anotherRoot => 'Another root';

  @override
  String get loadingAgendaList => 'Loading agenda list';

  @override
  String get errorAppeared => 'An error appeared';

  @override
  String get searchInCalendars => 'Search in calendars';

  @override
  String get needCameraToScanQrCode => 'We need the camera to scan the QR code';

  @override
  String get forLyon1 => 'For Lyon 1';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get pleaseEnterUsername => 'Please enter the username';

  @override
  String get pleaseEnterAValidEmail => 'Please enter a valid email';

  @override
  String get pleaseEnterPassword => 'Please enter the password';

  @override
  String get passwordShouldBeANumber => 'The password should be a number';

  @override
  String get connecting => 'Connecting';

  @override
  String get thereWasAnErrorWhileConnecting => 'There was an error while connecting';

  @override
  String get loading => 'Loading...';

  @override
  String available(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString Qr Codes available',
      one: '1 Qr Code available',
      zero: 'No QR Code available',
    );
    return '$_temp0';
  }

  @override
  String get qrCode => 'QR Code';

  @override
  String get offline => 'Offline';

  @override
  String get izly => 'Izly';

  @override
  String get youAreNotConnectedToIzly => 'You are not connected to Izly';

  @override
  String get paymentHistory => 'Payment history';

  @override
  String get refillWithBankCard => 'Refill with bank card';

  @override
  String get refillWithBankTransfer => 'Refill with bank transfer';

  @override
  String get pay => 'Pay';

  @override
  String get pleaseSelectAnAmount => 'Please enter an amount';

  @override
  String minimumAmountIs(int countEuros) {
    final intl.NumberFormat countEurosNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countEurosString = countEurosNumberFormat.format(countEuros);

    return 'The minimum amount is $countEurosString€';
  }

  @override
  String get bankTransfer => 'Bank transfer';

  @override
  String get bankCard => 'Bank card';

  @override
  String get thirdParty => 'Third party';

  @override
  String get mail => 'Mail';

  @override
  String get message => 'Message';

  @override
  String get transfer => 'Transfer';

  @override
  String get recharging => 'Recharging';

  @override
  String get pleaseWait => 'Please wait';

  @override
  String get from => 'From';

  @override
  String get to => 'To';

  @override
  String get me => 'Me';

  @override
  String get mailSendPageErrorTitle => 'Please fill all the fields correctly';

  @override
  String get subject => 'subject';

  @override
  String get reply => 'Reply';

  @override
  String get mailServerConnection => 'Mail server connection';

  @override
  String get mailServerConnectionError => 'Mail server connection error';

  @override
  String get loadingMails => 'Loading mails';

  @override
  String get errorOccured => 'An error occured';

  @override
  String get sendingEmail => 'Sending email';

  @override
  String get loadMoreMails => 'Load 20 more mails';

  @override
  String get tomussConnection => 'Tomuss connection';

  @override
  String get loadingGrades => 'Loading grades';

  @override
  String get loadingGradesError => 'Loading grades error';

  @override
  String get newEvent => 'New event';

  @override
  String nDayModified(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'You have $countString modified days',
      one: 'You have 1 modified day',
      zero: 'You have no modified days',
    );
    return '$_temp0';
  }

  @override
  String newEventAt(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'You have a new event on: \$$dateString';
  }

  @override
  String get newEmail => 'New email';

  @override
  String youHaveANewEmail(String sender, String excerpt) {
    return 'You have a new email from $sender \n\n $excerpt';
  }

  @override
  String get defaultSemester => 'Default semester';

  @override
  String get newGrade => 'New grade';

  @override
  String youHaveANewGrade(double numerator, double denominator, String title) {
    final intl.NumberFormat numeratorNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String numeratorString = numeratorNumberFormat.format(numerator);
    final intl.NumberFormat denominatorNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String denominatorString = denominatorNumberFormat.format(denominator);

    return 'You got $numeratorString/$denominatorString in: $title';
  }

  @override
  String get grades => 'Grades';

  @override
  String get agenda => 'Agenda';

  @override
  String get mails => 'Mails';

  @override
  String get map => 'Map';

  @override
  String get ok => 'Ok';

  @override
  String get warningSelectShouldAgenda => 'The agenda is automatically selected. This can be inaccurate,\nespecially for Polytech students.\nDon\'t hesitate to select it manually in the settings.';

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String get dataCollection => 'Data collection';

  @override
  String get dataSafety => 'Data safety';

  @override
  String get contactUs => 'Contact us';

  @override
  String get weTakeCareOfYourData => 'Our application is designed to provide online access to the services of the University of Lyon 1. We take the protection of your personal information seriously and we are committed to ensuring the confidentiality of your information.';

  @override
  String get dataOnlyStoredOnYourDevice => 'Our application does not collect any personal information. Login data is stored only on the user\'s phone and is only communicated with the university\'s servers, for which we are not responsible.';

  @override
  String get ourSecurityMeasures => 'We take reasonable security measures to protect your personal information against loss, misuse, unauthorized access, modification and disclosure. Nevertheless, no method of transmission over the Internet or electronic storage is 100% secure. Therefore, while we strive to protect your personal information, we cannot guarantee the absolute security of your information transmitted to our application and you do so at your own risk.';

  @override
  String get modificationOfThePrivacyPolicy => 'Modification of this privacy policy';

  @override
  String get weCanModifyRules => 'We reserve the right to modify this privacy policy from time to time. Any changes will be posted on this page and will take effect immediately upon posting. It is your responsibility to check this page regularly to keep up to date with any changes to our privacy policy.';

  @override
  String get ifQuestionThenGithub => 'If you have any questions about this privacy policy, please contact us on github';

  @override
  String kholleOf(String teacher) {
    return 'Kholle of $teacher';
  }

  @override
  String examOf(String title) {
    return 'Exam: $title';
  }

  @override
  String examLocationPlace(String location, num place) {
    final intl.NumberFormat placeNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String placeString = placeNumberFormat.format(place);

    return '$location, place: $placeString';
  }

  @override
  String get warning => 'Warning';

  @override
  String get loadingAgenda => 'Loading agenda';

  @override
  String get agendaError => 'Error while loading the agenda';

  @override
  String get monthViewSoon => 'The month view is coming soon';

  @override
  String get eventDetails => 'Event details';

  @override
  String get loadingBuildings => 'Loading buildings';

  @override
  String get route => 'Route';

  @override
  String weekNumberShort(int weekNumber) {
    final intl.NumberFormat weekNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String weekNumberString = weekNumberNumberFormat.format(weekNumber);

    return 'W: $weekNumberString';
  }

  @override
  String get inbox => 'Inbox';

  @override
  String get archive => 'Archive';

  @override
  String get delete => 'Delete';

  @override
  String get toArchive => 'To archive';

  @override
  String get markAsReadUnread => 'Mark as read/unread';

  @override
  String get moveTo => 'Move to';

  @override
  String get markAsImportant => 'Mark as important';

  @override
  String searchInTheNLastEmails(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    return 'Search in the last $countString emails';
  }

  @override
  String minuteCompact(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '${minutesString}min';
  }

  @override
  String hourCompact(int hours) {
    final intl.NumberFormat hoursNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String hoursString = hoursNumberFormat.format(hours);

    return '${hoursString}h';
  }

  @override
  String dayCompact(int days) {
    final intl.NumberFormat daysNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String daysString = daysNumberFormat.format(days);

    return '${daysString}d';
  }

  @override
  String get now => 'Now';

  @override
  String flagedEmail(String subject) {
    return 'Flagged email: $subject';
  }

  @override
  String unflagedEmail(String subject) {
    return 'Unflagged email: $subject';
  }

  @override
  String get addAttachment => 'Add attachment';

  @override
  String get deleteAttachmentConfirmation => 'Delete the attachment?';

  @override
  String get cancel => 'Cancel';

  @override
  String get emailAddressHint => 'Recipient: PXXXXXXX, firstName.surname@status.univ-lyon1.fr';

  @override
  String get building => 'Building';

  @override
  String menuOf(String restaurant) {
    return 'Menu of $restaurant';
  }

  @override
  String get noMenuForThisRestaurant => 'No menu for this restaurant';

  @override
  String get close => 'Close';

  @override
  String get system => 'System';

  @override
  String get dark => 'Dark';

  @override
  String get light => 'Light';

  @override
  String get chooseTheme => 'Choose the theme';

  @override
  String get cache => 'Cache';

  @override
  String get clearIzlyCache => 'Clear Izly cache';

  @override
  String get notifications => 'Notifications';

  @override
  String get checkForNewNotifications => 'Check for new notifications';

  @override
  String get changeTheme => 'Change theme';

  @override
  String get favoriteTheme => 'Favorite theme';

  @override
  String get lightTheme => 'Light theme';

  @override
  String get darkTheme => 'Dark theme';

  @override
  String get examenAddToAgenda => 'Add exams to calendar';

  @override
  String get enableColloscope => 'Enable Colloscope';

  @override
  String get forceYear => 'Force year';

  @override
  String forceYearValue(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '${countString}th year',
      one: '1st year',
      zero: 'Automatic',
    );
    return '$_temp0';
  }

  @override
  String get forceStudentId => 'Force an ID';

  @override
  String get emptyToDisable => '(empty to disable)';

  @override
  String get yetNothingToConfigure => 'Nothing to configure yet';

  @override
  String get enablebiometricAuth => 'Enable fingerprint authentication';

  @override
  String get unableToEnableBiometricAuth => 'Unable to enable fingerprint authentication';

  @override
  String get enableBiometricAuthDisableNotifications => 'Fingerprint authentication disables notifications';

  @override
  String get autoChangeTheme => 'Automatically change to the selected theme';

  @override
  String get recentGradeDuration => 'Duration of a recent note';

  @override
  String nDays(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString days',
      one: '1 day',
      zero: '0 day',
    );
    return '$_temp0';
  }

  @override
  String get selectSemester => 'Select a semester';

  @override
  String noteDescription(double average, double mediane, int rank, int groupeSize, String author) {
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

    return 'Average: $averageString · Median: $medianeString\nRanking: $rankString/$groupeSizeString\nTeacher: $author';
  }

  @override
  String get tomuss => 'Tomuss';

  @override
  String hereMyGrade(String title) {
    return 'Here is my grade in $title';
  }

  @override
  String get darkDefault => 'Dark (default)';

  @override
  String get lightDefault => 'Light (default)';

  @override
  String get nichiHachi => 'Nichi Hachi';

  @override
  String get blueSky => 'Blue sky';

  @override
  String get ultrakill => 'ULTRAKILL';

  @override
  String get stardewValley => 'Stardew Valley';

  @override
  String get badApple => 'Bad Apple';

  @override
  String get moonLight => 'Moon Light';

  @override
  String eventSubtitle(String duration, String location) {
    return '$duration · $location';
  }

  @override
  String get pleaseEnterId => 'Please enter an id';

  @override
  String get general => 'General';

  @override
  String get clearGradeCache => 'Clear grade cache';

  @override
  String get clearAgendaCache => 'Clear agenda cache';

  @override
  String get clearEmailCache => 'Clear email cache';

  @override
  String get fetchAgendaAuto => 'Automatically fetch the agenda';

  @override
  String get notifIfNewEmail => 'Notification in case of new email';

  @override
  String get forceMailTheme => 'Force the mail theme';

  @override
  String get blockTrackers => 'Block trackers';

  @override
  String get logoutIzly => 'Log out of Izly';

  @override
  String get notifIfNewGrade => 'Notification in case of new grade';

  @override
  String get forceGreenGrade => 'Forcibly set the grades to green';

  @override
  String get showHiddenUE => 'Show hidden UEs';

  @override
  String get modify => 'Modify';

  @override
  String get pleaseSelectOutputFile => 'Please select an output file';

  @override
  String get unableToOpenLink => 'Unable to open the link';

  @override
  String get chooseLanguage => 'Select the language';

  @override
  String get auto => 'Automatic';

  @override
  String get realyQuit => 'Do you really want to quit?';

  @override
  String get response => 'Response';

  @override
  String get enableIzlyNotif => 'Enable Izly notifications';

  @override
  String get izlyNotEnoughMoneyTitle => 'Your Izly balance is low';

  @override
  String izlyNotEnoughMoneyBody(double money) {
    final intl.NumberFormat moneyNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String moneyString = moneyNumberFormat.format(money);

    return 'There is \$$moneyString€ left on your Izly account';
  }

  @override
  String get mailSendPageDiscardTitle => 'Discard the email?';

  @override
  String get mailSendPageDiscardContent => 'Do you really want to discard the email?';

  @override
  String get discard => 'Discard';

  @override
  String get more => 'More';

  @override
  String get unHideQrCode => 'Click to\nunhide the QR code';
}
