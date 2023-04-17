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
      } catch (e) {
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
      //ensure that there is a sending box
      if (emailBoxes.indexWhere((element) => element.name == "Boîte d'envoi") !=
          -1) {
        emailBoxes.add(MailBoxModel(name: "Boîte d'envoi", emails: []));
      }
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

    final List<ActionModel> actions =
        (await CacheService.get<ActionModelWrapper>())?.action ?? [];
    for (var action in actions) {
      print(action);
      if (action.type == ActionType.send ||
          action.type == ActionType.reply ||
          action.type == ActionType.forward ||
          action.type == ActionType.replyAll) {
        emailsBoxesComplete
            .firstWhere((element) => element.name == "Boîte d'envoi")
            .emails
            .add(action.email!);
      }
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
      for (var i in emailsBoxesComplete
          .firstWhere((element) => state.currentMailBox!.name == element.name)
          .emails) {
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
          : EmailStatus.sorted,
      currentMailBox: state.currentMailBox!..emails = emails,
    ));
  }

  void delete(
      {required EmailModel email,
      required bool blockTrackers,
      required MailBoxModel from}) async {
    ActionModel action =
        ActionModel(type: ActionType.delete, email: email, fromMailBox: from);
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
        await mailClient!.selectMailbox((await EmailLogic.mailBoxToMailLib(
            mailClient: mailClient!, mailBoxModel: from))!);
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

  void markAsRead(
      {required EmailModel email, required MailBoxModel from}) async {
    if (!email.isRead) {
      ActionModel action = ActionModel(
          type: ActionType.markAsRead, email: email, fromMailBox: from);
      await EmailLogic.addAction(action);
      int index =
          emailsBoxesComplete[currentMailBoxIndex].emails.indexOf(email);
      if (index == -1) return;
      emailsBoxesComplete[currentMailBoxIndex].emails[index].isRead = true;
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
          await mailClient!.selectMailbox((await EmailLogic.mailBoxToMailLib(
              mailClient: mailClient!, mailBoxModel: from))!);
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

  Future<void> archive(
      {required EmailModel email, required MailBoxModel from}) async {
    ActionModel action =
        ActionModel(type: ActionType.archive, email: email, fromMailBox: from);
    await EmailLogic.addAction(action);

    emailsBoxesComplete[currentMailBoxIndex].emails.remove(email);
    int index = emailsBoxesComplete.indexWhere(
        (element) => element.specialMailBox == SpecialMailBox.archive);
    if (index != -1) {
      emailsBoxesComplete[index].emails.add(email);
    } else {
      emailsBoxesComplete.add(MailBoxModel(
          name: "Archive",
          specialMailBox: SpecialMailBox.archive,
          emails: [email]));
    }
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
      await EmailLogic.archiveEmail(
          mailClient: mailClient!, email: email, from: from);
      await EmailLogic.removeAction(action);
    } catch (e) {
      if (kDebugMode) {
        print("error: $e");
      }
      emit(state.copyWith(status: EmailStatus.nonFatalError));
    }
  }

  Future<void> move(
      {required EmailModel email,
      required MailBoxModel folder,
      required MailBoxModel from}) async {
    ActionModel action = ActionModel(
        type: ActionType.move,
        email: email,
        destinationMailBox: folder,
        fromMailBox: from);
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
          mailClient: mailClient!,
          email: email,
          destinationMailbox: folder,
          from: from);
      await EmailLogic.removeAction(action);
    } catch (e) {
      emit(state.copyWith(status: EmailStatus.nonFatalError));
    }
  }

  void markAsUnread(
      {required EmailModel email, required MailBoxModel from}) async {
    if (email.isRead) {
      ActionModel action = ActionModel(
          type: ActionType.markAsUnread, email: email, fromMailBox: from);
      await EmailLogic.addAction(action);
      int index =
          emailsBoxesComplete[currentMailBoxIndex].emails.indexOf(email);
      if (index == -1) return;
      emailsBoxesComplete[currentMailBoxIndex].emails[index].isRead = false;
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
          await mailClient!.selectMailbox((await EmailLogic.mailBoxToMailLib(
              mailClient: mailClient!, mailBoxModel: from))!);
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

  void toggleFlag(
      {required EmailModel email, required MailBoxModel from}) async {
    if (email.isFlagged) {
      unflag(email: email, from: from);
    } else {
      flag(email: email, from: from);
    }
  }

  void flag({required EmailModel email, required MailBoxModel from}) async {
    ActionModel action =
        ActionModel(type: ActionType.flag, email: email, fromMailBox: from);
    await EmailLogic.addAction(action);
    int index = emailsBoxesComplete[currentMailBoxIndex].emails.indexOf(email);
    if (index == -1) return;
    emailsBoxesComplete[currentMailBoxIndex].emails[index].isFlagged = true;
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
        await mailClient!.selectMailbox((await EmailLogic.mailBoxToMailLib(
            mailClient: mailClient!, mailBoxModel: from))!);
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

  void unflag({
    required EmailModel email,
    required MailBoxModel from,
  }) async {
    ActionModel action =
        ActionModel(type: ActionType.unflag, email: email, fromMailBox: from);
    await EmailLogic.addAction(action);
    int index = emailsBoxesComplete[currentMailBoxIndex].emails.indexOf(email);
    if (index == -1) return;
    emailsBoxesComplete[currentMailBoxIndex].emails[index].isFlagged = false;
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
        await mailClient!.selectMailbox((await EmailLogic.mailBoxToMailLib(
            mailClient: mailClient!, mailBoxModel: from))!);
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

  void send({
    required EmailModel email,
    int? replyOriginalMessageId,
    bool? replyAll,
    bool reply = false,
    bool forward = false,
    required MailBoxModel from,
  }) async {
    ActionModel action = ActionModel(
        type: (reply)
            ? ActionType.reply
            : ((forward) ? ActionType.forward : ActionType.send),
        email: email,
        fromMailBox: from,
        originalMessageId: replyOriginalMessageId,
        replyAll: replyAll);
    await EmailLogic.addAction(action);
    emailsBoxesComplete
        .firstWhere((element) => element.name == "Boîte d'envoi")
        .emails
        .add(action.email!);
    CacheService.set<MailBoxWrapper>(
        MailBoxWrapper(mailBoxes: emailsBoxesComplete));
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
          from: from,
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
    if (actions.isEmpty || !state.connected) return;
    for (ActionModel action in actions) {
      if (kDebugMode) {
        print("action: $action");
      }
      currentMailBoxIndex = emailsBoxesComplete
          .indexWhere((element) => element.name == action.fromMailBox.name);
      switch (action.type) {
        case ActionType.archive:
          archive(email: action.email!, from: action.fromMailBox);
          break;
        case ActionType.move:
          move(
              email: action.email!,
              folder: action.destinationMailBox!,
              from: action.fromMailBox);
          break;
        case ActionType.markAsUnread:
          markAsUnread(email: action.email!, from: action.fromMailBox);
          break;
        case ActionType.send:
          send(email: action.email!, from: action.fromMailBox);
          break;
        case ActionType.markAsRead:
          markAsRead(email: action.email!, from: action.fromMailBox);
          break;
        case ActionType.reply:
          send(
              email: action.email!,
              replyOriginalMessageId: action.originalMessageId!,
              replyAll: action.replyAll,
              reply: true,
              from: action.fromMailBox);
          break;
        case ActionType.replyAll:
          send(
              email: action.email!,
              replyOriginalMessageId: action.originalMessageId!,
              replyAll: action.replyAll,
              reply: true,
              from: action.fromMailBox);
          break;
        case ActionType.forward:
          send(
              email: action.email!,
              replyOriginalMessageId: action.originalMessageId!,
              forward: true,
              from: action.fromMailBox);
          break;
        case ActionType.delete:
          delete(
              email: action.email!,
              blockTrackers: blockTrackers,
              from: action.fromMailBox);
          break;
        case ActionType.flag:
          flag(email: action.email!, from: action.fromMailBox);
          break;
        case ActionType.unflag:
          unflag(email: action.email!, from: action.fromMailBox);
          break;
      }
    }
  }
}
