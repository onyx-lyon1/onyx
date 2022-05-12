import 'dart:math';

import 'package:flutter/material.dart';
import 'package:oloid2/model/email.dart';

import '../widget/emails/email.dart';
import '../widget/emails/email_header.dart';

class EmailsPage extends StatelessWidget {
  final ScrollController scrollController = ScrollController();
  final Function onRefresh;
  final List<EmailModel> emails;
  final Function createEmail;
  final Function(String query) searchEmail;

  EmailsPage({
    Key? key,
    required this.onRefresh,
    required this.emails,
    required this.createEmail,
    required this.searchEmail,
  }) : super(key: key);

  void jumpToTop() {
    scrollController.animateTo(
      0,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).backgroundColor,
        child: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          child: ListView.custom(
            controller: scrollController,
            childrenDelegate: SliverChildBuilderDelegate((context, index) {
              if (index == 0) {
                return EmailHeader(
                  createEmail: () {},
                  searchEmail: (String query) async {},
                );
              } else if (index < emails.length + 1) {
                return Email.fromEmailModel(emails[index - 1], onClick: ());
              }
              return null;
            }),
          ),
          onRefresh: () async => await onRefresh(),
        ));
  }
}
