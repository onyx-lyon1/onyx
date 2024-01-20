part of 'email_cubit.dart';

enum MailStatus {
  initial,
  connecting,
  connected,
  loading,
  cacheLoaded,
  loaded,
  sending,
  sended,
  updated,
  error,
  nonFatalError,
  sorted,
  cacheSorted,
  mailboxesLoaded
}

class EmailState {
  final MailStatus status;
  final List<MailBox> mailBoxes;
  MailBox? currentMailBox;
  final int emailNumber;
  final bool connected;
  final List<Mail> selectedMails;

  EmailState({
    this.status = MailStatus.initial,
    this.mailBoxes = const [],
    this.currentMailBox,
    this.emailNumber = 20,
    this.connected = false,
    this.selectedMails = const [],
    required AppLocalizations appLocalizations,
  }) {
    currentMailBox ??= MailBox(
        name: appLocalizations.inbox,
        specialMailBox: SpecialMailBox.inbox,
        emails: const []);
  }

  EmailState copyWith({
    MailStatus? status,
    List<MailBox>? mailBoxes,
    MailBox? currentMailBox,
    int? emailNumber,
    bool? connected,
    List<Mail>? selectedMails,
    required AppLocalizations appLocalizations,
  }) {
    return EmailState(
      status: status ?? this.status,
      mailBoxes: mailBoxes ?? this.mailBoxes,
      emailNumber: emailNumber ?? this.emailNumber,
      currentMailBox: currentMailBox ?? this.currentMailBox,
      connected: connected ?? this.connected,
      selectedMails: selectedMails ?? this.selectedMails,
      appLocalizations: appLocalizations,
    );
  }
}
