// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:oloid2/functionalities/cache_service.dart';
import 'package:oloid2/functionalities/email_backend/email_backend.dart';
import 'package:oloid2/model/mail_model.dart';
import 'package:oloid2/model/wrapper/email_model_wrapper.dart';

part 'email_event.dart';

part 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  late Lyon1Mail mailClient;
  List<EmailModel> emails = [];
  List<EmailModel> emailsComplete = [];
  int emailNumber = 20;

  late String username;
  late String password;
  String lastFilter = "";

  EmailBloc() : super(EmailInitial()) {
    on<EmailEvent>((event, emit) {
      if (kDebugMode) {
        print("EmailBloc: $event");
      }
    });
    on<EmailConnect>(connect);
    on<EmailLoad>(load);
    on<EmailSend>(send);
    on<EmailMarkAsRead>(markAsRead);
    on<EmailDelete>(delete);
    on<EmailFilter>(filter);
    on<EmailIncreaseNumber>(increaseNumber);
  }

  void connect(EmailConnect event, Emitter<EmailState> emit) async {
    if (await CacheService.exist<EmailModelWrapper>()) {
      emailsComplete =
          (await CacheService.get<EmailModelWrapper>())!.emailModels;
      emails = emailsComplete;
      emit(EmailConnecting());
    }
    try {
      username = event.username;
      password = event.password;
      mailClient =
          await EmailBackend.connect(username: username, password: password);
      emit(EmailConnected());
    } catch (e) {
      emit(EmailError());
    }
  }

  void filter(EmailFilter event, Emitter<EmailState> emit) async {
    lastFilter = event.filter;
    if (event.filter != "") {
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
    } else {
      emails = emailsComplete;
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
    if (event.cache) {
      if (await CacheService.exist<EmailModelWrapper>()) {
        if (emailsComplete !=
            (await CacheService.get<EmailModelWrapper>())!.emailModels) {
          emailsComplete =
              (await CacheService.get<EmailModelWrapper>())!.emailModels;
          emails = emailsComplete;
          emit(EmailLoaded());
        }
      }
    }
    try {
      emailsComplete = await EmailBackend.load(
          emailNumber: emailNumber, mailClient: mailClient);
      emails = emailsComplete;
    } catch (e) {
      emit(EmailError());
      return;
    }
    CacheService.set<EmailModelWrapper>(
        EmailModelWrapper(emailsComplete)); //await à definir
    add(EmailFilter(lastFilter));
    emit(EmailLoaded());
  }

  void send(EmailSend event, Emitter<EmailState> emit) async {
    if (state is! EmailSending) {
      emit(EmailSending());
      try {
        await EmailBackend.send(
          email: event.email,
          mailClient: mailClient,
          replyOriginalMessageId: event.replyOriginalMessageId,
          replyAll: event.replyAll,
          emailNumber: emailNumber,
          emailsComplete: emailsComplete,
        );
      } catch (e) {
        emit(EmailError());
        return;
      }

      emit(EmailSended());
    }
  }

  void increaseNumber(EmailIncreaseNumber event, Emitter<EmailState> emit) {
    emailNumber += 20;
    emit(EmailLoading());
    add(EmailLoad());
    return;
  }
}
