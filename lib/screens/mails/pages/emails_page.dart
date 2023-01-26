import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/mails/mails_export.dart';
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
          context.read<EmailCubit>().load();
        }

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          floatingActionButton: Hero(
            tag: "writeEmail",
            flightShuttleBuilder: (
              BuildContext flightContext,
              Animation<double> animation,
              HeroFlightDirection flightDirection,
              BuildContext fromHeroContext,
              BuildContext toHeroContext,
            ) {
              Hero toHero;
              if (flightDirection == HeroFlightDirection.pop) {
                toHero = fromHeroContext.widget as Hero;
              } else {
                toHero = toHeroContext.widget as Hero;
              }

              final MediaQueryData? toMediaQueryData =
                  MediaQuery.maybeOf(fromHeroContext);
              final MediaQueryData? fromMediaQueryData =
                  MediaQuery.maybeOf(toHeroContext);

              if (toMediaQueryData == null || fromMediaQueryData == null) {
                return toHero.child;
              }

              final EdgeInsets fromHeroPadding = fromMediaQueryData.padding;
              final EdgeInsets toHeroPadding = toMediaQueryData.padding;

              return AnimatedBuilder(
                animation: animation,
                builder: (BuildContext context, Widget? child) {
                  return MediaQuery(
                      data: toMediaQueryData.copyWith(
                        padding: (flightDirection == HeroFlightDirection.push)
                            ? EdgeInsetsTween(
                                begin: fromHeroPadding,
                                end: toHeroPadding,
                              ).evaluate(animation)
                            : EdgeInsetsTween(
                                begin: toHeroPadding,
                                end: fromHeroPadding,
                              ).evaluate(animation),
                      ),
                      child: toHero.child);
                },
              );
            },
            child: Material(
              color: (!state.connected)
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(100),
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: (!state.connected)
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
                    Icons.create_rounded,
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .unselectedItemColor,
                    size: 25.sp,
                  ),
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
                                context.read<EmailCubit>().increaseNumber(),
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
              context.read<EmailCubit>().load();
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
