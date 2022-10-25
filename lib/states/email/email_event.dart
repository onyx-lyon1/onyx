part of 'email_bloc.dart';

@immutable
abstract class EmailEvent {}

class EmailConnect extends EmailEvent {
  final String username;
  final String password;

  EmailConnect({required this.username, required this.password});
}

class EmailLoad extends EmailEvent {
  final bool cache;
  EmailLoad({this.cache=true});
}

class EmailSend extends EmailEvent {
  final EmailModel email;
  final int? replyOriginalMessageId;
  final bool? replyAll;

  EmailSend(this.email, {this.replyOriginalMessageId, this.replyAll});
}

class EmailMarkAsRead extends EmailEvent {
  final EmailModel email;

  EmailMarkAsRead(this.email);
}

class EmailDelete extends EmailEvent {
  final EmailModel email;

  EmailDelete(this.email);
}

class EmailFilter extends EmailEvent {
  final String filter;

  EmailFilter(this.filter);
}

class EmailIncreaseNumber extends EmailEvent {}
