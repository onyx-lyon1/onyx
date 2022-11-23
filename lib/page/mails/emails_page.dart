// ignore: unnecessary_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/page/mails/email_send_page.dart';
import 'package:oloid2/states/authentification/authentification_cubit.dart';
import 'package:oloid2/states/email/email_cubit.dart';
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

    return BlocListener<EmailCubit, EmailState>(
      listener: (context, state) {
        if (state.status == EmailStatus.connected) {
          context.read<EmailCubit>().load();
        } else if (state.status == EmailStatus.connecting) {
          ScaffoldMessenger.of(context).showSnackBar(loadingSnackbar(
            message: "Connection au emails",
            context: context,
            shouldDisable: context
                .read<EmailCubit>()
                .stream
                .map<bool>((event) => event.status != EmailStatus.connected),
          ));
        } else if (state.status == EmailStatus.loading ||
            state.status == EmailStatus.cacheLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(loadingSnackbar(
            message: "Chargement des emails",
            context: context,
            shouldDisable: context.read<EmailCubit>().stream.map<bool>(
                (event) => !(state.status == EmailStatus.loading ||
                    state.status == EmailStatus.cacheLoaded)),
          ));
        }
      },
      child: BlocBuilder<EmailCubit, EmailState>(
        builder: (context, state) {
          if (kDebugMode) {
            print("EmailsState: $state");
          }
          if (state.status == EmailStatus.error) {
            return const StateDisplaying(
                message: "Something went wrong with emails");
          }
          if (state.status == EmailStatus.initial) {
            context.read<EmailCubit>().connect(
                username: context.read<AuthentificationCubit>().state.username,
                password: context.read<AuthentificationCubit>().state.password);
          } else if (state.status == EmailStatus.connected) {
            return const StateDisplaying(message: "Chargement des mails");
          }

          return Scaffold(
            floatingActionButton: Material(
              color: (state.status == EmailStatus.initial ||
                      state.status == EmailStatus.connecting ||
                      state.status == EmailStatus.cacheLoaded)
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(100),
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: (state.status == EmailStatus.initial ||
                        state.status == EmailStatus.connecting ||
                        state.status == EmailStatus.cacheLoaded)
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
                    } else if (index <= state.emails.length) {
                      return Email(email: state.emails[index - 1]);
                    } else if ((index == state.emails.length + 1) &&
                        state.emails.isNotEmpty) {
                      return Material(
                        color: Theme.of(context).backgroundColor,
                        child: (state.status == EmailStatus.loading)
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
                                    .read<EmailCubit>()
                                    .increaseNumber(),
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
                  context.read<EmailCubit>().load();
                  while (state.status != EmailStatus.loaded && state.status != EmailStatus.error && state.status != EmailStatus.sorted) {
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
