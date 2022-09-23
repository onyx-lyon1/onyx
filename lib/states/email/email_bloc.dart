// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:oloid2/model/email.dart';

part 'email_event.dart';

part 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  late Lyon1Mail mailClient;
  List<EmailModel> emails = [];
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
      for (final Mail mail in emailOpt.toIterable().first) {
        emails.add(EmailModel(
            subject: mail.getSubject(),
            sender: mail.getSender(),
            receiver: "me",
            excerpt: mail.getBody(),
            isRead: mail.isSeen(),
            date: mail.getDate()));
        if (kDebugMode) {
          print(
              "${mail.getSender()} sent ${mail.getSubject()} @${mail.getDate().toIso8601String()}");
          print("\tseen: ${mail.isSeen()}");
          print("\t${mail.getBody()}");
          print("\thasPJ: ${mail.hasAttachments()}");
          mail.getAttachmentsNames().forEach((fname) {
            if (kDebugMode) {
              print("\t\t$fname");
            }
          });
        }
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
