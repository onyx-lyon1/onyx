import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/screens/login/login_export.dart';
import 'package:oloid2/screens/mails/mails_export.dart';
import 'package:sizer/sizer.dart';

import '../../../core/widgets/states_displaying/state_displaying_widget_export.dart';

class EmailSendPage extends StatelessWidget {
  final int? replyOriginalMessage;
  final bool? replyAll;

  const EmailSendPage({Key? key, this.replyAll, this.replyOriginalMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController subjectEditor = TextEditingController();
    final TextEditingController destinationEditor = TextEditingController();
    final TextEditingController bodyEditor = TextEditingController();

    return BlocBuilder<EmailCubit, EmailState>(
      builder: (context, state) {
        if (state.status == EmailStatus.error) {
          Future.delayed(const Duration(seconds: 1), () {
            EmailModel email = EmailModel(
              subject: subjectEditor.text,
              sender: "moi",
              excerpt: "",
              isRead: false,
              date: DateTime.now(),
              body: bodyEditor.text,
              id: 0,
              receiver: destinationEditor.text,
              attachments: [],
            );
            context.read<EmailCubit>().send(email: email,
                replyAll: replyAll,
                replyOriginalMessageId: replyOriginalMessage);
          });
          return const StateDisplayingPage(
              message: "Something went wrong with emails");
        } else if (state.status == EmailStatus.sended) {
          context.read<EmailCubit>().load(cache: false);
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
            Navigator.pop(context);
          });
        } else if (state.status == EmailStatus.sending) {
          return const StateDisplayingPage(message: "Sending message");
        }
        return Material(
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            floatingActionButton: Material(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(100),
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                splashColor: Theme.of(context).cardTheme.color,
                onTap: () {
                  if ((destinationEditor.value.text.isNotEmpty &&
                          subjectEditor.value.text.isNotEmpty &&
                          bodyEditor.value.text.isNotEmpty &&
                          destinationEditor.value.text.contains("@") &&
                          destinationEditor.value.text.contains(".")) ||
                      (replyOriginalMessage != null &&
                          bodyEditor.value.text.isNotEmpty)) {
                    EmailModel email = EmailModel(
                      subject: subjectEditor.text,
                      sender: "moi",
                      excerpt: "",
                      isRead: false,
                      date: DateTime.now(),
                      body: bodyEditor.text,
                      id: 0,
                      receiver: destinationEditor.text,
                      attachments: [],
                    );
                    context.read<EmailCubit>().send(email: email,
                        replyAll: replyAll,
                        replyOriginalMessageId: replyOriginalMessage);
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              backgroundColor:
                                  Theme.of(context).backgroundColor,
                              title: const Text(
                                  "Veuillez remplir correctement tous les champs"),
                            ));
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(1.5.h),
                  child: Icon(Icons.send, size: 25.sp),
                ),
              ),
            ),
            body: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Theme.of(context).cardTheme.color,
                    height: 6.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back,
                              color: Theme.of(context)
                                  .bottomNavigationBarTheme
                                  .unselectedItemColor,
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          (replyOriginalMessage == null)
                              ? SizedBox(
                                  width: 80.w,
                                  height: 5.h,
                                  child: Center(
                                    child: TextField(
                                      controller: subjectEditor,
                                      maxLines: 1,
                                      textAlignVertical: TextAlignVertical.top,
                                      cursorColor: Theme.of(context)
                                          .textTheme
                                          .button!
                                          .color!,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .button!
                                            .color!,
                                      ),
                                      decoration: InputDecoration(
                                          hintText: "Objets",
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color!
                                                      .withOpacity(0.5)),
                                          isDense: true,
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .color!,
                                                width: 1),
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .backgroundColor,
                                              width: 1,
                                            ),
                                          )),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  width: 70.w,
                                  child: const Center(
                                    child: Text(
                                      "reponse",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  (replyOriginalMessage == null)
                      ? Container(
                          color: Theme.of(context).cardTheme.color,
                          width: 100.w,
                          child: Padding(
                            padding: EdgeInsets.all(1.h),
                            child: RawAutocomplete<String>(
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) async {
                                if (!context
                                    .read<EmailCubit>()
                                    .mailClient
                                    .isAuthenticated) {
                                  context.read<EmailCubit>().connect(
                                      username: context
                                          .read<AuthentificationCubit>()
                                          .state.username,
                                      password: context
                                          .read<AuthentificationCubit>()
                                          .state.password);
                                  return [];
                                } else {
                                  return (await context
                                          .read<EmailCubit>()
                                          .mailClient
                                          .resolveContact(
                                              textEditingValue.text))
                                      .map((e) => e.email.toString())
                                      .toList();
                                }
                              },
                              displayStringForOption: (String option) => option,
                              textEditingController: destinationEditor,
                              focusNode: FocusNode(),
                              optionsViewBuilder: (BuildContext context,
                                  AutocompleteOnSelected<String> onSelected,
                                  Iterable<String> options) {
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: Material(
                                    elevation: 4.0,
                                    color: Theme.of(context).backgroundColor,
                                    child: SizedBox(
                                      height: 20.h,
                                      width: 97.w,
                                      child: ListView(
                                        padding: EdgeInsets.all(1.h),
                                        children: options
                                            .map((String option) =>
                                                GestureDetector(
                                                  onTap: () {
                                                    onSelected(option);
                                                  },
                                                  child: ListTile(
                                                    title: Text(option),
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              fieldViewBuilder: (BuildContext context,
                                  TextEditingController
                                      fieldTextEditingController,
                                  FocusNode fieldFocusNode,
                                  VoidCallback onFieldSubmitted) {
                                return TextField(
                                  controller: fieldTextEditingController,
                                  focusNode: fieldFocusNode,
                                  textAlignVertical: TextAlignVertical.top,
                                  cursorColor: Theme.of(context)
                                      .textTheme
                                      .button!
                                      .color!,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .button!
                                        .color!,
                                  ),
                                  decoration: InputDecoration(
                                      hintText:
                                          "Destinataire : PXXXXXXX, prenom.nom@status.univ-lyon1.fr",
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color!
                                                  .withOpacity(0.5)),
                                      isDense: true,
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color!,
                                            width: 1),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Theme.of(context).backgroundColor,
                                          width: 1,
                                        ),
                                      )),
                                );
                              },
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    color: Theme.of(context).cardTheme.color,
                    height: (replyOriginalMessage == null) ? 80.h : 90.h,
                    width: 100.w,
                    child: Padding(
                      padding: EdgeInsets.all(1.h),
                      child: TextField(
                        controller: bodyEditor,
                        textAlignVertical: TextAlignVertical.top,
                        cursorColor: Theme.of(context).textTheme.button!.color!,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.button!.color!,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "Message",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color!
                                      .withOpacity(0.5)),
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
