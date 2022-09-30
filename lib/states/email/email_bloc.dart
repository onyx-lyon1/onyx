// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:oloid2/model/mail_model.dart';

part 'email_event.dart';

part 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  late Lyon1Mail mailClient;
  List<EmailModel> emails = [];
  List<EmailModel> emailsComplete = [];

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
    on<EmailSort>(sort);
  }

  void sort(EmailSort event, Emitter<EmailState> emit) async {
    emails = [];
    print("sort");
    for (var i in emailsComplete) {
      if (i.subject.contains(event.filter) ||
          i.excerpt.contains(event.filter) ||
          i.date.toString().contains(event.filter) ||
          i.sender.contains(event.filter)) {
        emails.add(i);
      }
    }
    print(emails);
    emit(EmailSorted());
  }

  void markAsRead(EmailMarkAsRead event, Emitter<EmailState> emit) async {
    print("mark as read");

    if (!event.email.isRead) {
      await mailClient.markAsRead(event.email.id!);
      print("marker");
      print(event.email.id);
      print(event.email.isRead);
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
      // emails.addAll(emailOpt.toIterable().first);
      for (final Mail mail in emailOpt.toIterable().first) {
        emailsComplete.add(EmailModel.fromMailLib(mail));
      }
      emails = emailsComplete;
    }
    emit(EmailLoaded());
    await mailClient.logout();
  }

  void send(EmailSend event, Emitter<EmailState> emit) async {
    emit(EmailSending());
    emit(EmailSended());
  }
}
