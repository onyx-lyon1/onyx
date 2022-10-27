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
        } else if (state is EmailLoading) {
          WidgetsBinding.instance.addPostFrameCallback((_) =>
              ScaffoldMessenger.of(context).showSnackBar(
                  loadingSnakbar(message: "emails", context: context)));
        } else if (state is EmailLoaded || state is EmailSorted) {
          WidgetsBinding.instance.addPostFrameCallback(
              (_) => ScaffoldMessenger.of(context).removeCurrentSnackBar());
        }
        return Scaffold(
          floatingActionButton: Material(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(100),
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
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
                childrenDelegate: SliverChildBuilderDelegate((context, index) {
                  if (index == 0) {
                    return const EmailHeader();
                  } else if (index <= context.read<EmailBloc>().emails.length) {
                    return Email(
                        email: context.read<EmailBloc>().emails[index - 1]);
                  } else if (index ==
                      context.read<EmailBloc>().emails.length + 1) {
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
                                  child:
                                      const Text("Charger 20 messages de plus"),
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
    );
  }
}
