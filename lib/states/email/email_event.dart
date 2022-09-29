part of 'email_bloc.dart';

@immutable
abstract class EmailEvent {}

class EmailLoad extends EmailEvent {}

class EmailSend extends EmailEvent {
  final Mail email;

  EmailSend(this.email);
}

class EmailMarkAsRead extends EmailEvent {
  final Mail email;

  EmailMarkAsRead(this.email);
}
