import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1casclient/lyon1_cas.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:sizer/sizer.dart';

class MailsPage extends StatelessWidget {
  const MailsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return BlocConsumer<EmailCubit, EmailState>(
      listenWhen: (previous, current) =>
          (current.status == MailStatus.connected ||
              current.status == MailStatus.loaded) &&
          current.status != previous.status,
      listener: (context, state) {
        context.read<EmailCubit>().doQueuedAction(
            blockTrackers:
                context.read<SettingsCubit>().state.settings.blockTrackers);
      },
      builder: (context, state) {
        if (kDebugMode) {
          print("MailsState: ${state.status}");
        }
        Widget? loadingHeader;
        switch (state.status) {
          case MailStatus.connecting:
            loadingHeader = const LoadingHeaderWidget(
              message: "Connection au Mails",
            );
            break;
          case MailStatus.loading:
          case MailStatus.cacheLoaded:
          case MailStatus.cacheSorted:
          case MailStatus.mailboxesLoaded:
            loadingHeader =
                const LoadingHeaderWidget(message: "Chargement des Mails");
            break;
          case MailStatus.error:
            loadingHeader = const LoadingHeaderWidget(
              message: "Erreur de chargement des Mails",
            );
            break;
          case MailStatus.nonFatalError:
            loadingHeader = const LoadingHeaderWidget(
              message: "Une erreur est survenue",
            );
            break;
          case MailStatus.initial:
            CacheService.getEncryptionKey(
                    context.read<SettingsCubit>().state.settings.biometricAuth)
                .then((key) => CacheService.get<Credential>(secureKey: key))
                .then((value) => context.read<EmailCubit>().connect(
                    username: value!.username, password: value.password));

            break;
          case MailStatus.connected:
            context.read<EmailCubit>().load(
                  blockTrackers: context
                      .read<SettingsCubit>()
                      .state
                      .settings
                      .blockTrackers,
                );

            break;
          case MailStatus.sending:
            loadingHeader =
                const LoadingHeaderWidget(message: "Envoie du mail");
            break;
          case MailStatus.loaded:
            break;
          case MailStatus.sended:
            break;
          case MailStatus.updated:
            break;
          case MailStatus.sorted:
            break;
        }
        return WillPopScope(
          onWillPop: () {
            context.read<EmailCubit>().unselectAllMails();
            return Future.value(true);
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            floatingActionButton: OpenContainer(
              openColor: Theme.of(context).colorScheme.background,
              closedColor: (!state.connected)
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).primaryColor,
              closedShape: const CircleBorder(),
              closedElevation: 6,
              transitionDuration: Res.animationDuration,
              tappable: state.connected,
              openBuilder: (context, closedContainer) => const MailSendPage(),
              closedBuilder: (context, openContainer) => InkWell(
                onTap: (state.connected) ? openContainer : null,
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
              header: const MailHeaderWidget(),
              body: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 0.7 * Res.bottomNavBarHeight),
                    child: ListView.custom(
                      controller: scrollController,
                      childrenDelegate:
                          SliverChildBuilderDelegate((context, index) {
                        if (index < state.currentMailBox!.emails.length) {
                          return MailWidget(
                              email: state.currentMailBox!.emails[index]);
                        } else if ((index ==
                                state.currentMailBox!.emails.length) &&
                            state.currentMailBox!.emails.isNotEmpty) {
                          return Material(
                            color: Theme.of(context).colorScheme.background,
                            child: (state.status == MailStatus.loading)
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
                                        .increaseNumber(
                                          blockTrackers: context
                                              .read<SettingsCubit>()
                                              .state
                                              .settings
                                              .blockTrackers,
                                        ),
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
                  ),
                  const MailMailboxChooserWidget(),
                ],
              ),
              onRefresh: () async {
                context.read<EmailCubit>().load(
                      blockTrackers: context
                          .read<SettingsCubit>()
                          .state
                          .settings
                          .blockTrackers,
                    );
                return;
              },
            ),
          ),
        );
      },
    );
  }
}
