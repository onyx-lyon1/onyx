import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('fr'),
    Locale('ar'),
    Locale('en'),
    Locale('ru')
  ];

  /// The Name of the app
  ///
  /// In en, this message translates to:
  /// **'Onyx'**
  String get onyx;

  /// Initialization
  ///
  /// In en, this message translates to:
  /// **'Initialization'**
  String get initialization;

  /// Yes
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// The subtitle under the name Onyx
  ///
  /// In en, this message translates to:
  /// **'For Lyon 1'**
  String get onyxSubTitle;

  /// Authentication
  ///
  /// In en, this message translates to:
  /// **'Authentication'**
  String get authentication;

  /// Privacy
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// The id is not in the right format
  ///
  /// In en, this message translates to:
  /// **'The id is not in the right format'**
  String get wrongIdFormat;

  /// Discover the app
  ///
  /// In en, this message translates to:
  /// **'Discover the app'**
  String get discoverApp;

  /// You are authenticated
  ///
  /// In en, this message translates to:
  /// **'You are authenticated'**
  String get yourAuthentificated;

  /// Login error
  ///
  /// In en, this message translates to:
  /// **'Login error'**
  String get loginError;

  /// Fatal error
  ///
  /// In en, this message translates to:
  /// **'Fatal error'**
  String get fatalError;

  /// Error
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// CAS connection
  ///
  /// In en, this message translates to:
  /// **'CAS connection'**
  String get casConnexion;

  /// Mock username
  ///
  /// In en, this message translates to:
  /// **'Mock username'**
  String get mockUsername;

  /// Mock password
  ///
  /// In en, this message translates to:
  /// **'Mock password'**
  String get mockPassword;

  /// Accessing exams
  ///
  /// In en, this message translates to:
  /// **'Accessing exams'**
  String get accessingExams;

  /// Error accessing exams
  ///
  /// In en, this message translates to:
  /// **'Error accessing exams'**
  String get errorAccessingExams;

  /// Mock student
  ///
  /// In en, this message translates to:
  /// **'Mock student'**
  String get mockStudent;

  /// Mock school subject
  ///
  /// In en, this message translates to:
  /// **'Mock school subject'**
  String get mockSchoolSubject;

  /// Mock tutorial leader
  ///
  /// In en, this message translates to:
  /// **'Mock tutorial leader'**
  String get mockTutorialLeader;

  /// Mock message
  ///
  /// In en, this message translates to:
  /// **'Mock message'**
  String get mockMessage;

  /// Mock room
  ///
  /// In en, this message translates to:
  /// **'Mock room'**
  String get mockRoom;

  /// Mock title
  ///
  /// In en, this message translates to:
  /// **'Mock title'**
  String get mockTitle;

  /// Mock code name
  ///
  /// In en, this message translates to:
  /// **'Mock code name'**
  String get mockCodeName;

  /// Exams
  ///
  /// In en, this message translates to:
  /// **'Exams'**
  String get exams;

  /// Sit (in a room or amphitheater)
  ///
  /// In en, this message translates to:
  /// **'sit'**
  String get sit;

  /// Select the agenda
  ///
  /// In en, this message translates to:
  /// **'Select the agenda'**
  String get agendaSelection;

  /// Enabled
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// Disabled
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabled;

  /// Settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Show the mini calendar at the top of the page
  ///
  /// In en, this message translates to:
  /// **'Show the mini calendar at the top of the page'**
  String get showMiniCalendar;

  /// Notification in case of calendar update
  ///
  /// In en, this message translates to:
  /// **'Notification in case of calendar update'**
  String get calendarUpdateNotification;

  /// Display the agendas from bottom to top
  ///
  /// In en, this message translates to:
  /// **'Display the agendas from bottom to top'**
  String get agendaPageBottomToTop;

  /// Number of days displayed in week mode
  ///
  /// In en, this message translates to:
  /// **'Number of days displayed in week mode'**
  String get agendaWeekLength;

  /// Reference day in week mode
  ///
  /// In en, this message translates to:
  /// **'Reference day in week mode'**
  String get agendaWeekReference;

  /// Today
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Reference day alignment
  ///
  /// In en, this message translates to:
  /// **'Reference day alignment'**
  String get agendaWeekReferenceAlignement;

  /// Hidden days
  ///
  /// In en, this message translates to:
  /// **'Hidden days'**
  String get disabledDays;

  /// You can''t hide all the days
  ///
  /// In en, this message translates to:
  /// **'You can\'\'t hide all the days'**
  String get cantHideAllDays;

  /// Root
  ///
  /// In en, this message translates to:
  /// **'Root'**
  String get root;

  /// Folder
  ///
  /// In en, this message translates to:
  /// **'Folder'**
  String get folder;

  /// Sub folder
  ///
  /// In en, this message translates to:
  /// **'Sub folder'**
  String get subFolder;

  /// Another root
  ///
  /// In en, this message translates to:
  /// **'Another root'**
  String get anotherRoot;

  /// Loading agenda list
  ///
  /// In en, this message translates to:
  /// **'Loading agenda list'**
  String get loadingAgendaList;

  /// An error appeared
  ///
  /// In en, this message translates to:
  /// **'An error appeared'**
  String get errorAppeared;

  /// Search in calendars
  ///
  /// In en, this message translates to:
  /// **'Search in calendars'**
  String get searchInCalendars;

  /// We need the camera to scan the QR code
  ///
  /// In en, this message translates to:
  /// **'We need the camera to scan the QR code'**
  String get needCameraToScanQrCode;

  /// For Lyon 1
  ///
  /// In en, this message translates to:
  /// **'For Lyon 1'**
  String get forLyon1;

  /// Username
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// Password
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Login
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Logout
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Please enter the username
  ///
  /// In en, this message translates to:
  /// **'Please enter the username'**
  String get pleaseEnterUsername;

  /// Please enter a valid email
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get pleaseEnterAValidEmail;

  /// Please enter the password
  ///
  /// In en, this message translates to:
  /// **'Please enter the password'**
  String get pleaseEnterPassword;

  /// The password should be a number
  ///
  /// In en, this message translates to:
  /// **'The password should be a number'**
  String get passwordShouldBeANumber;

  /// Connecting
  ///
  /// In en, this message translates to:
  /// **'Connecting'**
  String get connecting;

  /// There was an error while connecting
  ///
  /// In en, this message translates to:
  /// **'There was an error while connecting'**
  String get thereWasAnErrorWhileConnecting;

  /// Loading
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Available
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0 {No QR Code available} =1 {1 Qr Code available} other {{count} Qr Codes available}}'**
  String available(int count);

  /// QR Code
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get qrCode;

  /// Offline
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// Izly
  ///
  /// In en, this message translates to:
  /// **'Izly'**
  String get izly;

  /// You are not connected to Izly
  ///
  /// In en, this message translates to:
  /// **'You are not connected to Izly'**
  String get youAreNotConnectedToIzly;

  /// Payment history
  ///
  /// In en, this message translates to:
  /// **'Payment history'**
  String get paymentHistory;

  /// Refill with bank card
  ///
  /// In en, this message translates to:
  /// **'Refill with bank card'**
  String get refillWithBankCard;

  /// Refill with bank transfer
  ///
  /// In en, this message translates to:
  /// **'Refill with bank transfer'**
  String get refillWithBankTransfer;

  /// Pay
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// Please enter an amount
  ///
  /// In en, this message translates to:
  /// **'Please enter an amount'**
  String get pleaseSelectAnAmount;

  /// The minimum amount is {countEuros}€
  ///
  /// In en, this message translates to:
  /// **'The minimum amount is {countEuros}€'**
  String minimumAmountIs(int countEuros);

  /// Bank transfer
  ///
  /// In en, this message translates to:
  /// **'Bank transfer'**
  String get bankTransfer;

  /// Bank card
  ///
  /// In en, this message translates to:
  /// **'Bank card'**
  String get bankCard;

  /// Third party
  ///
  /// In en, this message translates to:
  /// **'Third party'**
  String get thirdParty;

  /// Mail
  ///
  /// In en, this message translates to:
  /// **'Mail'**
  String get mail;

  /// Message
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// Transfer
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer;

  /// Recharging
  ///
  /// In en, this message translates to:
  /// **'Recharging'**
  String get recharging;

  /// Please wait
  ///
  /// In en, this message translates to:
  /// **'Please wait'**
  String get pleaseWait;

  /// From
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// To
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// Me
  ///
  /// In en, this message translates to:
  /// **'Me'**
  String get me;

  /// Please fill all the fields correctly
  ///
  /// In en, this message translates to:
  /// **'Please fill all the fields correctly'**
  String get mailSendPageErrorTitle;

  /// subject
  ///
  /// In en, this message translates to:
  /// **'subject'**
  String get subject;

  /// Reply
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get reply;

  /// Mail server connection
  ///
  /// In en, this message translates to:
  /// **'Mail server connection'**
  String get mailServerConnection;

  /// Mail server connection error
  ///
  /// In en, this message translates to:
  /// **'Mail server connection error'**
  String get mailServerConnectionError;

  /// Loading mails
  ///
  /// In en, this message translates to:
  /// **'Loading mails'**
  String get loadingMails;

  /// An error occured
  ///
  /// In en, this message translates to:
  /// **'An error occured'**
  String get errorOccured;

  /// Sending email
  ///
  /// In en, this message translates to:
  /// **'Sending email'**
  String get sendingEmail;

  /// Load 20 more mails
  ///
  /// In en, this message translates to:
  /// **'Load 20 more mails'**
  String get loadMoreMails;

  /// Tomuss connection
  ///
  /// In en, this message translates to:
  /// **'Tomuss connection'**
  String get tomussConnection;

  /// Loading grades
  ///
  /// In en, this message translates to:
  /// **'Loading grades'**
  String get loadingGrades;

  /// Loading grades error
  ///
  /// In en, this message translates to:
  /// **'Loading grades error'**
  String get loadingGradesError;

  /// New event
  ///
  /// In en, this message translates to:
  /// **'New event'**
  String get newEvent;

  /// You have {count} modified days
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0 {You have no modified days} =1 {You have 1 modified day} other {You have {count} modified days}}'**
  String nDayModified(int count);

  /// You have a new event at : ${date}
  ///
  /// In en, this message translates to:
  /// **'You have a new event on: \${date}'**
  String newEventAt(DateTime date);

  /// New email
  ///
  /// In en, this message translates to:
  /// **'New email'**
  String get newEmail;

  /// You have a new email from {sender}
  ///
  ///  {excerpt}
  ///
  /// In en, this message translates to:
  /// **'You have a new email from {sender} \n\n {excerpt}'**
  String youHaveANewEmail(String sender, String excerpt);

  /// Default semester
  ///
  /// In en, this message translates to:
  /// **'Default semester'**
  String get defaultSemester;

  /// New grade
  ///
  /// In en, this message translates to:
  /// **'New grade'**
  String get newGrade;

  /// You have a new grade : {numerator}/{denominator} ({title}) in : ${title}
  ///
  /// In en, this message translates to:
  /// **'You got {numerator}/{denominator} in: {title}'**
  String youHaveANewGrade(double numerator, double denominator, String title);

  /// Grades
  ///
  /// In en, this message translates to:
  /// **'Grades'**
  String get grades;

  /// Agenda
  ///
  /// In en, this message translates to:
  /// **'Agenda'**
  String get agenda;

  /// Mails
  ///
  /// In en, this message translates to:
  /// **'Mails'**
  String get mails;

  /// Map
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// Ok
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// The agenda is automatically selected. It can be wrong,
  /// especially for Polytech students.
  /// Don''t hesitate to select it manually in the settings.
  ///
  /// In en, this message translates to:
  /// **'The agenda is automatically selected. This can be inaccurate,\nespecially for Polytech students.\nDon\'\'t hesitate to select it manually in the settings.'**
  String get warningSelectShouldAgenda;

  /// Privacy policy
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// Data collection
  ///
  /// In en, this message translates to:
  /// **'Data collection'**
  String get dataCollection;

  /// Data safety
  ///
  /// In en, this message translates to:
  /// **'Data safety'**
  String get dataSafety;

  /// Contact us
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get contactUs;

  /// Our application is designed to provide online access to the services of the University of Lyon 1. We take the protection of your personal information seriously and we are committed to ensuring the confidentiality of your information.
  ///
  /// In en, this message translates to:
  /// **'Our application is designed to provide online access to the services of the University of Lyon 1. We take the protection of your personal information seriously and we are committed to ensuring the confidentiality of your information.'**
  String get weTakeCareOfYourData;

  /// Our application does not collect any personal information. Login data is stored only on the user''s phone and is only communicated with the university''s servers, for which we are not responsible.
  ///
  /// In en, this message translates to:
  /// **'Our application does not collect any personal information. Login data is stored only on the user\'\'s phone and is only communicated with the university\'\'s servers, for which we are not responsible.'**
  String get dataOnlyStoredOnYourDevice;

  /// We take reasonable security measures to protect your personal information against loss, misuse, unauthorized access, modification and disclosure. Nevertheless, no method of transmission over the Internet or electronic storage is 100% secure. Therefore, while we strive to protect your personal information, we cannot guarantee the absolute security of your information transmitted to our application and you do so at your own risk.
  ///
  /// In en, this message translates to:
  /// **'We take reasonable security measures to protect your personal information against loss, misuse, unauthorized access, modification and disclosure. Nevertheless, no method of transmission over the Internet or electronic storage is 100% secure. Therefore, while we strive to protect your personal information, we cannot guarantee the absolute security of your information transmitted to our application and you do so at your own risk.'**
  String get ourSecurityMeasures;

  /// Modification of the privacy policy
  ///
  /// In en, this message translates to:
  /// **'Modification of this privacy policy'**
  String get modificationOfThePrivacyPolicy;

  /// We reserve the right to modify this privacy policy from time to time. Any changes will be posted on this page and will take effect immediately upon posting. It is your responsibility to check this page regularly to keep up to date with any changes to our privacy policy.
  ///
  /// In en, this message translates to:
  /// **'We reserve the right to modify this privacy policy from time to time. Any changes will be posted on this page and will take effect immediately upon posting. It is your responsibility to check this page regularly to keep up to date with any changes to our privacy policy.'**
  String get weCanModifyRules;

  /// If you have any questions about this privacy policy, please contact us on github
  ///
  /// In en, this message translates to:
  /// **'If you have any questions about this privacy policy, please contact us on github'**
  String get ifQuestionThenGithub;

  /// Kholle of {teacher}
  ///
  /// In en, this message translates to:
  /// **'Kholle of {teacher}'**
  String kholleOf(String teacher);

  /// Exam: {title}
  ///
  /// In en, this message translates to:
  /// **'Exam: {title}'**
  String examOf(String title);

  /// {location}, place: {place}
  ///
  /// In en, this message translates to:
  /// **'{location}, place: {place}'**
  String examLocationPlace(String location, num place);

  /// Warning
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// Loading agenda
  ///
  /// In en, this message translates to:
  /// **'Loading agenda'**
  String get loadingAgenda;

  /// Agenda error
  ///
  /// In en, this message translates to:
  /// **'Error while loading the agenda'**
  String get agendaError;

  /// The month view is coming soon
  ///
  /// In en, this message translates to:
  /// **'The month view is coming soon'**
  String get monthViewSoon;

  /// Event details
  ///
  /// In en, this message translates to:
  /// **'Event details'**
  String get eventDetails;

  /// Loading buildings
  ///
  /// In en, this message translates to:
  /// **'Loading buildings'**
  String get loadingBuildings;

  /// Route
  ///
  /// In en, this message translates to:
  /// **'Route'**
  String get route;

  /// W: {weekNumber} displayed in the minicalendar at the left
  ///
  /// In en, this message translates to:
  /// **'W: {weekNumber}'**
  String weekNumberShort(int weekNumber);

  /// Inbox
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get inbox;

  /// Archive
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get archive;

  /// Delete
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// To archive
  ///
  /// In en, this message translates to:
  /// **'To archive'**
  String get toArchive;

  /// Mark as read/unread
  ///
  /// In en, this message translates to:
  /// **'Mark as read/unread'**
  String get markAsReadUnread;

  /// Move to
  ///
  /// In en, this message translates to:
  /// **'Move to'**
  String get moveTo;

  /// Mark as important
  ///
  /// In en, this message translates to:
  /// **'Mark as important'**
  String get markAsImportant;

  /// Search in the last {count} emails
  ///
  /// In en, this message translates to:
  /// **'Search in the last {count} emails'**
  String searchInTheNLastEmails(int count);

  /// {minutes}min
  ///
  /// In en, this message translates to:
  /// **'{minutes}min'**
  String minuteCompact(int minutes);

  /// {hours}h
  ///
  /// In en, this message translates to:
  /// **'{hours}h'**
  String hourCompact(int hours);

  /// {days}d
  ///
  /// In en, this message translates to:
  /// **'{days}d'**
  String dayCompact(int days);

  /// Now
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get now;

  /// Flagged email: {subject}
  ///
  /// In en, this message translates to:
  /// **'Flagged email: {subject}'**
  String flagedEmail(String subject);

  /// Unflagged email: {subject}
  ///
  /// In en, this message translates to:
  /// **'Unflagged email: {subject}'**
  String unflagedEmail(String subject);

  /// Add attachment
  ///
  /// In en, this message translates to:
  /// **'Add attachment'**
  String get addAttachment;

  /// Delete attachment
  ///
  /// In en, this message translates to:
  /// **'Delete the attachment?'**
  String get deleteAttachmentConfirmation;

  /// Cancel
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Recipient: PXXXXXXX, firstName.surname@status.univ-lyon1.fr
  ///
  /// In en, this message translates to:
  /// **'Recipient: PXXXXXXX, firstName.surname@status.univ-lyon1.fr'**
  String get emailAddressHint;

  /// Building
  ///
  /// In en, this message translates to:
  /// **'Building'**
  String get building;

  /// Menu of {restaurant}
  ///
  /// In en, this message translates to:
  /// **'Menu of {restaurant}'**
  String menuOf(String restaurant);

  /// No menu for this restaurant
  ///
  /// In en, this message translates to:
  /// **'No menu for this restaurant'**
  String get noMenuForThisRestaurant;

  /// Close
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// System
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// Dark
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// Light
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// Choose the theme
  ///
  /// In en, this message translates to:
  /// **'Choose the theme'**
  String get chooseTheme;

  /// Cache
  ///
  /// In en, this message translates to:
  /// **'Cache'**
  String get cache;

  /// Clear Izly cache
  ///
  /// In en, this message translates to:
  /// **'Clear Izly cache'**
  String get clearIzlyCache;

  /// Notifications
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Check for new notifications
  ///
  /// In en, this message translates to:
  /// **'Check for new notifications'**
  String get checkForNewNotifications;

  /// Change theme
  ///
  /// In en, this message translates to:
  /// **'Change theme'**
  String get changeTheme;

  /// Favorite theme
  ///
  /// In en, this message translates to:
  /// **'Favorite theme'**
  String get favoriteTheme;

  /// Light theme
  ///
  /// In en, this message translates to:
  /// **'Light theme'**
  String get lightTheme;

  /// Dark theme
  ///
  /// In en, this message translates to:
  /// **'Dark theme'**
  String get darkTheme;

  /// Add exams to calendar
  ///
  /// In en, this message translates to:
  /// **'Add exams to calendar'**
  String get examenAddToAgenda;

  /// Enable Colloscope
  ///
  /// In en, this message translates to:
  /// **'Enable Colloscope'**
  String get enableColloscope;

  /// Force year
  ///
  /// In en, this message translates to:
  /// **'Force year'**
  String get forceYear;

  /// {count, plural, =0{Automatic} =1{1st year} =2{2nd year}}
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Automatic} =1{1st year} other{{count}th year}}'**
  String forceYearValue(int count);

  /// Force an ID
  ///
  /// In en, this message translates to:
  /// **'Force an ID'**
  String get forceStudentId;

  /// Leave empty to disable
  ///
  /// In en, this message translates to:
  /// **'(empty to disable)'**
  String get emptyToDisable;

  /// Yet nothing to configure
  ///
  /// In en, this message translates to:
  /// **'Nothing to configure yet'**
  String get yetNothingToConfigure;

  /// Enable fingerprint authentication
  ///
  /// In en, this message translates to:
  /// **'Enable fingerprint authentication'**
  String get enablebiometricAuth;

  /// Unable to enable fingerprint authentication
  ///
  /// In en, this message translates to:
  /// **'Unable to enable fingerprint authentication'**
  String get unableToEnableBiometricAuth;

  /// Fingerprint authentication disables notifications
  ///
  /// In en, this message translates to:
  /// **'Fingerprint authentication disables notifications'**
  String get enableBiometricAuthDisableNotifications;

  /// Automatically change to the selected theme
  ///
  /// In en, this message translates to:
  /// **'Automatically change to the selected theme'**
  String get autoChangeTheme;

  /// Duration of a recent note
  ///
  /// In en, this message translates to:
  /// **'Duration of a recent note'**
  String get recentGradeDuration;

  /// {count, plural, =0{0 day} =1{1 day} other{{count} days}}
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{0 day} =1{1 day} other{{count} days}}'**
  String nDays(int count);

  /// Select a semester
  ///
  /// In en, this message translates to:
  /// **'Select a semester'**
  String get selectSemester;

  /// Average: {average} · Median: {mediane}
  /// Ranking: {rank}/{groupeSize}
  /// Teacher: {author}
  ///
  /// In en, this message translates to:
  /// **'Average: {average} · Median: {mediane}\nRanking: {rank}/{groupeSize}\nTeacher: {author}'**
  String noteDescription(double average, double mediane, int rank, int groupeSize, String author);

  /// Tomuss
  ///
  /// In en, this message translates to:
  /// **'Tomuss'**
  String get tomuss;

  /// Here is my grade in {title}
  ///
  /// In en, this message translates to:
  /// **'Here is my grade in {title}'**
  String hereMyGrade(String title);

  /// Dark (default)
  ///
  /// In en, this message translates to:
  /// **'Dark (default)'**
  String get darkDefault;

  /// Light (default)
  ///
  /// In en, this message translates to:
  /// **'Light (default)'**
  String get lightDefault;

  /// Nichi Hachi
  ///
  /// In en, this message translates to:
  /// **'Nichi Hachi'**
  String get nichiHachi;

  /// Blue sky
  ///
  /// In en, this message translates to:
  /// **'Blue sky'**
  String get blueSky;

  /// ULTRAKILL
  ///
  /// In en, this message translates to:
  /// **'ULTRAKILL'**
  String get ultrakill;

  /// Stardew Valley
  ///
  /// In en, this message translates to:
  /// **'Stardew Valley'**
  String get stardewValley;

  /// Bad Apple
  ///
  /// In en, this message translates to:
  /// **'Bad Apple'**
  String get badApple;

  /// Moon Light
  ///
  /// In en, this message translates to:
  /// **'Moon Light'**
  String get moonLight;

  /// {duration} · {location}
  ///
  /// In en, this message translates to:
  /// **'{duration} · {location}'**
  String eventSubtitle(String duration, String location);

  /// Please enter an id
  ///
  /// In en, this message translates to:
  /// **'Please enter an id'**
  String get pleaseEnterId;

  /// General
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// Clear the grade cache
  ///
  /// In en, this message translates to:
  /// **'Clear grade cache'**
  String get clearGradeCache;

  /// Clear the agenda cache
  ///
  /// In en, this message translates to:
  /// **'Clear agenda cache'**
  String get clearAgendaCache;

  /// Clear the email cache
  ///
  /// In en, this message translates to:
  /// **'Clear email cache'**
  String get clearEmailCache;

  /// Automatically fetch the agenda
  ///
  /// In en, this message translates to:
  /// **'Automatically fetch the agenda'**
  String get fetchAgendaAuto;

  /// Provide a notification in case of a new email
  ///
  /// In en, this message translates to:
  /// **'Notification in case of new email'**
  String get notifIfNewEmail;

  /// Force the mail theme
  ///
  /// In en, this message translates to:
  /// **'Force the mail theme'**
  String get forceMailTheme;

  /// Block trackers
  ///
  /// In en, this message translates to:
  /// **'Block trackers'**
  String get blockTrackers;

  /// Log out of Izly
  ///
  /// In en, this message translates to:
  /// **'Log out of Izly'**
  String get logoutIzly;

  /// Provide a notification in case of a new grade
  ///
  /// In en, this message translates to:
  /// **'Notification in case of new grade'**
  String get notifIfNewGrade;

  /// Forcibly set the grades to green
  ///
  /// In en, this message translates to:
  /// **'Forcibly set the grades to green'**
  String get forceGreenGrade;

  /// Show hidden UEs
  ///
  /// In en, this message translates to:
  /// **'Show hidden UEs'**
  String get showHiddenUE;

  /// Modify
  ///
  /// In en, this message translates to:
  /// **'Modify'**
  String get modify;

  /// Please select an output file
  ///
  /// In en, this message translates to:
  /// **'Please select an output file'**
  String get pleaseSelectOutputFile;

  /// Unable to open the link
  ///
  /// In en, this message translates to:
  /// **'Unable to open the link'**
  String get unableToOpenLink;

  /// Select the language
  ///
  /// In en, this message translates to:
  /// **'Select the language'**
  String get chooseLanguage;

  /// Automatic
  ///
  /// In en, this message translates to:
  /// **'Automatic'**
  String get auto;

  /// Do you really want to quit?
  ///
  /// In en, this message translates to:
  /// **'Do you really want to quit?'**
  String get realyQuit;

  /// Response
  ///
  /// In en, this message translates to:
  /// **'Response'**
  String get response;

  /// Enable Izly notifications
  ///
  /// In en, this message translates to:
  /// **'Enable Izly notifications'**
  String get enableIzlyNotif;

  /// Your Izly balance is low
  ///
  /// In en, this message translates to:
  /// **'Your Izly balance is low'**
  String get izlyNotEnoughMoneyTitle;

  /// There is ${money}€ left on your Izly account
  ///
  /// In en, this message translates to:
  /// **'There is \${money}€ left on your Izly account'**
  String izlyNotEnoughMoneyBody(double money);

  /// Discard the email?
  ///
  /// In en, this message translates to:
  /// **'Discard the email?'**
  String get mailSendPageDiscardTitle;

  /// Do you really want to discard the email?
  ///
  /// In en, this message translates to:
  /// **'Do you really want to discard the email?'**
  String get mailSendPageDiscardContent;

  /// No description provided for @discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @unHideQrCode.
  ///
  /// In en, this message translates to:
  /// **'Click to\nunhide the QR code'**
  String get unHideQrCode;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'fr', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
