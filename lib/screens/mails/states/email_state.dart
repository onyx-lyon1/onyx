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
  sorted
}

class EmailState {
  final EmailStatus status;
  final List<EmailModel> emails;
  final int emailNumber;

  EmailState({
    this.status = EmailStatus.initial,
    this.emails = const [],
    this.emailNumber = 20,
  });

  EmailState copyWith({
    EmailStatus? status,
    List<EmailModel>? emails,
    int? emailNumber,
  }) {
    return EmailState(
      status: status ?? this.status,
      emails: emails ?? this.emails,
      emailNumber: emailNumber ?? this.emailNumber,
    );
  }
}
