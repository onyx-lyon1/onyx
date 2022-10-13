// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:oloid2/model/mail_model.dart';
import 'package:oloid2/model/wrapper/email_model_wrapper.dart';
import 'package:oloid2/others/cache_service.dart';

part 'email_event.dart';

part 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  late Lyon1Mail mailClient;
  List<EmailModel> emails = [];
  List<EmailModel> emailsComplete = [];
  int emailNumber = 20;

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
    on<EmailDelete>(delete);
    on<EmailSort>(sort);
    on<EmailIncreaseNumber>(increaseNumber);
  }

  void connect(EmailConnect event, Emitter<EmailState> emit) async {
    if (await CacheService.exist<EmailModelWrapper>()) {
      emailsComplete =
          (await CacheService.get<EmailModelWrapper>())!.emailModels;
      emails = emailsComplete;
      emit(EmailConnecting());
    }
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

  void delete(EmailDelete event, Emitter<EmailState> emit) async {
    if (!mailClient.isAuthenticated) {
      if (!await mailClient.login()) {
        emit(EmailError());
        return;
      }
      await mailClient.fetchMessages(1);
      await mailClient.delete(event.email.id!);
    }

    emit(EmailUpdated());
  }

  void markAsRead(EmailMarkAsRead event, Emitter<EmailState> emit) async {
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
    if (await CacheService.exist<EmailModelWrapper>()) {
      emailsComplete =
          (await CacheService.get<EmailModelWrapper>())!.emailModels;
      emails = emailsComplete;
      emit(EmailLoaded());
    }
    List<EmailModel> tmpEmailsComplete = [];
    if (!mailClient.isAuthenticated) {
      if (!await mailClient.login()) {
        emit(EmailError());
        return;
      }
    }
    final Option<List<Mail>> emailOpt =
        await mailClient.fetchMessages(emailNumber);
    if (emailOpt.isNone()) {
      if (kDebugMode) {
        print("no emails");
      }
    } else {
      for (final Mail mail in emailOpt.toIterable().first) {
        if (!tmpEmailsComplete.any((element) =>
            element.date == mail.getDate() &&
            element.body == mail.getBody(excerpt: false))) {
          tmpEmailsComplete.add(EmailModel.fromMailLib(mail));
        }
      }
      emailsComplete = tmpEmailsComplete;
      emails = emailsComplete;
      CacheService.set<EmailModelWrapper>(
          EmailModelWrapper(emailsComplete)); //await à definir
    }
    emit(EmailLoaded());
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
      if (event.replyOriginalMessageId != null) {
        try {
          await mailClient.fetchMessages(emailNumber);
          await mailClient.reply(
            originalMessageId: event.replyOriginalMessageId!,
            subject: event.email.subject,
            body: event.email.body,
            replyAll: event.replyAll ?? false,
            sender: mailClient.emailAddress,
          );
        } catch (e) {
          emit(EmailError());
          return;
        }
      } else {
        try {
          List<Address> recipients = [];
          if (event.email.receiver.contains("@") &&
              event.email.receiver.contains(".")) {
            recipients.add(Address(event.email.receiver, event.email.receiver));
          } else {
            Address? resolvedAddress =
                (await mailClient.resolveContact(event.email.receiver));
            if (resolvedAddress != null) {
              recipients.add(resolvedAddress);
            } else {
              emit(EmailUnableToResolve());
              return;
            }
          }
          await mailClient.sendEmail(
            sender: mailClient.emailAddress,
            recipients: recipients,
            subject: event.email.subject,
            body: event.email.body,
          );
        } catch (e) {
          emit(EmailError());
          return;
        }
      }
      emit(EmailSended());
    }
  }

  void increaseNumber(EmailIncreaseNumber event, Emitter<EmailState> emit) {
    emailNumber += 20;
    emit(EmailUpdated());
    add(EmailLoad());
  }
}
