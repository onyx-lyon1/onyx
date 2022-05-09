import 'dart:math';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Email extends StatelessWidget {
  late String subject = '';
  late String sender = '';
  late String excerpt = '';
  late bool isRead = false;
  late DateTime date = DateTime.now();

  final Color circleAvatarColor = const Color(0xff434c5e);
  final Color unreadCircleAvatarColor = const Color(0xffd08770);

  final Color unreadSenderColor = const Color(0xffd8dee9);
  final Color unreadSubjectColor = const Color(0xffd8dee9);

  final Color unreadExcerptColor = const Color(0xffc2c8d2);
  final Color readColor = const Color(0xffadb2ba);

  Email(
      {Key? key,
      required this.subject,
      required this.sender,
      required this.excerpt,
      required this.isRead,
      required this.date})
      : super(key: key);

  Email.empty({Key? key}) : super(key: key) {
    subject = "Le sujet du mail";
    sender = "sender@mail.com";
    excerpt = "Lorem ipsum dolor sit amet, consectetur adipiscing";
    isRead = Random().nextDouble() > 0.5;
    date = DateTime.now().add(Duration(days: -(Random().nextInt(10) + 5)));
  }

  String _firstLetter() {
    return sender.isNotEmpty ? sender[0] : '-';
  }

  String _toHumanDate() {
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
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          child: Row(
            children: [
              Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      _firstLetter(),
                      style: TextStyle(
                          fontSize: 22,
                          color: isRead ? readColor : circleAvatarColor),
                    ),
                  ),
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: isRead
                          ? circleAvatarColor
                          : unreadCircleAvatarColor)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          sender,
                          style: TextStyle(
                              color: isRead ? readColor : unreadSenderColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            _toHumanDate(),
                            style: TextStyle(
                                color: isRead ? readColor : unreadSenderColor,
                                fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    subject,
                    style: TextStyle(
                        color: isRead ? readColor : unreadSubjectColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 70,
                    child: Text(
                      excerpt,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 2,
                      style: TextStyle(
                          color: isRead ? readColor : unreadExcerptColor,
                          fontSize: 12),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          height: 1,
          indent: 90,
          endIndent: 10,
          thickness: 1,
          color: Color(0xff3b4252),
        )
      ],
    );
  }
}
