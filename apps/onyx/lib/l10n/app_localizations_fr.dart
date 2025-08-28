// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get onyx => 'Onyx';

  @override
  String get initialization => 'Initialisation';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get onyxSubTitle => 'Pour Lyon 1';

  @override
  String get authentication => 'Authentification';

  @override
  String get privacy => 'Confidentialité';

  @override
  String get wrongIdFormat => 'Lidentifiant nest pas dans le bon format';

  @override
  String get discoverApp => 'Découvrir l\'application';

  @override
  String get yourAuthentificated => 'Vous êtes authentifié';

  @override
  String get loginError => 'Erreur de connexion';

  @override
  String get fatalError => 'Erreur fatale';

  @override
  String get error => 'Erreur';

  @override
  String get casConnexion => 'Connexion à CAS';

  @override
  String get mockUsername => 'Nom d\'utilisateur simulé';

  @override
  String get mockPassword => 'Mot de passe simulé';

  @override
  String get accessingExams => 'Accès aux examens';

  @override
  String get errorAccessingExams => 'Erreur lors de l\'accès aux examens';

  @override
  String get mockStudent => 'Étudiant simulé';

  @override
  String get mockSchoolSubject => 'Matière simulée';

  @override
  String get mockTutorialLeader => 'Kholleur simulé';

  @override
  String get mockMessage => 'Message simulé';

  @override
  String get mockRoom => 'Salle simulée';

  @override
  String get mockTitle => 'Titre simulé';

  @override
  String get mockCodeName => 'Nom de code simulé';

  @override
  String get exams => 'Examens';

  @override
  String get sit => 'place';

  @override
  String get agendaSelection => 'Sélectionner l\'agenda';

  @override
  String get enabled => 'Activé';

  @override
  String get disabled => 'Désactivé';

  @override
  String get settings => 'Paramètres';

  @override
  String get showMiniCalendar => 'Afficher le mini calendrier en haut de page';

  @override
  String get calendarUpdateNotification =>
      'Notification en cas de mise à jour de l\'agenda';

  @override
  String get agendaPageBottomToTop => 'Affichage des agendas de bas en haut';

  @override
  String get agendaWeekLength => 'Nombre de jours affichés en mode semaine';

  @override
  String get agendaWeekReference => 'Jour de référence en mode semaine';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get agendaWeekReferenceAlignement => 'Alignement du jour de référence';

  @override
  String get disabledDays => 'Jours cachés';

  @override
  String get cantHideAllDays => 'Vous ne pouvez pas cacher tous les jours';

  @override
  String get root => 'Racine';

  @override
  String get folder => 'Dossier';

  @override
  String get subFolder => 'Sous-dossier';

  @override
  String get anotherRoot => 'Autre racine';

  @override
  String get loadingAgendaList => 'Chargement de la liste des agendas';

  @override
  String get errorAppeared => 'Une erreur est survenue';

  @override
  String get searchInCalendars => 'Rechercher dans les agendas';

  @override
  String get needCameraToScanQrCode =>
      'Nous avons besoin de la caméra pour scanner le QR code';

  @override
  String get forLyon1 => 'Pour Lyon 1';

  @override
  String get username => 'Nom d\'utilisateur';

  @override
  String get password => 'Mot de passe';

  @override
  String get login => 'Connexion';

  @override
  String get logout => 'Déconnexion';

  @override
  String get pleaseEnterUsername => 'Veuillez entrer l\'identitfiant';

  @override
  String get pleaseEnterAValidEmail => 'Veuillez entrer un mail valide';

  @override
  String get pleaseEnterPassword => 'Veuillez entrer le mot de passe';

  @override
  String get passwordShouldBeANumber => 'Le mot de passe doit être un nombre';

  @override
  String get connecting => 'Connexion en cours';

  @override
  String get thereWasAnErrorWhileConnecting =>
      'Une erreur est survenue lors de la connexion';

  @override
  String get loading => 'Chargement ...';

  @override
  String available(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString Qr Codes disponibles',
      one: '1 Qr Code disponibles',
      zero: 'Aucun QR Code disponible',
    );
    return '$_temp0';
  }

  @override
  String get qrCode => 'QR Code';

  @override
  String get offline => 'hors connexion';

  @override
  String get izly => 'Izly';

  @override
  String get youAreNotConnectedToIzly => 'Vous n\'êtes pas connecté à Izly';

  @override
  String get paymentHistory => 'Historique des paiements';

  @override
  String get refillWithBankCard => 'Recharger avec une carte bancaire';

  @override
  String get refillWithBankTransfer => 'Recharger par Virement';

  @override
  String get pay => 'Payer';

  @override
  String get pleaseSelectAnAmount => 'Veuillez entrer un montant';

  @override
  String minimumAmountIs(int countEuros) {
    final intl.NumberFormat countEurosNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countEurosString = countEurosNumberFormat.format(countEuros);

    return 'Le montant minimum est de $countEurosString€';
  }

  @override
  String get bankTransfer => 'Virement';

  @override
  String get bankCard => 'Carte bancaire';

  @override
  String get thirdParty => 'Recharger par un tiers';

  @override
  String get mail => 'Mail';

  @override
  String get message => 'Message';

  @override
  String get transfer => 'Transférer';

  @override
  String get recharging => 'En cours de rechargement';

  @override
  String get pleaseWait => 'Veuillez patienter';

  @override
  String get from => 'De';

  @override
  String get to => 'À';

  @override
  String get me => 'Moi';

  @override
  String get mailSendPageErrorTitle =>
      'Veuillez remplir correctement tous les champs';

  @override
  String get subject => 'Objets';

  @override
  String get reply => 'Réponse';

  @override
  String get mailServerConnection => 'Connexion au serveur de mail';

  @override
  String get mailServerConnectionError => 'Erreur de chargement des mails';

  @override
  String get loadingMails => 'Chargement des mails';

  @override
  String get errorOccured => 'Une erreur est survenue';

  @override
  String get sendingEmail => 'Envoi du mail';

  @override
  String get loadMoreMails => 'Charger 20 mails supplémentaires';

  @override
  String get tomussConnection => 'Connexion à Tomuss';

  @override
  String get loadingGrades => 'Chargement des notes';

  @override
  String get loadingGradesError => 'Erreur de chargement des notes';

  @override
  String get newEvent => 'Nouvel événement';

  @override
  String nDayModified(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'vous avez $countString jours modifiés',
      one: 'vous avez 1 jour modifié',
      zero: 'vous avez Aucun jour modifié',
    );
    return '$_temp0';
  }

  @override
  String newEventAt(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Vous avez un nouvel évènement le : \$$dateString';
  }

  @override
  String get newEmail => 'Nouveau mail';

  @override
  String youHaveANewEmail(String sender, String excerpt) {
    return 'Vous avez un nouveau mail de $sender \n\n $excerpt';
  }

  @override
  String get defaultSemester => 'Semestre par défaut';

  @override
  String get newGrade => 'Nouvelle note';

  @override
  String youHaveANewGrade(double numerator, double denominator, String title) {
    final intl.NumberFormat numeratorNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String numeratorString = numeratorNumberFormat.format(numerator);
    final intl.NumberFormat denominatorNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String denominatorString =
        denominatorNumberFormat.format(denominator);

    return 'Vous avez eu $numeratorString/$denominatorString en : $title';
  }

  @override
  String get grades => 'Notes';

  @override
  String get agenda => 'Agenda';

  @override
  String get mails => 'Mails';

  @override
  String get map => 'Carte';

  @override
  String get ok => 'Ok';

  @override
  String get warningSelectShouldAgenda =>
      'L\'agenda est sélectionné automatiquement. Cela peut être inexact,\nsurtout pour les étudiants de Polytech.\nN\'hésitez pas à le sélectionner manuellement dans les paramètres.';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get dataCollection => 'Collecte de données';

  @override
  String get dataSafety => 'Sécurité des données';

  @override
  String get contactUs => 'Nous contacter';

  @override
  String get weTakeCareOfYourData =>
      'Notre application est conçue pour fournir un accès en ligne aux services de l\'université de Lyon 1. Nous prenons la protection de vos informations personnelles au sérieux et nous sommes déterminés à assurer la confidentialité de vos informations.';

  @override
  String get dataOnlyStoredOnYourDevice =>
      'Notre application ne collecte aucune information personnelle. Les données de connexion sont stockées uniquement sur le téléphone de l\'utilisateur et ne sont communiquées qu\'avec les serveurs de l\'université, pour lesquels nous ne sommes pas responsables.';

  @override
  String get ourSecurityMeasures =>
      'Nous prenons des mesures de sécurité raisonnables pour protéger vos informations personnelles contre la perte, l\'utilisation abusive, l\'accès non autorisé, la modification et la divulgation. Néanmoins, aucune méthode de transmission sur Internet ou de stockage électronique n\'est sûre à 100 %. Par conséquent, bien que nous nous efforcions de protéger vos informations personnelles, nous ne pouvons garantir la sécurité absolue de vos informations transmises à notre application et vous le faites à vos risques et périls.';

  @override
  String get modificationOfThePrivacyPolicy =>
      'Modification de cette politique de confidentialité';

  @override
  String get weCanModifyRules =>
      'Nous nous réservons le droit de modifier cette politique de confidentialité de temps à autre. Toute modification sera publiée sur cette page et prendra effet immédiatement après sa publication. Il est de votre responsabilité de consulter régulièrement cette page pour vous tenir informé des modifications apportées à notre politique de confidentialité.';

  @override
  String get ifQuestionThenGithub =>
      'Si vous avez des questions concernant cette politique de confidentialité, veuillez nous contacter sur github';

  @override
  String kholleOf(String teacher) {
    return 'Kholle de $teacher';
  }

  @override
  String examOf(String title) {
    return 'Examen : $title';
  }

  @override
  String examLocationPlace(String location, num place) {
    final intl.NumberFormat placeNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String placeString = placeNumberFormat.format(place);

    return '$location, place : $placeString';
  }

  @override
  String get warning => 'Attention';

  @override
  String get loadingAgenda => 'Chargement de l\'agenda';

  @override
  String get agendaError => 'Erreur lors du chargement de l\'agenda';

  @override
  String get monthViewSoon => 'La vue mensuelle arrive bientôt';

  @override
  String get eventDetails => 'Détails de l\'évènement';

  @override
  String get loadingBuildings => 'Chargement des bâtiments';

  @override
  String get route => 'Itinéraire';

  @override
  String weekNumberShort(int weekNumber) {
    final intl.NumberFormat weekNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String weekNumberString = weekNumberNumberFormat.format(weekNumber);

    return 'S: $weekNumberString';
  }

  @override
  String get inbox => 'Boîte de réception';

  @override
  String get archive => 'Archives';

  @override
  String get delete => 'Supprimer';

  @override
  String get toArchive => 'Archiver';

  @override
  String get markAsReadUnread => 'Marquer comme lu/non lu';

  @override
  String get moveTo => 'Déplacer vers';

  @override
  String get markAsImportant => 'Marquer comme important';

  @override
  String searchInTheNLastEmails(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    return 'Rechercher dans les $countString derniers mails';
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

    return '${daysString}j';
  }

  @override
  String get now => 'Maintenant';

  @override
  String flagedEmail(String subject) {
    return 'Mail marqué : $subject';
  }

  @override
  String unflagedEmail(String subject) {
    return 'Mail non marqué : $subject';
  }

  @override
  String get addAttachment => 'Ajouter une pièce jointe';

  @override
  String get deleteAttachmentConfirmation => 'Supprimer la pièce jointe ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get emailAddressHint =>
      'Destinataire : PXXXXXXX, prenom.nom@status.univ-lyon1.fr';

  @override
  String get building => 'Bâtiment';

  @override
  String menuOf(String restaurant) {
    return 'Menu de $restaurant';
  }

  @override
  String get noMenuForThisRestaurant => 'Pas de menu pour ce restaurant';

  @override
  String get close => 'Fermer';

  @override
  String get system => 'Système';

  @override
  String get dark => 'Sombre';

  @override
  String get light => 'Clair';

  @override
  String get chooseTheme => 'Choisir le thème';

  @override
  String get cache => 'Cache';

  @override
  String get clearIzlyCache => 'Vider le cache d\'Izly';

  @override
  String get notifications => 'Notifications';

  @override
  String get checkForNewNotifications => 'Vérifier les nouvelles notifications';

  @override
  String get changeTheme => 'Changer de thème';

  @override
  String get favoriteTheme => 'Thèmes favoris';

  @override
  String get lightTheme => 'Thèmes clairs';

  @override
  String get darkTheme => 'Thèmes sombres';

  @override
  String get examenAddToAgenda => 'Ajouter les examens à l\'agenda';

  @override
  String get enableColloscope => 'Activer le Colloscope';

  @override
  String get forceYear => 'Forcer l\'année';

  @override
  String forceYearValue(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '${countString}e année',
      one: '1ère année',
      zero: 'Automatique',
    );
    return '$_temp0';
  }

  @override
  String get forceStudentId => 'Forcer un ID';

  @override
  String get emptyToDisable => '(vide pour désactiver)';

  @override
  String get yetNothingToConfigure => 'Rien à configurer pour le moment';

  @override
  String get enablebiometricAuth =>
      'Activer l\'authentification par empreinte digitale';

  @override
  String get unableToEnableBiometricAuth =>
      'Impossible d\'activer l\'authentification par empreinte digitale';

  @override
  String get enableBiometricAuthDisableNotifications =>
      'L\'authentification par empreinte digitale désactive les notifications';

  @override
  String get autoChangeTheme => 'Changer automatiquement au thème selectionné';

  @override
  String get recentGradeDuration => 'Durée d\'une note récente';

  @override
  String nDays(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString jours',
      one: '1 jour',
      zero: '0 jour',
    );
    return '$_temp0';
  }

  @override
  String get selectSemester => 'Sélectionner un semestre';

  @override
  String noteDescription(
      double average, double mediane, int rank, int groupeSize, String author) {
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

    return 'Moyenne : $averageString · Mediane : $medianeString\nClassement : $rankString/$groupeSizeString\nProfesseur : $author';
  }

  @override
  String get tomuss => 'Tomuss';

  @override
  String hereMyGrade(String title) {
    return 'Voici ma note en $title';
  }

  @override
  String get darkDefault => 'Sombre (par défaut)';

  @override
  String get lightDefault => 'Clair (par défaut)';

  @override
  String get nichiHachi => 'Nichi Hachi';

  @override
  String get blueSky => 'Ciel bleu';

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
    return '$duration • $location';
  }

  @override
  String get pleaseEnterId => 'Veuillez entrer l\'identifiant';

  @override
  String get general => 'Général';

  @override
  String get clearGradeCache => 'Vider le cache des notes';

  @override
  String get clearAgendaCache => 'Vider le cache de l\'agenda';

  @override
  String get clearEmailCache => 'Vider le cache des mails';

  @override
  String get fetchAgendaAuto => 'Récupérer automatiquement l\'agenda';

  @override
  String get notifIfNewEmail => 'Notification en cas de nouveau mail';

  @override
  String get forceMailTheme => 'Forcer le thème des mails';

  @override
  String get blockTrackers => 'Bloquer les trackers';

  @override
  String get logoutIzly => 'Déconnexion d\'Izly';

  @override
  String get notifIfNewGrade => 'Notification en cas de nouvelle note';

  @override
  String get forceGreenGrade => 'Forcer les notes en vert';

  @override
  String get showHiddenUE => 'Afficher les UE cachées';

  @override
  String get modify => 'Modifier';

  @override
  String get pleaseSelectOutputFile =>
      'Veuillez sélectionner un fichier de sortie';

  @override
  String get unableToOpenLink => 'Impossible d\'ouvrir le lien';

  @override
  String get chooseLanguage => 'Choisir la langue';

  @override
  String get auto => 'Automatique';

  @override
  String get realyQuit => 'Voulez-vous vraiment quitter ?';

  @override
  String get response => 'Réponse';

  @override
  String get enableIzlyNotif => 'Activer les notifications Izly';

  @override
  String get izlyNotEnoughMoneyTitle => 'Solde bas du compte Izly';

  @override
  String izlyNotEnoughMoneyBody(double money) {
    final intl.NumberFormat moneyNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String moneyString = moneyNumberFormat.format(money);

    return 'Il ne vous reste que $moneyString€ sur votre compte Izly';
  }

  @override
  String get mailSendPageDiscardTitle =>
      'Voulez-vous vraiment quitter la page ?';

  @override
  String get mailSendPageDiscardContent => 'Vous allez perdre votre mail';

  @override
  String get discard => 'Quitter';

  @override
  String get more => 'Plus';

  @override
  String get unHideQrCode => 'Cliquez pour\nafficher le qr code';

  @override
  String get resetSettings => 'Réinitialiser les paramètres';
}
