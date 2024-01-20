import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MailsPage extends StatelessWidget {
  const MailsPage({
    super.key,
  });

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
                context.read<SettingsCubit>().state.settings.blockTrackers,
            appLocalizations: AppLocalizations.of(context)!);
      },
      builder: (context, state) {
        Widget? loadingHeader;
        switch (state.status) {
          case MailStatus.connecting:
            loadingHeader = LoadingHeaderWidget(
              message: AppLocalizations.of(context)!.mailServerConnection,
            );
            break;
          case MailStatus.loading:
          case MailStatus.cacheLoaded:
          case MailStatus.cacheSorted:
          case MailStatus.mailboxesLoaded:
            loadingHeader = LoadingHeaderWidget(
                message: AppLocalizations.of(context)!.loadingMails);
            break;
          case MailStatus.error:
            loadingHeader = LoadingHeaderWidget(
              message: AppLocalizations.of(context)!.mailServerConnectionError,
            );
            break;
          case MailStatus.nonFatalError:
            loadingHeader = LoadingHeaderWidget(
              message: AppLocalizations.of(context)!.errorOccured,
            );
            break;
          case MailStatus.initial:
            CacheService.getEncryptionKey(
                    context.read<SettingsCubit>().state.settings.biometricAuth)
                .then((key) => CacheService.get<Credential>(secureKey: key))
                .then((value) => context.read<EmailCubit>().connect(
                      username: value!.username,
                      password: value.password,
                      appLocalizations: AppLocalizations.of(context)!,
                    ));

            break;
          case MailStatus.connected:
            context.read<EmailCubit>().load(
                  blockTrackers: context
                      .read<SettingsCubit>()
                      .state
                      .settings
                      .blockTrackers,
                  appLocalizations: AppLocalizations.of(context)!,
                );

            break;
          case MailStatus.sending:
            loadingHeader = LoadingHeaderWidget(
                message: AppLocalizations.of(context)!.sendingEmail);
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
        return PopScope(
          onPopInvoked: (_) {
            context
                .read<EmailCubit>()
                .unselectAllMails(AppLocalizations.of(context)!);
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
                    color: Theme.of(context).textTheme.bodySmall!.color,
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
                                          appLocalizations:
                                              AppLocalizations.of(context)!,
                                        ),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.w),
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .loadMoreMails),
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
                      appLocalizations: AppLocalizations.of(context)!,
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
