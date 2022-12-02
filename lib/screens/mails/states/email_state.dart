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
  cacheSorted
}

class EmailState {
  final EmailStatus status;
  final List<EmailModel> emails;
  final int emailNumber;
  final bool connected;

  EmailState({
    this.status = EmailStatus.initial,
    this.emails = const [],
    this.emailNumber = 20,
    this.connected = false,
  });

  EmailState copyWith({
    EmailStatus? status,
    List<EmailModel>? emails,
    int? emailNumber,
    bool? connected,
  }) {
    return EmailState(
      status: status ?? this.status,
      emails: emails ?? this.emails,
      emailNumber: emailNumber ?? this.emailNumber,
      connected: connected ?? this.connected,
    );
  }
}
