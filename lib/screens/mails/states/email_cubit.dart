import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:path_provider/path_provider.dart';

part 'email_state.dart';

class EmailCubit extends Cubit<EmailState> {
  Lyon1Mail? mailClient;
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
        print("Connecting to mail");
        mailClient =
            await EmailLogic.connect(username: username, password: password);
        print("Connected to mail");
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
    print("Filtering: $filter");
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
          print("Added: ${i.subject}");
        }
      }
    } else {
      emails = emailsComplete;
      print("Added all");
    }
    print("emit");
    emit(state.copyWith(
        emails: emails,
        status: (state.status == EmailStatus.cacheLoaded)
            ? EmailStatus.cacheSorted
            : EmailStatus.sorted));
  }

  void delete({required EmailModel email, required bool blockTrackers}) async {
    if (mailClient!.isAuthenticated) {
      await mailClient!.fetchMessages(20);
      await mailClient!.delete(email.id!);
      emit(state.copyWith(
          status: EmailStatus.updated, emails: state.emails..remove(email)));
      load(cache: false, blockTrackers: blockTrackers);
    }
    emit(state.copyWith(status: EmailStatus.updated));
  }

  void markAsRead({required EmailModel email}) async {
    if (!email.isRead) {
      if (!mailClient!.isAuthenticated && !Res.mock) {
        if (!await mailClient!.login()) {
          emit(state.copyWith(status: EmailStatus.error));
          return;
        }
      }
      if (!Res.mock) {
        await mailClient!.fetchMessages(1);
        await mailClient!.markAsRead(email.id!);
      }
      emailsComplete[emailsComplete.indexOf(email)].isRead = true;
      List<EmailModel> emails = state.emails;
      emails[emails.indexOf(email)].isRead = true;
      CacheService.set<EmailModelWrapper>(EmailModelWrapper(emailsComplete));
      emit(state.copyWith(status: EmailStatus.updated, emails: emails));
    }
  }

  void toggleFlag({required EmailModel email}) async {
    if (!mailClient!.isAuthenticated && !Res.mock) {
      if (!await mailClient!.login()) {
        emit(state.copyWith(status: EmailStatus.error));
        return;
      }
    }
    if (!Res.mock) {
      await mailClient!.fetchMessages(1);
    }

    if (email.isFlagged) {
      if (!Res.mock) {
        await mailClient!.unmarkAsFlagged(email.id!);
      }
      emailsComplete[emailsComplete.indexOf(email)].isFlagged = false;
      List<EmailModel> emails = state.emails;
      emails[emailsComplete.indexOf(email)].isFlagged = false;
      CacheService.set<EmailModelWrapper>(EmailModelWrapper(emailsComplete));
      emit(state.copyWith(status: EmailStatus.updated, emails: emails));
    } else {
      if (!Res.mock) {
        await mailClient!.markAsFlagged(email.id!);
      }
      emailsComplete[emailsComplete.indexOf(email)].isFlagged = true;
      List<EmailModel> emails = state.emails;
      emails[emailsComplete.indexOf(email)].isFlagged = true;
      CacheService.set<EmailModelWrapper>(EmailModelWrapper(emailsComplete));
      emit(state.copyWith(status: EmailStatus.updated, emails: emails));
    }
  }

  void load({bool cache = true, required bool blockTrackers}) async {
    emit(state.copyWith(status: EmailStatus.loading));
    if (cache && !Res.mock) {
      List<EmailModel> emailCache = await compute(EmailLogic.cacheLoad,
          (await getApplicationDocumentsDirectory()).path);
      if (emailCache.isNotEmpty && !listEquals(emailCache, emailsComplete)) {
        emailsComplete = emailCache;
        emit(state.copyWith(
            emails: emailsComplete, status: EmailStatus.cacheLoaded));
        print("filter from cache");
        filter(filter: lastFilter);
      }
    }
    try {
      emailsComplete = await EmailLogic.load(
          emailNumber: emailNumber,
          mailClient: mailClient!,
          blockTrackers: blockTrackers);
    } catch (e) {
      emit(state.copyWith(status: EmailStatus.error));
      return;
    }
    CacheService.set<EmailModelWrapper>(
        EmailModelWrapper(emailsComplete)); //await à definir
    print("emit loaded");
    emit(state.copyWith(status: EmailStatus.loaded, emails: emailsComplete));
    print("filter from load");

    filter(filter: lastFilter);
  }

  void send(
      {required EmailModel email,
      int? replyOriginalMessageId,
      bool? replyAll,
      bool reply = false,
      bool forward = false}) async {
    if (state.status != EmailStatus.sending) {
      emit(state.copyWith(status: EmailStatus.sending));
      try {
        await EmailLogic.send(
          email: email,
          mailClient: mailClient!,
          originalMessageId: replyOriginalMessageId,
          replyAll: replyAll,
          forward: forward,
          reply: reply,
          emailNumber: emailNumber,
          emailsComplete: emailsComplete,
        );
      } catch (e) {
        print(e);
        emit(state.copyWith(status: EmailStatus.error));
        return;
      }

      emit(state.copyWith(status: EmailStatus.sended));
    }
  }

  void increaseNumber({required bool blockTrackers}) {
    emailNumber += 20;
    emit(state.copyWith(status: EmailStatus.loading));
    load(cache: false, blockTrackers: blockTrackers);
    return;
  }

  void resetCubit() {
    mailClient = null;
    emailsComplete = [];
    emailNumber = 20;
    lastFilter = "";
    emit(EmailState(status: EmailStatus.initial));
  }
}
