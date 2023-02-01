import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:sizer/sizer.dart';

class EmailWidget extends StatelessWidget {
  final EmailModel email;

  Color unreadText1Color(BuildContext c) {
    return Theme.of(c).textTheme.bodyLarge!.color!;
  }

  Color unreadText2Color(BuildContext c) {
    return Theme.of(c).textTheme.bodyMedium!.color!;
  }

  Color unreadBgColor(BuildContext c) {
    return Theme.of(c).colorScheme.background;
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

  const EmailWidget({Key? key, required this.email}) : super(key: key);

  String _firstLetter(String sender) {
    return sender.isNotEmpty ? sender[0] : '-';
  }

  String _toHumanDate(DateTime date) {
    final int diffMin = DateTime.now().difference(date).inMinutes;
    final int diffH = DateTime.now().difference(date).inHours;
    final int diffDays = DateTime.now().difference(date).inDays;
    if (diffMin < 1) {
      return "now";
    } else if (diffH < 1) {
      return "${diffMin.toString()}min";
    } else if (diffH > 1 && diffH < 24) {
      return "${diffH.toString()}h";
    } else if (diffH > 24 && diffDays < 8) {
      return "${diffDays.toString()}j";
    } else {
      return date.toString().split(' ')[0].replaceAll('-', '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.background,
            title: const Text("Supprimer"),
            content: const Text("Êtes-vous sûr de vouloir supprimer ce mail ?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Annuler",
                  style: TextStyle(color: Colors.green),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<EmailCubit>().delete(email: email);
                  Navigator.pop(context);
                },
                child: const Text(
                  "Supprimer",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
      child: OpenContainer(
        transitionDuration: Res.animationDuration,
        closedColor:
            email.isRead ? readBgColor(context) : unreadBgColor(context),
        openColor: Theme.of(context).colorScheme.background,
        onClosed: (value) {
          context.read<EmailCubit>().markAsRead(email: email);
        },
        openBuilder: (context, closeContainer) => EmailDetailsPage(
          mail: email,
        ),
        closedBuilder: (context, openContainer) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  height: 12.w,
                  width: 12.w,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: email.isRead
                        ? readBgColor(context)
                        : unreadAccent(context),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      _firstLetter(email.sender),
                      style: TextStyle(
                        fontSize: 22,
                        color: email.isRead
                            ? readText1Color(context)
                            : unreadText1Color(context),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: 80.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              email.sender,
                              style: TextStyle(
                                color: email.isRead
                                    ? readText1Color(context)
                                    : unreadText1Color(context),
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              _toHumanDate(email.date),
                              style: TextStyle(
                                  color: email.isRead
                                      ? readText1Color(context)
                                      : unreadText1Color(context),
                                  fontSize: 10.sp),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    SizedBox(
                      width: 80.w,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              (email.subject != "")
                                  ? email.subject
                                  : email.excerpt,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 4,
                              style: TextStyle(
                                color: email.isRead
                                    ? readText2Color(context)
                                    : unreadText2Color(context),
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          IconButton(
                            key: Key("email flag ${email.id}"),
                            onPressed: () {
                              context
                                  .read<EmailCubit>()
                                  .toggleFlag(email: email);
                            },
                            icon: Icon(
                              email.isFlagged
                                  ? Icons.flag_rounded
                                  : Icons.outlined_flag_rounded,
                              size: 20.sp,
                              color: email.isFlagged
                                  ? Theme.of(context).primaryColor
                                  : email.isRead
                                      ? readText2Color(context)
                                      : unreadText2Color(context),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              height: 1,
              indent: 70,
              endIndent: 0,
              thickness: 1,
              // color: Color(0xff3b4252),
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.1),
            )
          ],
        ),
      ),
    );
  }
}
