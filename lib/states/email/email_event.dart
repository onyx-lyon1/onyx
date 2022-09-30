part of 'email_bloc.dart';

@immutable
abstract class EmailEvent {}

class EmailLoad extends EmailEvent {}

class EmailSend extends EmailEvent {
  final Mail email;

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

