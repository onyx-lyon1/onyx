import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MailWidget extends StatelessWidget {
  final Mail email;

  Color unreadText1Color(BuildContext c) {
    return Theme.of(c).textTheme.bodyLarge!.color!;
  }

  Color unreadText2Color(BuildContext c) {
    return Theme.of(c).textTheme.bodyMedium!.color!;
  }

  Color unreadBgColor(BuildContext c) {
    return Theme.of(c).colorScheme.surface;
  }

  Color readText1Color(BuildContext c) {
    return Theme.of(c).textTheme.bodyLarge!.color!.withOpacity(0.3);
  }

  Color readText2Color(BuildContext c) {
    return Theme.of(c).textTheme.bodyLarge!.color!.withOpacity(0.3);
  }

  Color readBgColor(BuildContext c) {
    return Theme.of(c).cardTheme.color!;
  }

  Color unreadAccent(BuildContext c) {
    return Theme.of(c).primaryColor.withOpacity(0.7);
  }

  const MailWidget({super.key, required this.email});

  String _firstLetter(String sender) {
    return sender.isNotEmpty ? sender[0] : '-';
  }

  String _toHumanDate(DateTime date, AppLocalizations appLocalizations) {
    final int diffMin = DateTime.now().difference(date).inMinutes;
    final int diffH = DateTime.now().difference(date).inHours;
    final int diffDays = DateTime.now().difference(date).inDays;
    if (diffMin < 1) {
      return appLocalizations.now;
    } else if (diffH < 1) {
      return appLocalizations.minuteCompact(diffMin);
    } else if (diffH >= 1 && diffH < 24) {
      return appLocalizations.hourCompact(diffH);
    } else if (diffH > 24) {
      return appLocalizations.dayCompact(diffDays);
    } else {
      return DateFormat.yMd(appLocalizations.localeName).format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      useRootNavigator: true,
      transitionDuration: Res.animationDuration,
      closedColor: email.isRead ? readBgColor(context) : unreadBgColor(context),
      openColor: Theme.of(context).colorScheme.surface,
      onClosed: (value) {
        context.read<EmailCubit>().markAsRead(
              email: email,
              from: context.read<EmailCubit>().state.currentMailBox!,
            );
      },
      openBuilder: (context, closeContainer) => MailDetailsPage(
        mail: email,
      ),
      closedBuilder: (context, openContainer) => InkWell(
        onTap: () {
          if (context.read<EmailCubit>().state.selectedMails.isNotEmpty) {
            context.read<EmailCubit>().toggleMailSelection(
                  emails: email,
                );
          } else {
            openContainer();
          }
        },
        onLongPress: () {
          context.read<EmailCubit>().selectMail(
                email: email,
              );
        },
        child: ListTile(
            leading: (context.read<EmailCubit>().state.selectedMails.isNotEmpty)
                ? Container(
                    height: 10.w,
                    width: 10.w,
                    margin: EdgeInsets.all(1.w),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          context.read<EmailCubit>().toggleMailSelection(
                                emails: email,
                              );
                        },
                        child: Icon(
                          context
                                  .read<EmailCubit>()
                                  .state
                                  .selectedMails
                                  .contains(email)
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: Theme.of(context).primaryColor,
                        )),
                  )
                : Container(
                    height: 10.w,
                    width: 10.w,
                    margin: EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(100),
                      color: email.isRead
                          ? readBgColor(context)
                          : unreadAccent(context),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          context.read<EmailCubit>().selectMail(
                                email: email,
                              );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 1.5.w),
                          child: Text(
                            _firstLetter(email.sender).toUpperCase(),
                            style: TextStyle(
                              fontSize: 22,
                              color: email.isRead
                                  ? readText1Color(context)
                                  : unreadText1Color(context),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    email.sender,
                    style: TextStyle(
                      color: email.isRead
                          ? readText1Color(context)
                          : unreadText1Color(context),
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 3.w, left: 2.w),
                  child: Text(
                    _toHumanDate(email.date, AppLocalizations.of(context)),
                    maxLines: 1,
                    style: TextStyle(
                      color: email.isRead
                          ? readText1Color(context)
                          : unreadText1Color(context),
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 55.w,
                  child: Text(
                    (email.subject != "") ? email.subject : email.excerpt,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 4,
                    style: TextStyle(
                      color: email.isRead
                          ? readText2Color(context)
                          : unreadText2Color(context),
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                IconButton(
                  key: Key("Mail flag ${email.id}"),
                  onPressed: () {
                    context.read<EmailCubit>().toggleFlag(
                          email: email,
                          from:
                              context.read<EmailCubit>().state.currentMailBox!,
                        );
                  },
                  icon: Icon(
                    email.isFlagged
                        ? Icons.flag_rounded
                        : Icons.outlined_flag_rounded,
                    semanticLabel: email.isFlagged
                        ? AppLocalizations.of(context)
                            .flagedEmail(email.subject)
                        : AppLocalizations.of(context)
                            .unflagedEmail(email.subject),
                    size: 20.sp,
                    color: email.isFlagged
                        ? Theme.of(context).primaryColor
                        : email.isRead
                            ? readText2Color(context)
                            : unreadText2Color(context),
                  ),
                ),
              ],
            )),
      ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const SizedBox(
//               height: 5,
//             ),
//             Row(
//               children: [
// ,
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     SizedBox(
//                       width: 80.w,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Expanded(
//                             child:
//                           ),

//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 0.5.h,
//                     ),
//                     SizedBox(
//                       width: 80.w,
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: ,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             Divider(
//               height: 1,
//               indent: 70,
//               endIndent: 0,
//               thickness: 1,
//               // color: Color(0xff3b4252),
//               color: Theme.of(context)
//                   .textTheme
//                   .bodyLarge!
//                   .color!
//                   .withOpacity(0.1),
//             )
//           ],
//         ),
    );
  }
}
