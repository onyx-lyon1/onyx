// ignore: unnecessary_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/page/mails/email_send_page.dart';
import 'package:oloid2/states/authentification/authentification_bloc.dart';
import 'package:oloid2/states/email/email_bloc.dart';
import 'package:oloid2/widget/loading_snakbar.dart';
import 'package:oloid2/widget/state_displaying.dart';
import 'package:sizer/sizer.dart';

import '../../widget/emails/email.dart';
import '../../widget/emails/email_header.dart';

class EmailsPage extends StatelessWidget {
  const EmailsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return BlocListener<EmailBloc, EmailState>(
      listener: (context, state) {
        if (state is EmailConnected) {
          context.read<EmailBloc>().add(EmailLoad());
        } else if (state is EmailConnecting) {
          ScaffoldMessenger.of(context).showSnackBar(loadingSnackbar(
            message: "Connection au emails",
            context: context,
            shouldDisable: context
                .read<EmailBloc>()
                .stream
                .map<bool>((event) => event is! EmailConnected),
          ));
        } else if (state is EmailLoading || state is EmailCacheLoaded) {
          loadingSnackbar(
            message: "Chargement des emails",
            context: context,
            shouldDisable: context.read<EmailBloc>().stream.map<bool>((event) =>
                !(event is EmailLoading || event is EmailCacheLoaded)),
          );
        }
      },
      child: BlocBuilder<EmailBloc, EmailState>(
        builder: (context, state) {
          if (kDebugMode) {
            print("EmailsState: $state");
          }
          if (state is EmailError) {
            return const StateDisplaying(
                message: "Something went wrong with emails");
          }
          if (state is EmailInitial) {
            context.read<EmailBloc>().add(EmailConnect(
                username: context.read<AuthentificationBloc>().usename,
                password: context.read<AuthentificationBloc>().password));
            return const StateDisplaying(message: "Connection au mails");
          } else if (state is EmailConnected) {
            return const StateDisplaying(message: "Chargement des mails");
          }
          return Scaffold(
            floatingActionButton: Material(
              color: (state is EmailInitial ||
                      state is EmailConnecting ||
                      state is EmailCacheLoaded)
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(100),
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: (state is EmailInitial ||
                        state is EmailConnecting ||
                        state is EmailCacheLoaded)
                    ? null
                    : () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const EmailSendPage(),
                          ),
                        );
                      },
                child: Padding(
                  padding: EdgeInsets.all(1.5.h),
                  child: Icon(
                    Icons.create,
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .unselectedItemColor,
                    size: 25.sp,
                  ),
                ),
              ),
            ),
            body: Container(
              color: Theme.of(context).backgroundColor,
              child: RefreshIndicator(
                backgroundColor: Theme.of(context).backgroundColor,
                color: Theme.of(context).primaryColor,
                child: ListView.custom(
                  controller: scrollController,
                  childrenDelegate:
                      SliverChildBuilderDelegate((context, index) {
                    if (index == 0) {
                      return const EmailHeader();
                    } else if (index <=
                        context.read<EmailBloc>().emails.length) {
                      return Email(
                          email: context.read<EmailBloc>().emails[index - 1]);
                    } else if ((index ==
                            context.read<EmailBloc>().emails.length + 1) &&
                        context.read<EmailBloc>().emails.isNotEmpty) {
                      return Material(
                        color: Theme.of(context).backgroundColor,
                        child: (context.read<EmailBloc>().state is EmailLoading)
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.all(5.w),
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () => context
                                    .read<EmailBloc>()
                                    .add(EmailIncreaseNumber()),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.w),
                                    child: const Text(
                                        "Charger 20 messages de plus"),
                                  ),
                                ),
                              ),
                      );
                    }
                    return null;
                  }),
                ),
                onRefresh: () async {
                  context.read<EmailBloc>().add(EmailLoad());
                  while (context.read<EmailBloc>().state is! EmailLoaded &&
                      context.read<EmailBloc>().state is! EmailError &&
                      context.read<EmailBloc>().state is! EmailSorted) {
                    await Future.delayed(const Duration(milliseconds: 100));
                  }
                  return;
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
