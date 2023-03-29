part of 'email_cubit.dart';

enum EmailStatus {
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
  sorted,
  cacheSorted,
  mailboxesLoaded
}

class EmailState {
  final EmailStatus status;
  final List<MailBoxModel> mailBoxes;
  MailBoxModel? currentMailBox;
  final int emailNumber;
  final bool connected;

  EmailState({
    this.status = EmailStatus.initial,
    this.mailBoxes = const [],
    this.currentMailBox,
    this.emailNumber = 20,
    this.connected = false,
  }) {
    currentMailBox ??= MailBoxModel(
        name: "Boite de réception",
        specialMailBox: SpecialMailBox.inbox,
        emails: []);
  }

  EmailState copyWith({
    EmailStatus? status,
    List<MailBoxModel>? mailBoxes,
    MailBoxModel? currentMailBox,
    int? emailNumber,
    bool? connected,
  }) {
    return EmailState(
      status: status ?? this.status,
      mailBoxes: mailBoxes ?? this.mailBoxes,
      emailNumber: emailNumber ?? this.emailNumber,
      currentMailBox: currentMailBox ?? this.currentMailBox,
      connected: connected ?? this.connected,
    );
  }
}
