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

  late String username;
  late String password;

  EmailBloc() : super(EmailInitial()) {
    on<EmailEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<EmailConnect>(connect);
    on<EmailLoad>(load);
    on<EmailSend>(send);
    on<EmailMarkAsRead>(markAsRead);
    on<EmailSort>(sort);
  }

  void connect(EmailConnect event, Emitter<EmailState> emit) async {
    username = event.username;
    password = event.password;
    mailClient = Lyon1Mail(username, password);
    if (!await mailClient.login()) {
      emit(EmailError());
      return;
    }
    emit(EmailConnected());
  }

  void sort(EmailSort event, Emitter<EmailState> emit) async {
    emails = [];
    for (var i in emailsComplete) {
      if (i.subject.toLowerCase().contains(event.filter.toLowerCase()) ||
          i.excerpt.toLowerCase().contains(event.filter.toLowerCase()) ||
          i.date
              .toString()
              .toLowerCase()
              .contains(event.filter.toLowerCase()) ||
          i.sender.toLowerCase().contains(event.filter.toLowerCase())) {
        emails.add(i);
      }
    }
    emit(EmailSorted());
  }

  void markAsRead(EmailMarkAsRead event, Emitter<EmailState> emit) async {
    if (kDebugMode) {
      print("mark as read");
    }

    if (!event.email.isRead) {
      if (!mailClient.isAuthenticated) {
        if (!await mailClient.login()) {
          emit(EmailError());
          return;
        }
      }
      await mailClient.fetchMessages(1);
      await mailClient.markAsRead(event.email.id!);
    }

    emit(EmailUpdated());
  }

  void load(EmailLoad event, Emitter<EmailState> emit) async {
    emit(EmailLoading());
    emailsComplete = [];
    if (!mailClient.isAuthenticated) {
      if (!await mailClient.login()) {
        emit(EmailError());
        return;
      }
    }
    final Option<List<Mail>> emailOpt = await mailClient.fetchMessages(15);
    if (emailOpt.isNone()) {
      if (kDebugMode) {
        print("no emails");
      }
    } else {
      for (final Mail mail in emailOpt.toIterable().first) {
        emailsComplete.add(EmailModel.fromMailLib(mail));
      }
      emails = emailsComplete;
    }
    emit(EmailLoaded());
    await mailClient.logout();
  }

  void send(EmailSend event, Emitter<EmailState> emit) async {
    if (state is! EmailSending) {
      if (!mailClient.isAuthenticated) {
        if (!await mailClient.login()) {
          emit(EmailError());
          return;
        }
      }
      emit(EmailSending());
      if (kDebugMode) {
        print(mailClient.mailboxName);
        print(event.email.receiver);
        print(event.email.subject);
        print(event.email.body);
      }
      await mailClient.sendEmail(
        sender: mailClient.emailAddress,
        recipients: [
          (await mailClient.resolveContact(event.email.receiver))!,
        ],
        subject: 'test',
        body: 'bodytest',
      );
      await mailClient.sendEmail(
          sender: Address("eymeric.dechelette@etu.univ-lyon1.fr", "me"),
          recipients: [Address(event.email.receiver, "you")],
          subject: event.email.subject,
          body: event.email.body);
      emit(EmailSended());
    }
  }
}
