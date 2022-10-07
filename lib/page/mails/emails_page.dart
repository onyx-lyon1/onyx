import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/states/authentification/authentification_bloc.dart';
import 'package:oloid2/states/email/email_bloc.dart';
import 'package:oloid2/widget/state_displaying.dart';

import '../../widget/emails/email.dart';
import '../../widget/emails/email_header.dart';

class EmailsPage extends StatelessWidget {
  final ScrollController scrollController = ScrollController();

  EmailsPage({
    Key? key,
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
    return BlocBuilder<EmailBloc, EmailState>(
      builder: (context, state) {
        if (kDebugMode) {
          print(state);
        }
        if (state is EmailError) {
          return const StateDisplaying(
              message: "Something went wrong with emails");
        } else if (state is EmailInitial) {
          context.read<EmailBloc>().add(EmailConnect(
              username: context.read<AuthentificationBloc>().usename,
              password: context.read<AuthentificationBloc>().password));
          return const StateDisplaying(message: "Connecting to mail");
        } else if (state is EmailConnected) {
          context.read<EmailBloc>().add(EmailLoad());
          return const StateDisplaying(message: "Loading to mail");
        }

        return Container(
          color: Theme.of(context).backgroundColor,
          child: RefreshIndicator(
            color: Theme.of(context).primaryColor,
            child: ListView.custom(
              controller: scrollController,
              childrenDelegate: SliverChildBuilderDelegate((context, index) {
                if (index == 0) {
                  return const EmailHeader();
                } else if (index <= context.read<EmailBloc>().emails.length) {
                  return Email(
                      email: context.read<EmailBloc>().emails[index - 1]);
                }
                return null;
              }),
            ),
            onRefresh: () async {
              context.read<EmailBloc>().add(EmailLoad());
            },
          ),
        );
      },
    );
  }
}
