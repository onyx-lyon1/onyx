// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:lyon1mail/lyon1mail.dart';

part 'email_event.dart';

part 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  late Lyon1Mail mailClient;
  List<Mail> emails = [];
  final String username;
  final String password;

  EmailBloc({required this.username, required this.password})
      : super(EmailInitial()) {
    mailClient = Lyon1Mail(username, password);
    on<EmailEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<EmailLoad>(load);
    on<EmailSend>(send);
    on<EmailMarkAsRead>(markAsRead);
  }

  void markAsRead(EmailMarkAsRead event, Emitter<EmailState> emit) async {
    print("mark as read");

    if (!event.email.isSeen()) {
      await event.email.markAsSeen();
      // await mailClient.markAsRead(event.sequenceId!);
      print("marker");
      print(event.email.getSequenceId());
      print(event.email.isSeen());
    }

    emit(EmailUpdated());
  }

  void load(EmailLoad event, Emitter<EmailState> emit) async {
    emit(EmailLoading());
    if (!await mailClient.login()) {
      emit(EmailError());
    }
    final Option<List<Mail>> emailOpt = await mailClient.fetchMessages(15);
    if (emailOpt.isNone()) {
      if (kDebugMode) {
        print("no emails");
      }
    } else {
      emails.addAll(emailOpt.toIterable().first);
      for (final Mail mail in emailOpt.toIterable().first) {
        emails.add(mail
            // EmailModel(
            // subject: mail.getSubject(),
            // sender: mail.getSender(),
            // receiver: "me",
            // excerpt: mail.getBody(excerpt: true),
            // body: mail.getBody(excerpt: false),
            // sequenceId: mail.getSequenceId(),
            // isRead: mail.isSeen(),
            // date: mail.getDate())
            );
      }
    }
    emit(EmailLoaded());
    await mailClient.logout();
  }

  void send(EmailSend event, Emitter<EmailState> emit) async {
    emit(EmailSending());
    emit(EmailSended());
  }
}
