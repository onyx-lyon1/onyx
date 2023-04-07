import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:sizer/sizer.dart';

import '../../settings/settings_export.dart';

class EmailHeaderWidget extends StatelessWidget {
  const EmailHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailCubit, EmailState>(
      builder: (context, state) {
        if (state.selectedEmails.isNotEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    for (var email in state.selectedEmails) {
                      context.read<EmailCubit>().delete(
                            email: email,
                            blockTrackers: context
                                .read<SettingsCubit>()
                                .state
                                .settings
                                .blockTrackers,
                            from: state.currentMailBox!,
                          );
                    }
                    context.read<EmailCubit>().unselectAllEmails();
                  },
                  icon: const Icon(Icons.delete)),
              IconButton(
                  onPressed: () {
                    for (var email in state.selectedEmails) {
                      context.read<EmailCubit>().archive(
                            email: email,
                            from: state.currentMailBox!,
                          );
                    }
                    context.read<EmailCubit>().unselectAllEmails();
                  },
                  icon: const Icon(Icons.archive)),
              IconButton(
                  onPressed: () {
                    int readedMail = 0;
                    int unreadedMail = 0;
                    for (var email in state.selectedEmails) {
                      if (email.isRead) {
                        readedMail++;
                      } else {
                        unreadedMail++;
                      }
                    }
                    for (var email in state.selectedEmails) {
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
                    context.read<EmailCubit>().unselectAllEmails();
                  },
                  icon: const Icon(Icons.mark_email_read_rounded)),
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
                      for (var email in state.selectedEmails) {
                        context.read<EmailCubit>().move(
                              email: email,
                              folder: folder,
                              from: state.currentMailBox!,
                            );
                      }
                      context.read<EmailCubit>().unselectAllEmails();
                    });
                  },
                  icon: const Icon(Icons.folder_copy_rounded)),
              IconButton(
                  onPressed: () {
                    for (var email in state.selectedEmails) {
                      context.read<EmailCubit>().toggleFlag(
                            email: email,
                            from: state.currentMailBox!,
                          );
                    }
                    context.read<EmailCubit>().unselectAllEmails();
                  },
                  icon: const Icon(Icons.flag_rounded)),
            ],
          );
        } else {
          return SizedBox(
            height: Res.bottomNavBarHeight,
            width: 100.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  width: 90.w,
                  child: Padding(
                    padding: EdgeInsets.only(left: 3.w),
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
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Theme.of(context)
                              .bottomNavigationBarTheme
                              .unselectedItemColor,
                        ),
                        contentPadding: EdgeInsets.only(bottom: 1.h),
                        border: InputBorder.none,
                      ),
                      textAlignVertical: TextAlignVertical.center,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
