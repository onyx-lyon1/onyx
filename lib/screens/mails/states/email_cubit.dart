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
  int currentMailBoxIndex = 0;
  late String username;
  late String password;
  String lastFilter = "";
  int emailNumber = 20;

  EmailCubit() : super(EmailState());

  void connect({required String? username, required String? password}) async {
    emit(state.copyWith(status: EmailStatus.connecting, connected: false));
    emailsBoxesComplete = await compute(
        EmailLogic.cacheLoad, (await getApplicationDocumentsDirectory()).path);
    if (emailsBoxesComplete.isNotEmpty) {
      currentMailBoxIndex = emailsBoxesComplete.indexWhere(
        (element) => element.specialMailBox == SpecialMailBox.inbox,
      );
      emit(
        state.copyWith(
            mailBoxes: emailsBoxesComplete,
            status: EmailStatus.cacheLoaded,
            currentMailBox: emailsBoxesComplete[currentMailBoxIndex]),
      );
    }

    if (username != null && password != null) {
      try {
        username = username;
        password = password;
        mailClient =
            await EmailLogic.connect(username: username, password: password);
        emit(state.copyWith(status: EmailStatus.connected, connected: true));
        // List<MailBoxModel> mailboxesOpt =
        // await EmailLogic.getMailBoxList(mailClient: mailClient!);
        // print("mailboxes fetched");
        // currentMailBoxIndex = mailboxesOpt.indexWhere(
        //       (element) => element.specialMailBox == SpecialMailBox.inbox,
        // );
        // emit(state.copyWith(
        //     mailBoxes: mailboxesOpt,
        //     status: EmailStatus.mailboxesLoaded,
        //     currentMailBox: (currentMailBoxIndex != -1) ? mailboxesOpt[currentMailBoxIndex] : null));
      } catch (e) {
        if (kDebugMode) {}
        emit(state.copyWith(status: EmailStatus.error));
      }
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
        late MailBoxModel currentMailBox;
        if (mailbox != null) {
          if (mailbox.specialMailBox != null) {
            currentMailBoxIndex = emailsBoxesComplete.indexWhere(
                (element) => element.specialMailBox == mailbox.specialMailBox);
          } else {
            currentMailBoxIndex = emailsBoxesComplete
                .indexWhere((element) => element.name == mailbox.name);
          }
        }
        if (currentMailBoxIndex == -1) {
          Future.error("Mailbox not found in cache");
          currentMailBox = emailsBoxesComplete[0];
        } else {
          currentMailBox = emailsBoxesComplete[currentMailBoxIndex];
        }
        emit(state.copyWith(
            mailBoxes: emailsBoxesComplete,
            status: EmailStatus.cacheLoaded,
            currentMailBox: currentMailBox));
        filter(filter: lastFilter);
      }
    }
    try {
      List<MailBoxModel> emailBoxes =
          await EmailLogic.getMailboxes(mailClient: mailClient!);
      for (var i in emailBoxes) {
        if (emailsBoxesComplete
                .indexWhere((element) => element.name == i.name) ==
            -1) {
          emailsBoxesComplete.add(i);
        }
      }
      emit(state.copyWith(
          mailBoxes: emailsBoxesComplete, status: EmailStatus.mailboxesLoaded));
      MailBoxModel loadedMail = (await EmailLogic.load(
        emailNumber: emailNumber,
        mailClient: mailClient!,
        blockTrackers: blockTrackers,
        mailBox: mailbox,
      ));
      int index = emailsBoxesComplete.indexWhere((element) =>
          element.name == loadedMail.name ||
          element.specialMailBox == loadedMail.specialMailBox);
      if (index != -1) {
        emailsBoxesComplete[index].emails = loadedMail.emails;
      }
    } catch (e) {
      if (kDebugMode) {
        print("error: $e");
      }
      emit(state.copyWith(status: EmailStatus.error));
      return;
    }
    CacheService.set<MailBoxWrapper>(
        MailBoxWrapper(mailBoxes: emailsBoxesComplete)); //await à definir
    currentMailBoxIndex = emailsBoxesComplete.indexWhere(
        (element) => element.specialMailBox == SpecialMailBox.inbox);

    emit(state.copyWith(
        status: EmailStatus.loaded,
        mailBoxes: emailsBoxesComplete,
        currentMailBox: (mailbox == null && currentMailBoxIndex != -1)
            ? emailsBoxesComplete[currentMailBoxIndex]
            : mailbox));
    filter(filter: lastFilter);
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
    ActionModel action = ActionModel(
        type: ActionType.delete, email: email, mailBox: state.currentMailBox!);
    await EmailLogic.addAction(action);
    emailsBoxesComplete[currentMailBoxIndex].emails.remove(email);
    emit(state.copyWith(
        status: EmailStatus.updated,
        mailBoxes: emailsBoxesComplete,
        currentMailBox:
            emailsBoxesComplete[currentMailBoxIndex])); //do it locally
    CacheService.set<MailBoxWrapper>(
        MailBoxWrapper(mailBoxes: emailsBoxesComplete));
    if (mailClient!.isAuthenticated) {
      try {
        await mailClient!.fetchMessages(20);
        await mailClient!.delete(email.id!);
        await EmailLogic.removeAction(action);
      } catch (e) {
        if (kDebugMode) {
          print("error: $e");
        }
        emit(state.copyWith(status: EmailStatus.nonFatalError));
      }
    }
    emit(state.copyWith(status: EmailStatus.updated));
  }

  void markAsRead({required EmailModel email}) async {
    if (!email.isRead) {
      ActionModel action = ActionModel(
          type: ActionType.markAsRead,
          email: email,
          mailBox: state.currentMailBox!);
      await EmailLogic.addAction(action);
      emailsBoxesComplete[currentMailBoxIndex]
          .emails[
              emailsBoxesComplete[currentMailBoxIndex].emails.indexOf(email)]
          .isRead = true;
      CacheService.set<MailBoxWrapper>(
          MailBoxWrapper(mailBoxes: emailsBoxesComplete));
      emit(state.copyWith(
          status: EmailStatus.updated,
          mailBoxes: emailsBoxesComplete,
          currentMailBox: emailsBoxesComplete[currentMailBoxIndex]));

      if (!mailClient!.isAuthenticated && !Res.mock) {
        if (!await mailClient!.login()) {
          emit(state.copyWith(status: EmailStatus.nonFatalError));
          return;
        }
      }
      if (!Res.mock) {
        try {
          await mailClient!.fetchMessages(1);
          await mailClient!.markAsRead(email.id!);
          await EmailLogic.removeAction(action);
        } catch (e) {
          if (kDebugMode) {
            print("error: $e");
          }
          emit(state.copyWith(status: EmailStatus.nonFatalError));
        }
      }
    }
  }

  Future<void> archive({required EmailModel email}) async {
    ActionModel action = ActionModel(
        type: ActionType.archive, email: email, mailBox: state.currentMailBox!);
    await EmailLogic.addAction(action);

    emailsBoxesComplete[currentMailBoxIndex].emails.remove(email);
    emailsBoxesComplete
        .firstWhere(
            (element) => element.specialMailBox == SpecialMailBox.archive)
        .emails
        .add(email);
    CacheService.set<MailBoxWrapper>(
        MailBoxWrapper(mailBoxes: emailsBoxesComplete));
    emit(state.copyWith(
        status: EmailStatus.updated,
        mailBoxes: emailsBoxesComplete,
        currentMailBox:
            emailsBoxesComplete[currentMailBoxIndex])); //do it locally

    if (!mailClient!.isAuthenticated && !Res.mock) {
      if (!await mailClient!.login()) {
        emit(state.copyWith(status: EmailStatus.nonFatalError));
        return;
      }
    }
    try {
      await EmailLogic.archiveEmail(mailClient: mailClient!, email: email);
      await EmailLogic.removeAction(action);
    } catch (e) {
      if (kDebugMode) {
        print("error: $e");
      }
      emit(state.copyWith(status: EmailStatus.nonFatalError));
    }
  }

  Future<void> move(
      {required EmailModel email, required MailBoxModel folder}) async {
    ActionModel action = ActionModel(
        type: ActionType.move,
        email: email,
        destinationMailBox: folder,
        mailBox: state.currentMailBox!);
    await EmailLogic.addAction(action);

    emailsBoxesComplete[currentMailBoxIndex].emails.remove(email);
    emailsBoxesComplete[emailsBoxesComplete.indexOf(folder)].emails.add(email);
    CacheService.set<MailBoxWrapper>(
        MailBoxWrapper(mailBoxes: emailsBoxesComplete));
    emit(state.copyWith(
        status: EmailStatus.updated,
        mailBoxes: emailsBoxesComplete,
        currentMailBox:
            emailsBoxesComplete[currentMailBoxIndex])); //do it locally

    if (!mailClient!.isAuthenticated && !Res.mock) {
      if (!await mailClient!.login()) {
        emit(state.copyWith(status: EmailStatus.error));
        return;
      }
    }
    try {
      await EmailLogic.moveEmail(
          mailClient: mailClient!, email: email, destinationMailbox: folder);
      await EmailLogic.removeAction(action);
    } catch (e) {
      emit(state.copyWith(status: EmailStatus.error));
    }
  }

  void markAsUnread({required EmailModel email}) async {
    if (email.isRead) {
      ActionModel action = ActionModel(
          type: ActionType.markAsUnread,
          email: email,
          mailBox: state.currentMailBox!);
      await EmailLogic.addAction(action);
      emailsBoxesComplete[currentMailBoxIndex]
          .emails[
              emailsBoxesComplete[currentMailBoxIndex].emails.indexOf(email)]
          .isRead = false;
      CacheService.set<MailBoxWrapper>(
          MailBoxWrapper(mailBoxes: emailsBoxesComplete));
      emit(state.copyWith(
          status: EmailStatus.updated,
          mailBoxes: emailsBoxesComplete,
          currentMailBox: emailsBoxesComplete[currentMailBoxIndex]));

      if (!mailClient!.isAuthenticated && !Res.mock) {
        if (!await mailClient!.login()) {
          emit(state.copyWith(status: EmailStatus.nonFatalError));
          return;
        }
      }
      if (!Res.mock) {
        try {
          await mailClient!.fetchMessages(1);
          await mailClient!.markAsUnread(email.id!);
          await EmailLogic.removeAction(action);
        } catch (e) {
          if (kDebugMode) {
            print("error: $e");
          }
          emit(state.copyWith(status: EmailStatus.nonFatalError));
        }
      }
    }
  }

  void toggleFlag({required EmailModel email}) async {
    if (email.isFlagged) {
      flag(email: email);
    } else {
      unflag(email: email);
    }
  }

  void flag({required EmailModel email}) async {
    ActionModel action = ActionModel(
        type: ActionType.flag, email: email, mailBox: state.currentMailBox!);
    await EmailLogic.addAction(action);
    emailsBoxesComplete[currentMailBoxIndex]
        .emails[emailsBoxesComplete[currentMailBoxIndex].emails.indexOf(email)]
        .isFlagged = true;
    CacheService.set<MailBoxWrapper>(
        MailBoxWrapper(mailBoxes: emailsBoxesComplete));
    emit(state.copyWith(
        status: EmailStatus.updated,
        mailBoxes: emailsBoxesComplete,
        currentMailBox: emailsBoxesComplete[currentMailBoxIndex]));

    if (!mailClient!.isAuthenticated && !Res.mock) {
      if (!await mailClient!.login()) {
        emit(state.copyWith(status: EmailStatus.nonFatalError));
        return;
      }
    }
    if (!Res.mock) {
      try {
        await mailClient!.fetchMessages(1);
        await mailClient!.unmarkAsFlagged(email.id!);
        await EmailLogic.removeAction(action);
      } catch (e) {
        if (kDebugMode) {
          print("error: $e");
        }
        emit(state.copyWith(status: EmailStatus.nonFatalError));
      }
    }
  }

  void unflag({required EmailModel email}) async {
    ActionModel action = ActionModel(
        type: ActionType.unflag, email: email, mailBox: state.currentMailBox!);
    await EmailLogic.addAction(action);
    emailsBoxesComplete[currentMailBoxIndex]
        .emails[emailsBoxesComplete[currentMailBoxIndex].emails.indexOf(email)]
        .isFlagged = false;
    CacheService.set<MailBoxWrapper>(
        MailBoxWrapper(mailBoxes: emailsBoxesComplete));
    emit(state.copyWith(
        status: EmailStatus.updated,
        mailBoxes: emailsBoxesComplete,
        currentMailBox: emailsBoxesComplete[currentMailBoxIndex]));
    if (!mailClient!.isAuthenticated && !Res.mock) {
      if (!await mailClient!.login()) {
        emit(state.copyWith(status: EmailStatus.nonFatalError));
        return;
      }
    }
    if (!Res.mock) {
      try {
        await mailClient!.fetchMessages(1);
        await mailClient!.markAsFlagged(email.id!);
        await EmailLogic.removeAction(action);
      } catch (e) {
        if (kDebugMode) {
          print("error: $e");
        }
        emit(state.copyWith(status: EmailStatus.nonFatalError));
      }
    }
  }

  void send(
      {required EmailModel email,
      int? replyOriginalMessageId,
      bool? replyAll,
      bool reply = false,
      bool forward = false}) async {
    ActionModel action = ActionModel(
        type: (reply)
            ? ActionType.reply
            : ((forward) ? ActionType.forward : ActionType.send),
        email: email,
        mailBox: state.currentMailBox!,
        originalMessageId: replyOriginalMessageId,
        replyAll: replyAll);
    await EmailLogic.addAction(action);
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
        );
        await EmailLogic.removeAction(action);
      } catch (e) {
        emit(state.copyWith(status: EmailStatus.error));
        return;
      }

      emit(state.copyWith(status: EmailStatus.sended));
    }
  }

  void selectEmail({required EmailModel email}) {
    emit(state.copyWith(
        selectedEmails: List.from(state.selectedEmails)..add(email)));
  }

  void unselectEmail({required EmailModel email}) {
    emit(state.copyWith(
        selectedEmails: List.from(state.selectedEmails)..remove(email)));
  }

  void unselectAllEmails() {
    emit(state.copyWith(selectedEmails: []));
  }

  void toggleEmailSelection({required EmailModel email}) {
    if (state.selectedEmails.contains(email)) {
      unselectEmail(email: email);
    } else {
      selectEmail(email: email);
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

  void doQueuedAction({required bool blockTrackers}) async {
    final List<ActionModel> actions =
        (await CacheService.get<ActionModelWrapper>())?.action ?? [];
    if (actions.isEmpty || state.status != EmailStatus.initial) return;
    for (ActionModel action in actions) {
      currentMailBoxIndex = emailsBoxesComplete
          .indexWhere((element) => element.name == action.mailBox.name);
      switch (action.type) {
        case ActionType.archive:
          archive(email: action.email!);
          break;
        case ActionType.move:
          move(email: action.email!, folder: action.destinationMailBox!);
          break;
        case ActionType.markAsUnread:
          markAsUnread(email: action.email!);
          break;
        case ActionType.send:
          send(email: action.email!);
          break;
        case ActionType.markAsRead:
          markAsRead(email: action.email!);
          break;
        case ActionType.reply:
          send(
            email: action.email!,
            replyOriginalMessageId: action.originalMessageId!,
            replyAll: action.replyAll,
            reply: true,
          );
          break;
        case ActionType.replyAll:
          send(
            email: action.email!,
            replyOriginalMessageId: action.originalMessageId!,
            replyAll: action.replyAll,
            reply: true,
          );
          break;
        case ActionType.forward:
          send(
            email: action.email!,
            replyOriginalMessageId: action.originalMessageId!,
            forward: true,
          );
          break;
        case ActionType.delete:
          delete(email: action.email!, blockTrackers: blockTrackers);
          break;
        case ActionType.flag:
          flag(email: action.email!);
          break;
        case ActionType.unflag:
          unflag(email: action.email!);
          break;
      }
    }
  }
}
