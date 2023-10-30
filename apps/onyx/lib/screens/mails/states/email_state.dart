part of 'email_cubit.dart';

@MappableEnum()
enum MailStatus {
  @MappableValue(000)
  initial,
  @MappableValue(100)
  connecting,
  @MappableValue(200)
  connected,
  @MappableValue(300)
  loading,
  @MappableValue(400)
  cacheLoaded,
  @MappableValue(500)
  loaded,
  @MappableValue(600)
  sending,
  @MappableValue(700)
  sended,
  @MappableValue(800)
  updated,
  @MappableValue(900)
  error,
  @MappableValue(1000)
  nonFatalError,
  @MappableValue(1100)
  sorted,
  @MappableValue(1200)
  cacheSorted,
  @MappableValue(1300)
  mailboxesLoaded
}

@MappableClass()
class EmailState with EmailStateMappable {
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
  }) {
    currentMailBox ??= MailBox(
        name: "Boite de réception",
        specialMailBox: SpecialMailBox.inbox,
        emails: const []);
  }
}
