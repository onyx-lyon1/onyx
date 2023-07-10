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
  List<MailBox> emailsBoxesComplete = [];
  int currentMailBoxIndex = 0;
  late String username;
  late String password;
  String lastFilter = "";
  int emailNumber = 20;

  EmailCubit() : super(EmailState());

  void connect({required String? username, required String? password}) async {
    emit(state.copyWith(status: MailStatus.connecting, connected: false));

    if (!kIsWeb) {
      emailsBoxesComplete = await compute(
          MailLogic.cacheLoad, (await getApplicationDocumentsDirectory()).path);
    }

    if (emailsBoxesComplete.isNotEmpty) {
      currentMailBoxIndex = emailsBoxesComplete.indexWhere(
        (element) => element.specialMailBox == SpecialMailBox.inbox,
      );
      emit(
        state.copyWith(
            mailBoxes: emailsBoxesComplete,
            status: MailStatus.cacheLoaded,
            currentMailBox: emailsBoxesComplete[currentMailBoxIndex]),
      );
    }

    if (username != null && password != null) {
      try {
        username = username;
        password = password;
        mailClient =
            await MailLogic.connect(username: username, password: password);
        emit(state.copyWith(status: MailStatus.connected, connected: true));
      } catch (e) {
        if (kDebugMode) print("error: $e");
        emit(state.copyWith(status: MailStatus.error));
      }
    }
  }

  void load(
      {bool cache = true,
      required bool blockTrackers,
      MailBox? mailbox}) async {
    emit(state.copyWith(status: MailStatus.loading));
    if (Res.mock) {
      emailsBoxesComplete = MailLogic.mailboxesMock;
      currentMailBoxIndex = 0;
      Future.delayed(
          const Duration(milliseconds: 500),
          () => emit(state.copyWith(
                mailBoxes: emailsBoxesComplete,
                status: MailStatus.loaded,
                currentMailBox: emailsBoxesComplete[currentMailBoxIndex],
              )));

      return;
    }
    if (cache && !Res.mock && !kIsWeb) {
      List<MailBox> emailCache = await compute(
          MailLogic.cacheLoad, (await getApplicationDocumentsDirectory()).path);
      if (emailCache.isNotEmpty &&
          !listEquals(emailCache, emailsBoxesComplete)) {
        emailsBoxesComplete = emailCache;
        late MailBox currentMailBox;
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
            status: MailStatus.cacheLoaded,
            currentMailBox: currentMailBox));
        filter(filter: lastFilter);
      }
    }
    try {
      List<MailBox> emailBoxes = await mailClient!.getMailboxes();

      for (var i in emailBoxes) {
        if (emailsBoxesComplete
                .indexWhere((element) => element.name == i.name) ==
            -1) {
          emailsBoxesComplete.add(i);
        }
      }
      emit(state.copyWith(
          mailBoxes: emailsBoxesComplete, status: MailStatus.mailboxesLoaded));
      MailBox loadedMail = (await MailLogic.load(
        emailNumber: emailNumber,
        mailClient: mailClient!,
        blockTrackers: blockTrackers,
        mailBox: mailbox,
      ));
      int index = emailsBoxesComplete.indexWhere((element) =>
          element.name == loadedMail.name ||
          element.specialMailBox == loadedMail.specialMailBox);
      if (index != -1) {
        emailsBoxesComplete[index] =
            emailsBoxesComplete[index].copyWith.emails(loadedMail.emails);
      }
    } catch (e) {
      if (kDebugMode) {
        print("error: $e");
      }
      emit(state.copyWith(status: MailStatus.error));
      return;
    }

    CacheService.set<MailBoxList>(
        MailBoxList(mailBoxes: emailsBoxesComplete)); //await à definir
    currentMailBoxIndex = emailsBoxesComplete.indexWhere(
        (element) => element.specialMailBox == SpecialMailBox.inbox);
    emit(state.copyWith(
        status: MailStatus.loaded,
        mailBoxes: emailsBoxesComplete,
        currentMailBox: (mailbox == null && currentMailBoxIndex != -1)
            ? emailsBoxesComplete[currentMailBoxIndex]
            : mailbox));
    filter(filter: lastFilter);
  }

  void filter({required String filter}) async {
    lastFilter = filter;
    List<Mail> email = [];
    if (filter != "") {
      for (var i in emailsBoxesComplete
          .firstWhere((element) => state.currentMailBox!.name == element.name)
          .emails) {
        if (i.subject.toLowerCase().contains(filter.toLowerCase()) ||
            i.excerpt.toLowerCase().contains(filter.toLowerCase()) ||
            i.date.toString().toLowerCase().contains(filter.toLowerCase()) ||
            i.sender.toLowerCase().contains(filter.toLowerCase()) ||
            i.body.toLowerCase().contains(filter.toLowerCase())) {
          email.add(i);
        }
      }
    } else {
      email = emailsBoxesComplete
          .firstWhere((element) => state.currentMailBox!.name == element.name)
          .emails;
    }
    emit(state.copyWith(
      status: (state.status == MailStatus.cacheLoaded)
          ? MailStatus.cacheSorted
          : MailStatus.sorted,
      currentMailBox: state.currentMailBox!.copyWith.emails(email),
    ));
  }

  void delete({required Mail email, required MailBox from}) async {
    if (!Res.mock) {
      mailClient!.addAction(
          Action(type: ActionType.delete, mail: email, fromMailBox: from));
    }
    emailsBoxesComplete[currentMailBoxIndex].emails.remove(email);
    emit(state.copyWith(
        status: MailStatus.updated,
        mailBoxes: emailsBoxesComplete,
        currentMailBox:
            emailsBoxesComplete[currentMailBoxIndex])); //do it locally
    CacheService.set<MailBoxList>(MailBoxList(mailBoxes: emailsBoxesComplete));
  }

  void markAsRead({required Mail email, required MailBox from}) async {
    if (!email.isRead) {
      if (!Res.mock) {
        mailClient!.addAction(Action(
            type: ActionType.markAsRead, mail: email, fromMailBox: from));
      }
      int index =
          emailsBoxesComplete[currentMailBoxIndex].emails.indexOf(email);
      if (index == -1) return;
      emailsBoxesComplete[currentMailBoxIndex].emails[index] =
          emailsBoxesComplete[currentMailBoxIndex].emails[index].copyWith(
                isRead: true,
              );
      CacheService.set<MailBoxList>(
          MailBoxList(mailBoxes: emailsBoxesComplete));
      emit(state.copyWith(
          status: MailStatus.updated,
          mailBoxes: emailsBoxesComplete,
          currentMailBox: emailsBoxesComplete[currentMailBoxIndex]));
    }
  }

  Future<void> archive({required Mail email, required MailBox from}) async {
    if (!Res.mock) {
      mailClient!.addAction(
          Action(type: ActionType.archive, mail: email, fromMailBox: from));
    }

    emailsBoxesComplete[currentMailBoxIndex].emails.remove(email);
    int index = emailsBoxesComplete.indexWhere(
        (element) => element.specialMailBox == SpecialMailBox.archive);
    if (index != -1) {
      emailsBoxesComplete[index].emails.add(email);
    } else {
      emailsBoxesComplete.add(MailBox(
          name: "Archive",
          specialMailBox: SpecialMailBox.archive,
          emails: [email]));
    }
    CacheService.set<MailBoxList>(MailBoxList(mailBoxes: emailsBoxesComplete));
    emit(state.copyWith(
        status: MailStatus.updated,
        mailBoxes: emailsBoxesComplete,
        currentMailBox:
            emailsBoxesComplete[currentMailBoxIndex])); //do it locally
  }

  Future<void> move(
      {required Mail email,
      required MailBox folder,
      required MailBox from}) async {
    if (!Res.mock) {
      mailClient!.addAction(Action(
          type: ActionType.move,
          mail: email,
          fromMailBox: from,
          destinationMailBox: folder));
    }

    emailsBoxesComplete[currentMailBoxIndex].emails.remove(email);
    emailsBoxesComplete[emailsBoxesComplete.indexOf(folder)].emails.add(email);
    CacheService.set<MailBoxList>(MailBoxList(mailBoxes: emailsBoxesComplete));
    emit(state.copyWith(
        status: MailStatus.updated,
        mailBoxes: emailsBoxesComplete,
        currentMailBox:
            emailsBoxesComplete[currentMailBoxIndex])); //do it locally
  }

  void markAsUnread({required Mail email, required MailBox from}) async {
    if (email.isRead) {
      if (!Res.mock) {
        mailClient!.addAction(Action(
            type: ActionType.markAsUnread, mail: email, fromMailBox: from));
      }
      int index =
          emailsBoxesComplete[currentMailBoxIndex].emails.indexOf(email);
      if (index == -1) return;
      emailsBoxesComplete[currentMailBoxIndex].emails[index] =
          emailsBoxesComplete[currentMailBoxIndex].emails[index].copyWith(
                isRead: false,
              );
      CacheService.set<MailBoxList>(
          MailBoxList(mailBoxes: emailsBoxesComplete));
      emit(state.copyWith(
          status: MailStatus.updated,
          mailBoxes: emailsBoxesComplete,
          currentMailBox: emailsBoxesComplete[currentMailBoxIndex]));
    }
  }

  void toggleFlag({required Mail email, required MailBox from}) async {
    if (email.isFlagged) {
      unflag(email: email, from: from);
    } else {
      flag(email: email, from: from);
    }
  }

  void flag({required Mail email, required MailBox from}) async {
    if (!Res.mock) {
      mailClient!.addAction(
          Action(type: ActionType.flag, mail: email, fromMailBox: from));
    }
    int index = emailsBoxesComplete[currentMailBoxIndex].emails.indexOf(email);
    if (index == -1) return;
    emailsBoxesComplete[currentMailBoxIndex].emails[index] =
        emailsBoxesComplete[currentMailBoxIndex].emails[index].copyWith(
              isFlagged: true,
            );
    CacheService.set<MailBoxList>(MailBoxList(mailBoxes: emailsBoxesComplete));
    emit(state.copyWith(
        status: MailStatus.updated,
        mailBoxes: emailsBoxesComplete,
        currentMailBox: emailsBoxesComplete[currentMailBoxIndex]));
  }

  void unflag({
    required Mail email,
    required MailBox from,
  }) async {
    if (!Res.mock) {
      mailClient!.addAction(
          Action(type: ActionType.unflag, mail: email, fromMailBox: from));
    }
    int index = emailsBoxesComplete[currentMailBoxIndex].emails.indexOf(email);
    if (index == -1) return;
    emailsBoxesComplete[currentMailBoxIndex].emails[index] =
        emailsBoxesComplete[currentMailBoxIndex].emails[index].copyWith(
              isFlagged: false,
            );
    CacheService.set<MailBoxList>(MailBoxList(mailBoxes: emailsBoxesComplete));
    emit(state.copyWith(
        status: MailStatus.updated,
        mailBoxes: emailsBoxesComplete,
        currentMailBox: emailsBoxesComplete[currentMailBoxIndex]));
    if (!mailClient!.isAuthenticated && !Res.mock) {
      if (!await mailClient!.login()) {
        emit(state.copyWith(status: MailStatus.nonFatalError));
        return;
      }
    }
  }

  void send({
    required Mail email,
    int? replyOriginalMessageId,
    bool? replyAll,
    bool reply = false,
    bool forward = false,
    required MailBox from,
  }) async {
    Action action = Action(
        type: (reply)
            ? ActionType.reply
            : ((forward) ? ActionType.forward : ActionType.send),
        mail: email,
        originalMessageId: replyOriginalMessageId,
        replyAll: replyAll,
        fromMailBox: (reply || forward) ? from : null);
    if (!Res.mock) {
      mailClient!.addAction(action);
    }
  }

  void selectMail({required Mail email}) {
    emit(state.copyWith(
        selectedMails: List.from(state.selectedMails)..add(email)));
  }

  void unselectMail({required Mail emails}) {
    emit(state.copyWith(
        selectedMails: List.from(state.selectedMails)..remove(emails)));
  }

  void unselectAllMails() {
    emit(state.copyWith(selectedMails: []));
  }

  void toggleMailSelection({required Mail emails}) {
    if (state.selectedMails.contains(emails)) {
      unselectMail(emails: emails);
    } else {
      selectMail(email: emails);
    }
  }

  void increaseNumber({required bool blockTrackers}) {
    emailNumber += 20;
    emit(state.copyWith(status: MailStatus.loading));
    load(cache: false, blockTrackers: blockTrackers);
    return;
  }

  void resetCubit() {
    mailClient = null;
    emailsBoxesComplete = [];
    emailNumber = 20;
    lastFilter = "";
    emit(EmailState(status: MailStatus.initial));
  }

  void doQueuedAction({required bool blockTrackers}) async {
    final List<Action> actions = await mailClient!.getActions();
    if (actions.isEmpty || !state.connected) return;
    for (Action action in actions) {
      if (kDebugMode) {
        print("action: $action");
      }
      currentMailBoxIndex = emailsBoxesComplete
          .indexWhere((element) => element.name == action.fromMailBox!.name);
      switch (action.type) {
        case ActionType.archive:
          archive(email: action.mail, from: action.fromMailBox!);
          break;
        case ActionType.move:
          move(
              email: action.mail,
              folder: action.destinationMailBox!,
              from: action.fromMailBox!);
          break;
        case ActionType.markAsUnread:
          markAsUnread(email: action.mail, from: action.fromMailBox!);
          break;
        case ActionType.send:
          send(email: action.mail, from: action.fromMailBox!);
          break;
        case ActionType.markAsRead:
          markAsRead(email: action.mail, from: action.fromMailBox!);
          break;
        case ActionType.reply:
          send(
              email: action.mail,
              replyOriginalMessageId: action.originalMessageId!,
              replyAll: action.replyAll,
              reply: true,
              from: action.fromMailBox!);
          break;
        case ActionType.forward:
          send(
              email: action.mail,
              replyOriginalMessageId: action.originalMessageId!,
              forward: true,
              from: action.fromMailBox!);
          break;
        case ActionType.delete:
          delete(email: action.mail, from: action.fromMailBox!);
          break;
        case ActionType.flag:
          flag(email: action.mail, from: action.fromMailBox!);
          break;
        case ActionType.unflag:
          unflag(email: action.mail, from: action.fromMailBox!);
          break;
      }
    }
  }
}
