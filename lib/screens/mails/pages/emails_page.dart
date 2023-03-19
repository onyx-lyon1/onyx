import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:sizer/sizer.dart';

class EmailsPage extends StatelessWidget {
  const EmailsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return BlocBuilder<EmailCubit, EmailState>(
      builder: (context, state) {
        if (kDebugMode) {
          print("EmailsState: ${state.status}");
        }
        Widget? loadingHeader;
        if (state.status == EmailStatus.connecting) {
          loadingHeader = const LoadingHeaderWidget(
            message: "Connection au emails",
          );
        } else if (state.status == EmailStatus.loading ||
            state.status == EmailStatus.cacheLoaded ||
            state.status == EmailStatus.cacheSorted) {
          loadingHeader =
              const LoadingHeaderWidget(message: "Chargement des emails");
        } else if (state.status == EmailStatus.error) {
          loadingHeader = const LoadingHeaderWidget(
            message: "Erreur de chargement des emails",
          );
        } else if (state.status == EmailStatus.initial) {
          context.read<EmailCubit>().connect(
              username: context.read<AuthentificationCubit>().state.username,
              password: context.read<AuthentificationCubit>().state.password);
        } else if (state.status == EmailStatus.connected) {
          context.read<EmailCubit>().load(
                blockTrackers:
                    context.read<SettingsCubit>().state.settings.blockTrackers,
              );
        }

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          floatingActionButton: OpenContainer(
            openColor: Theme.of(context).colorScheme.background,
            closedColor: (!state.connected)
                ? Theme.of(context).disabledColor
                : Theme.of(context).primaryColor,
            closedShape: const CircleBorder(),
            closedElevation: 6,
            transitionDuration: Res.animationDuration,
            openBuilder: (context, closedContainer) => const EmailSendPage(),
            closedBuilder: (context, openContainer) => InkWell(
              onTap: openContainer,
              child: Padding(
                padding: EdgeInsets.all(1.5.h),
                child: Icon(
                  Icons.create_rounded,
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor,
                  size: 25.sp,
                ),
              ),
            ),
          ),
          body: CommonScreenWidget(
            state: loadingHeader,
            header: const EmailHeaderWidget(),
            body: ListView.custom(
              controller: scrollController,
              childrenDelegate: SliverChildBuilderDelegate((context, index) {
                if (index < state.emails.length) {
                  return EmailWidget(email: state.emails[index]);
                } else if ((index == state.emails.length) &&
                    state.emails.isNotEmpty) {
                  return Material(
                    color: Theme.of(context).colorScheme.background,
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
                            onTap: () =>
                                context.read<EmailCubit>().increaseNumber(
                                      blockTrackers: context
                                          .read<SettingsCubit>()
                                          .state
                                          .settings
                                          .blockTrackers,
                                    ),
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
              context.read<EmailCubit>().load(
                    blockTrackers: context
                        .read<SettingsCubit>()
                        .state
                        .settings
                        .blockTrackers,
                  );
              while (state.status != EmailStatus.loaded &&
                  state.status != EmailStatus.error &&
                  state.status != EmailStatus.sorted) {
                await Future.delayed(const Duration(milliseconds: 100));
              }
              return;
            },
          ),
        );
      },
    );
  }
}
