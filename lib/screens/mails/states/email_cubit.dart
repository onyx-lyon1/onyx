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
  List<MailBoxModel> emailsBoxesComplete = [];
  late String username;
  late String password;
  String lastFilter = "";
  int emailNumber = 20;

  EmailCubit() : super(EmailState());

  void connect({required String? username, required String? password}) async {
    emit(state.copyWith(status: EmailStatus.connecting, connected: false));
    emailsBoxesComplete = await compute(
        EmailLogic.cacheLoad, (await getApplicationDocumentsDirectory()).path);
    emit(state.copyWith(
        mailBoxes: emailsBoxesComplete,
        status: EmailStatus.cacheLoaded,
        currentMailBox: emailsBoxesComplete.firstWhere(
            (element) => element.specialMailBox == SpecialMailBox.inbox)));
    if (username != null && password != null) {
      try {
        username = username;
        password = password;
        mailClient =
            await EmailLogic.connect(username: username, password: password);
        emit(state.copyWith(status: EmailStatus.connected, connected: true));
      } catch (e) {
        if (kDebugMode) {}
        emit(state.copyWith(status: EmailStatus.error));
      }
    }
  }

  void filter({required String filter}) async {
    lastFilter = filter;
    List<EmailModel> emails = [];
    if (filter != "") {
      for (var i in state.currentMailBox!.emails) {
        if (i.subject.toLowerCase().contains(filter.toLowerCase()) ||
            i.excerpt.toLowerCase().contains(filter.toLowerCase()) ||
            i.date.toString().toLowerCase().contains(filter.toLowerCase()) ||
            i.sender.toLowerCase().contains(filter.toLowerCase()) ||
            i.body.toLowerCase().contains(filter.toLowerCase())) {
          emails.add(i);
        }
      }
    } else {
      emails = state.currentMailBox!.emails;
    }
    emit(state.copyWith(
        status: (state.status == EmailStatus.cacheLoaded)
            ? EmailStatus.cacheSorted
            : EmailStatus.sorted));
  }

  void delete({required EmailModel email, required bool blockTrackers}) async {
    if (mailClient!.isAuthenticated) {
      await mailClient!.fetchMessages(20);
      await mailClient!.delete(email.id!);
      emit(state.copyWith(
          status: EmailStatus.updated,
          currentMailBox: state.currentMailBox!..emails.remove(email)));
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
      state.currentMailBox!.emails[state.currentMailBox!.emails.indexOf(email)]
          .isRead = true;
      List<EmailModel> emails = state.currentMailBox!.emails;
      emails[emails.indexOf(email)].isRead = true;
      CacheService.set<MailBoxWrapper>(
          MailBoxWrapper(mailBoxes: emailsBoxesComplete));
      emit(state.copyWith(status: EmailStatus.updated));
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
      state.currentMailBox!.emails[state.currentMailBox!.emails.indexOf(email)]
          .isFlagged = false;
      List<EmailModel> emails = state.currentMailBox!.emails;
      emails[state.currentMailBox!.emails.indexOf(email)].isFlagged = false;
      CacheService.set<MailBoxWrapper>(
          MailBoxWrapper(mailBoxes: emailsBoxesComplete));
      emit(state.copyWith(status: EmailStatus.updated));
    } else {
      if (!Res.mock) {
        await mailClient!.markAsFlagged(email.id!);
      }
      state.currentMailBox!.emails[state.currentMailBox!.emails.indexOf(email)]
          .isFlagged = true;
      List<EmailModel> emails = state.currentMailBox!.emails;
      emails[state.currentMailBox!.emails.indexOf(email)].isFlagged = true;
      CacheService.set<MailBoxWrapper>(
          MailBoxWrapper(mailBoxes: emailsBoxesComplete));
      emit(state.copyWith(status: EmailStatus.updated));
    }
  }

  void load(
      {bool cache = true,
      required bool blockTrackers,
      MailBoxModel? mailbox}) async {
    emit(state.copyWith(status: EmailStatus.loading));
    if (cache && !Res.mock) {
      List<MailBoxModel> emailCache = await compute(EmailLogic.cacheLoad,
          (await getApplicationDocumentsDirectory()).path);
      if (emailCache.isNotEmpty &&
          !listEquals(emailCache, emailsBoxesComplete)) {
        emailsBoxesComplete = emailCache;
        emit(state.copyWith(
            mailBoxes: emailsBoxesComplete,
            status: EmailStatus.cacheLoaded,
            currentMailBox: emailsBoxesComplete.firstWhere(
                (element) => element.specialMailBox == SpecialMailBox.inbox)));
        filter(filter: lastFilter);
      }
    }
    try {
      emailsBoxesComplete.add(await EmailLogic.load(
          emailNumber: emailNumber,
          mailClient: mailClient!,
          blockTrackers: blockTrackers,
          mailBox: mailbox));
    } catch (e) {
      emit(state.copyWith(status: EmailStatus.error));
      return;
    }
    CacheService.set<MailBoxWrapper>(
        MailBoxWrapper(mailBoxes: emailsBoxesComplete)); //await à definir
    emit(state.copyWith(
        status: EmailStatus.loaded, mailBoxes: emailsBoxesComplete,
        currentMailBox: (mailbox == null)
            ? emailsBoxesComplete.firstWhere(
                (element) => element.specialMailBox == SpecialMailBox.inbox)
            : mailbox
    ));
    print("emit loaded");
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
          emailsComplete: state.currentMailBox!.emails,
        );
      } catch (e) {
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
    emailsBoxesComplete = [];
    emailNumber = 20;
    lastFilter = "";
    emit(EmailState(status: EmailStatus.initial));
  }
}
