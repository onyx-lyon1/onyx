part of 'email_bloc.dart';

@immutable
abstract class EmailEvent {}

class EmailLoad extends EmailEvent {}

class EmailSend extends EmailEvent {
  final EmailModel email;

  EmailSend(this.email);
}
