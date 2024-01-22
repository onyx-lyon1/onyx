import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MailHeaderWidget extends StatelessWidget {
  const MailHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailCubit, EmailState>(
      builder: (context, state) {
        if (state.selectedMails.isNotEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    for (var email in state.selectedMails) {
                      context.read<EmailCubit>().delete(
                            email: email,
                            from: state.currentMailBox!,
                          );
                    }
                    context.read<EmailCubit>().unselectAllMails();
                  },
                  icon: const Icon(Icons.delete),
                  tooltip: "Supprimer"),
              IconButton(
                onPressed: () {
                  for (var email in state.selectedMails) {
                    context.read<EmailCubit>().archive(
                          email: email,
                          from: state.currentMailBox!,
                        );
                  }
                  context.read<EmailCubit>().unselectAllMails();
                },
                icon: const Icon(Icons.archive),
                tooltip: "Archiver",
              ),
              IconButton(
                onPressed: () {
                  int readedMail = 0;
                  int unreadedMail = 0;
                  for (var email in state.selectedMails) {
                    if (email.isRead) {
                      readedMail++;
                    } else {
                      unreadedMail++;
                    }
                  }
                  for (var email in state.selectedMails) {
                    if (readedMail < unreadedMail) {
                      context.read<EmailCubit>().markAsRead(
                            email: email,
                            from: state.currentMailBox!,
                          );
                    } else {
                      context.read<EmailCubit>().markAsUnread(
                            email: email,
                            from: state.currentMailBox!,
                          );
                    }
                  }
                  context.read<EmailCubit>().unselectAllMails();
                },
                icon: const Icon(Icons.mark_email_read_rounded),
                tooltip: "marquer comme lus / non lus",
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Déplacer vers"),
                          content: SizedBox(
                            height: 30.h,
                            width: 100.w,
                            child: ListView.builder(
                              itemCount: state.mailBoxes.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    Navigator.pop(
                                        context, state.mailBoxes[index]);
                                  },
                                  title: Text(state.mailBoxes[index].name),
                                );
                              },
                            ),
                          ),
                        );
                      }).then((folder) {
                    for (var email in state.selectedMails) {
                      context.read<EmailCubit>().move(
                            email: email,
                            folder: folder,
                            from: state.currentMailBox!,
                          );
                    }
                    context.read<EmailCubit>().unselectAllMails();
                  });
                },
                icon: const Icon(Icons.drive_file_move_rounded),
                tooltip: "Déplacer vers",
              ),
              IconButton(
                onPressed: () {
                  for (var email in state.selectedMails) {
                    context.read<EmailCubit>().toggleFlag(
                          email: email,
                          from: state.currentMailBox!,
                        );
                  }
                  context.read<EmailCubit>().unselectAllMails();
                },
                icon: const Icon(Icons.flag_rounded),
                tooltip: "Marquer comme important",
              ),
            ],
          );
        } else {
          return Container(
            margin: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(100),
            ),
            child: TextField(
              onChanged: (String query) {
                context.read<EmailCubit>().filter(filter: query);
              },
              onSubmitted: (String query) {
                FocusScope.of(context).unfocus();
              },
              style: TextStyle(
                color: Theme.of(context).textTheme.labelLarge!.color,
              ),
              cursorColor: Theme.of(context).textTheme.bodyLarge!.color,
              decoration: InputDecoration(
                hintText:
                    "Recherche dans les ${context.read<EmailCubit>().emailNumber} derniers mails",
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.5)),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor,
                ),
                contentPadding: EdgeInsets.only(bottom: 1.h),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
              ),
              textAlignVertical: TextAlignVertical.center,
            ),
          );
        }
      },
    );
  }
}
