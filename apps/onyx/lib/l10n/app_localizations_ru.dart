// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get onyx => 'Оникс';

  @override
  String get initialization => 'Инициализация';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

  @override
  String get onyxSubTitle => 'Для Лиона 1';

  @override
  String get authentication => 'Аутентификация';

  @override
  String get privacy => 'Конфиденциальность';

  @override
  String get wrongIdFormat => 'Идентификатор имеет неверный формат';

  @override
  String get discoverApp => 'Ознакомьтесь с приложением';

  @override
  String get yourAuthentificated => 'Вы авторизованы';

  @override
  String get loginError => 'Ошибка входа';

  @override
  String get fatalError => 'Критическая ошибка';

  @override
  String get error => 'Ошибка';

  @override
  String get casConnexion => 'Подключение CAS';

  @override
  String get mockUsername => 'Логин-Mock';

  @override
  String get mockPassword => 'Пароль-Mock';

  @override
  String get accessingExams => 'Доступ к экзаменам';

  @override
  String get errorAccessingExams => 'Ошибка доступа к экзаменам';

  @override
  String get mockStudent => 'Студент-Mock';

  @override
  String get mockSchoolSubject => 'Учебный предмет-Mock';

  @override
  String get mockTutorialLeader => 'Руководитель учебной группы-Mock';

  @override
  String get mockMessage => 'Сообщение-Mock';

  @override
  String get mockRoom => 'Комната-Mock';

  @override
  String get mockTitle => 'Заголовок-Mock';

  @override
  String get mockCodeName => 'Кодовое имя-Mock';

  @override
  String get exams => 'Экзамены';

  @override
  String get sit => 'сидеть';

  @override
  String get agendaSelection => 'Выберите повестку дня';

  @override
  String get enabled => 'Включено';

  @override
  String get disabled => 'Отключено';

  @override
  String get settings => 'Настройки';

  @override
  String get showMiniCalendar => 'Показать мини-календарь вверху страницы';

  @override
  String get calendarUpdateNotification => 'Уведомление об обновлении календаря';

  @override
  String get agendaPageBottomToTop => 'Отображать повестку дня снизу вверх';

  @override
  String get agendaWeekLength => 'Количество дней, отображаемых в режиме недели';

  @override
  String get agendaWeekReference => 'День ссылки в режиме недели';

  @override
  String get today => 'Сегодня';

  @override
  String get agendaWeekReferenceAlignement => 'Выравнивание дня ссылки';

  @override
  String get disabledDays => 'Скрытые дни';

  @override
  String get cantHideAllDays => 'Вы не можете скрыть все дни';

  @override
  String get root => 'Корень';

  @override
  String get folder => 'Папка';

  @override
  String get subFolder => 'Подпапка';

  @override
  String get anotherRoot => 'Другой корень';

  @override
  String get loadingAgendaList => 'Загрузка списка повестки дня';

  @override
  String get errorAppeared => 'Появилась ошибка';

  @override
  String get searchInCalendars => 'Поиск в календарях';

  @override
  String get needCameraToScanQrCode => 'Для сканирования QR-кода нужна камера';

  @override
  String get forLyon1 => 'Для Лиона 1';

  @override
  String get username => 'Имя пользователя';

  @override
  String get password => 'Пароль';

  @override
  String get login => 'Вход';

  @override
  String get logout => 'Выход';

  @override
  String get pleaseEnterUsername => 'Введите имя пользователя';

  @override
  String get pleaseEnterAValidEmail => 'Введите действительный адрес электронной почты';

  @override
  String get pleaseEnterPassword => 'Введите пароль';

  @override
  String get passwordShouldBeANumber => 'Пароль должен быть числом';

  @override
  String get connecting => 'Подключение';

  @override
  String get thereWasAnErrorWhileConnecting => 'Во время подключения произошла ошибка';

  @override
  String get loading => 'Загрузка...';

  @override
  String available(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Имеется $countString QR-кодов',
      one: 'Имеется 1 QR-код',
      zero: 'Отсутствует QR-код',
    );
    return '$_temp0';
  }

  @override
  String get qrCode => 'QR-код';

  @override
  String get offline => 'Оффлайн';

  @override
  String get izly => 'Изли';

  @override
  String get youAreNotConnectedToIzly => 'Вы не подключены к Izly';

  @override
  String get paymentHistory => 'История платежей';

  @override
  String get refillWithBankCard => 'Пополнить банковской картой';

  @override
  String get refillWithBankTransfer => 'Пополнить банковским переводом';

  @override
  String get pay => 'Платить';

  @override
  String get pleaseSelectAnAmount => 'Введите сумму';

  @override
  String minimumAmountIs(int countEuros) {
    final intl.NumberFormat countEurosNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countEurosString = countEurosNumberFormat.format(countEuros);

    return 'Минимальная сумма составляет $countEurosString€';
  }

  @override
  String get bankTransfer => 'Банковский перевод';

  @override
  String get bankCard => 'Банковская карта';

  @override
  String get thirdParty => '第三方';

  @override
  String get mail => 'Почта';

  @override
  String get message => 'Сообщение';

  @override
  String get transfer => 'Передача';

  @override
  String get recharging => 'Перезарядка';

  @override
  String get pleaseWait => 'Пожалуйста, подождите';

  @override
  String get from => 'От';

  @override
  String get to => 'Кому';

  @override
  String get me => 'Мне';

  @override
  String get mailSendPageErrorTitle => 'Пожалуйста, заполните все поля правильно';

  @override
  String get subject => 'Тема';

  @override
  String get reply => 'Ответить';

  @override
  String get mailServerConnection => 'Подключение к почтовому серверу';

  @override
  String get mailServerConnectionError => 'Ошибка подключения к почтовому серверу';

  @override
  String get loadingMails => 'Загрузка почты';

  @override
  String get errorOccured => 'Произошла ошибка';

  @override
  String get sendingEmail => 'Отправка письма';

  @override
  String get loadMoreMails => 'Загрузить еще 20 писем';

  @override
  String get tomussConnection => 'Подключение к Томюссу';

  @override
  String get loadingGrades => 'Загрузка оценок';

  @override
  String get loadingGradesError => 'Ошибка загрузки оценок';

  @override
  String get newEvent => 'Новое событие';

  @override
  String nDayModified(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'У вас $countString измененных дней',
      one: 'У вас 1 измененный день',
      zero: 'У вас нет измененных дней',
    );
    return '$_temp0';
  }

  @override
  String newEventAt(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'У вас новое событие на: \$$dateString';
  }

  @override
  String get newEmail => 'Новое письмо';

  @override
  String youHaveANewEmail(String sender, String excerpt) {
    return 'У вас новое письмо от $sender \n\n $excerpt';
  }

  @override
  String get defaultSemester => 'Семестр по умолчанию';

  @override
  String get newGrade => 'Новая оценка';

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

    return 'Вы получили numerator/$denominatorString (\$$title) в: \$$title';
  }

  @override
  String get grades => 'Оценки';

  @override
  String get agenda => 'Повестка дня';

  @override
  String get mails => 'Почта';

  @override
  String get map => 'Карта';

  @override
  String get ok => 'Ok';

  @override
  String get warningSelectShouldAgenda => 'Расписание выбирается автоматически. Это может быть неправильно,\nособенно для студентов Политехнического института.\nНе стесняйтесь выбирать его вручную в настройках.';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get dataCollection => 'Сбор данных';

  @override
  String get dataSafety => 'Безопасность данных';

  @override
  String get contactUs => 'Свяжитесь с нами';

  @override
  String get weTakeCareOfYourData => 'Наше приложение предназначено для обеспечения онлайн-доступа к услугам Университета Лиона 1. Мы серьезно относимся к защите вашей личной информации и стремимся обеспечить конфиденциальность вашей информации.';

  @override
  String get dataOnlyStoredOnYourDevice => 'Наше приложение не собирает никакой личной информации. Данные для входа хранятся только на телефоне пользователя и передаются только на серверы университета, за которые мы не несем ответственности.';

  @override
  String get ourSecurityMeasures => 'Мы принимаем разумные меры безопасности для защиты вашей личной информации от потери, злоупотребления, несанкционированного доступа, изменения и раскрытия. Тем не менее, ни один метод передачи данных через Интернет или электронного хранения не является на 100% безопасным. Поэтому, хотя мы стремимся защитить вашу личную информацию, мы не можем гарантировать абсолютную безопасность вашей информации, передаваемой в наше приложение, и вы делаете это на свой страх и риск.';

  @override
  String get modificationOfThePrivacyPolicy => 'Изменение настоящей политики конфиденциальности';

  @override
  String get weCanModifyRules => 'Мы оставляем за собой право время от времени менять эту политику конфиденциальности. Любые изменения будут размещены на этой странице и вступят в силу сразу после публикации. Вы обязаны регулярно проверять эту страницу, чтобы быть в курсе любых изменений нашей политики конфиденциальности.';

  @override
  String get ifQuestionThenGithub => 'Если у вас есть какие-либо вопросы по поводу этой политики конфиденциальности, пожалуйста, свяжитесь с нами на github';

  @override
  String kholleOf(String teacher) {
    return 'Колль $teacher';
  }

  @override
  String examOf(String title) {
    return 'Экзамен: $title';
  }

  @override
  String examLocationPlace(String location, num place) {
    final intl.NumberFormat placeNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String placeString = placeNumberFormat.format(place);

    return '$location, место: $placeString';
  }

  @override
  String get warning => 'Внимание';

  @override
  String get loadingAgenda => 'Загрузка расписания';

  @override
  String get agendaError => 'Ошибка при загрузке расписания';

  @override
  String get monthViewSoon => 'Вид месяца скоро появится';

  @override
  String get eventDetails => 'Детали события';

  @override
  String get loadingBuildings => 'Загрузка зданий';

  @override
  String get route => 'Маршрут';

  @override
  String weekNumberShort(int weekNumber) {
    final intl.NumberFormat weekNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String weekNumberString = weekNumberNumberFormat.format(weekNumber);

    return 'Н: $weekNumberString (отображается в мини-календаре слева)';
  }

  @override
  String get inbox => 'Входящие';

  @override
  String get archive => 'Архив';

  @override
  String get delete => 'Удалить';

  @override
  String get toArchive => 'В архив';

  @override
  String get markAsReadUnread => 'Отметить как прочитанное/непрочитанное';

  @override
  String get moveTo => 'Переместить в';

  @override
  String get markAsImportant => 'Отметить как важное';

  @override
  String searchInTheNLastEmails(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    return 'Поиск в последних $countString электронных письмах';
  }

  @override
  String minuteCompact(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '$minutesStringмин';
  }

  @override
  String hourCompact(int hours) {
    final intl.NumberFormat hoursNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String hoursString = hoursNumberFormat.format(hours);

    return '$hoursStringч';
  }

  @override
  String dayCompact(int days) {
    final intl.NumberFormat daysNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String daysString = daysNumberFormat.format(days);

    return '$daysStringд';
  }

  @override
  String get now => 'Сейчас';

  @override
  String flagedEmail(String subject) {
    return 'Помеченное письмо: $subject';
  }

  @override
  String unflagedEmail(String subject) {
    return 'Неотмеченное письмо: $subject';
  }

  @override
  String get addAttachment => 'Добавить вложение';

  @override
  String get deleteAttachmentConfirmation => 'Удалить вложение?';

  @override
  String get cancel => 'Отмена';

  @override
  String get emailAddressHint => 'Получатель: PXXXXXXX, firstName.surname@status.univ-lyon1.fr';

  @override
  String get building => 'Здание';

  @override
  String menuOf(String restaurant) {
    return 'Меню $restaurant';
  }

  @override
  String get noMenuForThisRestaurant => 'Меню для этого ресторана отсутствует';

  @override
  String get close => 'Закрыть';

  @override
  String get system => 'Система';

  @override
  String get dark => 'Темная';

  @override
  String get light => 'Светлая';

  @override
  String get chooseTheme => 'Выбрать тему';

  @override
  String get cache => 'Кэш';

  @override
  String get clearIzlyCache => 'Очистить кэш Izly';

  @override
  String get notifications => 'Уведомления';

  @override
  String get checkForNewNotifications => 'Проверить новые уведомления';

  @override
  String get changeTheme => 'Сменить тему';

  @override
  String get favoriteTheme => 'Любимая тема';

  @override
  String get lightTheme => 'Светлая тема';

  @override
  String get darkTheme => 'Темная тема';

  @override
  String get examenAddToAgenda => 'Добавить экзамены в календарь';

  @override
  String get enableColloscope => 'Включить коллоквиум';

  @override
  String get forceYear => 'Задать год';

  @override
  String forceYearValue(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString-й курс',
      one: '1-й курс',
      zero: 'Автоматически',
    );
    return '$_temp0';
  }

  @override
  String get forceStudentId => 'Задать ID';

  @override
  String get emptyToDisable => '(оставить пустым для отключения)';

  @override
  String get yetNothingToConfigure => 'Пока нечего настраивать';

  @override
  String get enablebiometricAuth => 'Включить аутентификацию по отпечатку пальца';

  @override
  String get unableToEnableBiometricAuth => 'Не удалось включить аутентификацию по отпечатку пальца';

  @override
  String get enableBiometricAuthDisableNotifications => 'Аутентификация по отпечатку пальца отключает уведомления';

  @override
  String get autoChangeTheme => 'Автоматически переключаться на выбранную тему';

  @override
  String get recentGradeDuration => 'Продолжительность последней оценки';

  @override
  String nDays(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString дней',
      one: '1 день',
      zero: '0 день',
    );
    return '$_temp0';
  }

  @override
  String get selectSemester => 'Выбрать семестр';

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

    return 'Средний: $averageString · Медиана: $medianeString\nПозиция: $rankString/$groupeSizeString\nПреподаватель: $author';
  }

  @override
  String get tomuss => 'Томусс';

  @override
  String hereMyGrade(String title) {
    return 'Вот моя оценка в $title';
  }

  @override
  String get darkDefault => 'Темная (по умолчанию)';

  @override
  String get lightDefault => 'Светлая (по умолчанию)';

  @override
  String get nichiHachi => 'Ничи Хачи';

  @override
  String get blueSky => 'Голубое небо';

  @override
  String get ultrakill => 'ULTRAKILL';

  @override
  String get stardewValley => 'Stardew Valley';

  @override
  String get badApple => 'Bad Apple';

  @override
  String get moonLight => 'Лунный свет';

  @override
  String eventSubtitle(String duration, String location) {
    return '$duration · $location';
  }

  @override
  String get pleaseEnterId => 'Пожалуйста, введите идентификатор';

  @override
  String get general => 'Главное';

  @override
  String get clearGradeCache => 'Очистить кэш оценок';

  @override
  String get clearAgendaCache => 'Очистить кэш расписания';

  @override
  String get clearEmailCache => 'Очистить кэш электронной почты';

  @override
  String get fetchAgendaAuto => 'Автоматически получать расписание';

  @override
  String get notifIfNewEmail => 'Уведомление о новой почте';

  @override
  String get forceMailTheme => 'Принудительная тема почты';

  @override
  String get blockTrackers => 'Блокировать трекеры';

  @override
  String get logoutIzly => 'Выйти из Izly';

  @override
  String get notifIfNewGrade => 'Уведомление о новой оценке';

  @override
  String get forceGreenGrade => 'Принудительно установить оценки зелеными';

  @override
  String get showHiddenUE => 'Показать скрытые блоки';

  @override
  String get modify => 'Изменить';

  @override
  String get pleaseSelectOutputFile => 'Пожалуйста, выберите файл вывода';

  @override
  String get unableToOpenLink => 'Не удалось открыть ссылку';

  @override
  String get chooseLanguage => 'Выберите язык';

  @override
  String get auto => 'Автоматически';

  @override
  String get realyQuit => 'Вы действительно хотите бросить курить?';

  @override
  String get response => 'Ответ';

  @override
  String get enableIzlyNotif => 'Включить уведомления Izly';

  @override
  String get izlyNotEnoughMoneyTitle => 'Недостаточно средств на счете Izly';

  @override
  String izlyNotEnoughMoneyBody(double money) {
    final intl.NumberFormat moneyNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String moneyString = moneyNumberFormat.format(money);

    return 'У вас осталось всего $moneyString€ на вашем счете Izly';
  }

  @override
  String get mailSendPageDiscardTitle => 'Отменить отправку письма?';

  @override
  String get mailSendPageDiscardContent => 'Вы уверены, что хотите отменить отправку письма?';

  @override
  String get discard => 'Отменить';

  @override
  String get more => 'Еще';

  @override
  String get unHideQrCode => 'Показать QR-код';
}
