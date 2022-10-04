part of 'email_bloc.dart';

@immutable
abstract class EmailEvent {}

class EmailConnect extends EmailEvent {
  final String username;
  final String password;

  EmailConnect({required this.username, required this.password});
}

class EmailLoad extends EmailEvent {}

class EmailSend extends EmailEvent {
  final EmailModel email;

  EmailSend(this.email);
}

class EmailMarkAsRead extends EmailEvent {
  final EmailModel email;

  EmailMarkAsRead(this.email);
}

class EmailSort extends EmailEvent {
  final String filter;

  EmailSort(this.filter);
}
