import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:oloid2/core/cache_service.dart';
import 'package:oloid2/screens/mails/mails_export.dart';

part 'email_state.dart';

class EmailCubit extends Cubit<EmailState> {
  late Lyon1Mail mailClient;
  List<EmailModel> emailsComplete = [];
  late String username;
  late String password;
  String lastFilter = "";
  int emailNumber = 20;

  EmailCubit() : super(EmailState());

  void connect({required String username, required String password}) async {
    //TODO optimize cache loading becose it cause freeze
    if (await CacheService.exist<EmailModelWrapper>()) {
      emailsComplete =
          (await CacheService.get<EmailModelWrapper>())!.emailModels;
      emit(state.copyWith(
          emails: emailsComplete, status: EmailStatus.cacheLoaded));
    }
    emit(state.copyWith(status: EmailStatus.connecting));
    try {
      username = username;
      password = password;
      mailClient =
          await EmailLogic.connect(username: username, password: password);
      emit(state.copyWith(status: EmailStatus.connected));
    } catch (e) {
      emit(state.copyWith(status: EmailStatus.error));
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
    emit(state.copyWith(emails: emails, status: EmailStatus.sorted));
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
      emit(state.copyWith(
          status: EmailStatus.updated, emails: emails));
    }


  }

  void load({bool cache=true}) async {
    emit(state.copyWith(status: EmailStatus.loading));
    if (cache) {
      if (await CacheService.exist<EmailModelWrapper>()) {
        if (emailsComplete !=
            (await CacheService.get<EmailModelWrapper>())!.emailModels) {
          emailsComplete =
              (await CacheService.get<EmailModelWrapper>())!.emailModels;
          emit(state.copyWith(
              emails: emailsComplete, status: EmailStatus.cacheLoaded));
        }
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
    filter(filter: lastFilter);
    // emit(state.copyWith(status: Email2Status.loaded, emails: emailsComplete));
  }

  void send({required EmailModel email, int? replyOriginalMessageId, bool? replyAll}) async {
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
