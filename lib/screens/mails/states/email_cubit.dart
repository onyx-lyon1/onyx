import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:oloid2/core/cache_service.dart';
import 'package:oloid2/screens/mails/mails_export.dart';
import 'package:path_provider/path_provider.dart';

part 'email_state.dart';

class EmailCubit extends Cubit<EmailState> {
  late Lyon1Mail mailClient;
  List<EmailModel> emailsComplete = [];
  late String username;
  late String password;
  String lastFilter = "";
  int emailNumber = 20;

  EmailCubit() : super(EmailState());

  void connect({required String? username, required String? password}) async {
    emit(state.copyWith(status: EmailStatus.connecting, connected: false));
    emailsComplete = await compute(
        EmailLogic.cacheLoad, (await getApplicationDocumentsDirectory()).path);
    emit(state.copyWith(
        emails: emailsComplete, status: EmailStatus.cacheLoaded));
    if (username != null && password != null) {
      try {
        username = username;
        password = password;
        mailClient =
            await EmailLogic.connect(username: username, password: password);
        emit(state.copyWith(status: EmailStatus.connected, connected: true));
      } catch (e) {
        if (kDebugMode) {
          print("Error while connecting to mail: $e");
        }
        emit(state.copyWith(status: EmailStatus.error));
      }
    }
  }

  void filter({required String filter}) async {
    lastFilter = filter;
    List<EmailModel> emails = [];
    if (filter != "") {
      for (var i in emailsComplete) {
        if (i.subject.toLowerCase().contains(filter.toLowerCase()) ||
            i.excerpt.toLowerCase().contains(filter.toLowerCase()) ||
            i.date.toString().toLowerCase().contains(filter.toLowerCase()) ||
            i.sender.toLowerCase().contains(filter.toLowerCase()) ||
            i.body.toLowerCase().contains(filter.toLowerCase())) {
          emails.add(i);
        }
      }
    } else {
      emails = emailsComplete;
    }
    emit(state.copyWith(
        emails: emails,
        status: (state.status == EmailStatus.cacheLoaded)
            ? EmailStatus.cacheSorted
            : EmailStatus.sorted));
  }

  void delete({required EmailModel email}) async {
    if (mailClient.isAuthenticated) {
      await mailClient.fetchMessages(20);
      await mailClient.delete(email.id!);
      emit(state.copyWith(
          status: EmailStatus.updated, emails: state.emails..remove(email)));
      load(cache: false);
    }
    emit(state.copyWith(status: EmailStatus.updated));
  }

  void markAsRead({required EmailModel email}) async {
    if (!email.isRead) {
      if (!mailClient.isAuthenticated) {
        if (!await mailClient.login()) {
          emit(state.copyWith(status: EmailStatus.error));
          return;
        }
      }
      await mailClient.fetchMessages(1);
      await mailClient.markAsRead(email.id!);
      emailsComplete[emailsComplete.indexOf(email)].isRead = true;
      List<EmailModel> emails = state.emails;
      emails[emails.indexOf(email)].isRead = true;
      CacheService.set<EmailModelWrapper>(EmailModelWrapper(emailsComplete));
      emit(state.copyWith(status: EmailStatus.updated, emails: emails));
    }
  }

  void toggleFlag({required EmailModel email}) async {
    if (!mailClient.isAuthenticated) {
      if (!await mailClient.login()) {
        emit(state.copyWith(status: EmailStatus.error));
        return;
      }
    }
    await mailClient.fetchMessages(1);

    if (email.isFlagged) {
      await mailClient.unmarkAsFlagged(email.id!);
      emailsComplete[emailsComplete.indexOf(email)].isFlagged = false;
      List<EmailModel> emails = state.emails;
      emails[emailsComplete.indexOf(email)].isFlagged = false;
      CacheService.set<EmailModelWrapper>(EmailModelWrapper(emailsComplete));
      emit(state.copyWith(status: EmailStatus.updated, emails: emails));
    } else {
      await mailClient.markAsFlagged(email.id!);
      emailsComplete[emailsComplete.indexOf(email)].isFlagged = true;
      List<EmailModel> emails = state.emails;
      emails[emailsComplete.indexOf(email)].isFlagged = true;
      CacheService.set<EmailModelWrapper>(EmailModelWrapper(emailsComplete));
      emit(state.copyWith(status: EmailStatus.updated, emails: emails));
    }
  }

  void load({bool cache = true}) async {
    emit(state.copyWith(status: EmailStatus.loading));
    if (cache) {
      List<EmailModel> emailCache = await compute(EmailLogic.cacheLoad,
          (await getApplicationDocumentsDirectory()).path);
      if (emailCache.isNotEmpty && !listEquals(emailCache, emailsComplete)) {
        emailsComplete = emailCache;
        emit(state.copyWith(
            emails: emailsComplete, status: EmailStatus.cacheLoaded));
        filter(filter: lastFilter);
      }
    }
    try {
      emailsComplete = await EmailLogic.load(
          emailNumber: emailNumber, mailClient: mailClient);
    } catch (e) {
      emit(state.copyWith(status: EmailStatus.error));
      return;
    }
    CacheService.set<EmailModelWrapper>(
        EmailModelWrapper(emailsComplete)); //await à definir
    emit(state.copyWith(status: EmailStatus.loaded, emails: emailsComplete));
    filter(filter: lastFilter);
  }

  void send(
      {required EmailModel email,
      int? replyOriginalMessageId,
      bool? replyAll}) async {
    if (state.status != EmailStatus.sending) {
      emit(state.copyWith(status: EmailStatus.sending));
      try {
        await EmailLogic.send(
          email: email,
          mailClient: mailClient,
          replyOriginalMessageId: replyOriginalMessageId,
          replyAll: replyAll,
          emailNumber: emailNumber,
          emailsComplete: emailsComplete,
        );
      } catch (e) {
        emit(state.copyWith(status: EmailStatus.error));
        return;
      }

      emit(state.copyWith(status: EmailStatus.sended));
    }
  }

  void increaseNumber() {
    emailNumber += 20;
    emit(state.copyWith(status: EmailStatus.loading));
    load(cache: false);
    return;
  }
}
