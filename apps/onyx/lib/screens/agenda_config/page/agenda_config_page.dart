import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/agenda_config/agenda_config_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AgendaConfigPage extends StatelessWidget {
  const AgendaConfigPage(
      {super.key, required this.onBack, this.noBack = false});

  final Function(List<int> backIndexs) onBack;
  final bool noBack;

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final ScrollController listScrollController = ScrollController();
    return BlocProvider(
      create: (context) => AgendaConfigCubit(onBack: onBack),
      child: BlocBuilder<AgendaConfigCubit, AgendaConfigState>(
        builder: (context, state) {
          Widget? body;
          switch (state.status) {
            case AgendaConfigStatus.initial:
              context
                  .read<AgendaConfigCubit>()
                  .loadDirs(AppLocalizations.of(context));
              body = StateDisplayingPage(
                  message: AppLocalizations.of(context).loadingAgendaList);
              break;
            case AgendaConfigStatus.loading:
              body = StateDisplayingPage(
                  message: AppLocalizations.of(context).loadingAgendaList);
              break;
            case AgendaConfigStatus.error:
              body = StateDisplayingPage(
                  message: AppLocalizations.of(context).errorAppeared);
              break;
            default:
              body = BlocListener<AgendaConfigCubit, AgendaConfigState>(
                listener: (context, state) {
                  if (pageController.hasClients) {
                    pageController.animateToPage(
                        (state.expandedDirs.length).toInt(),
                        duration: Res.animationDuration,
                        curve: Curves.easeInOut);
                  }
                },
                child: PopScope(
                  onPopInvoked: (_) async {
                    pageController.animateToPage(
                        pageController.page!.toInt() - 1,
                        duration: Res.animationDuration,
                        curve: Curves.easeInOut);
                  },
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      MultiScrollableWidget(
                        pageController: pageController,
                        listScrollController: [listScrollController],
                        child: PageView.custom(
                          controller: pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          childrenDelegate: SliverChildBuilderDelegate(
                            (context, index) {
                              if (index == 0) {
                                return DirWidget(
                                  dir: DirModel(
                                    name: AppLocalizations.of(context).agenda,
                                    identifier: 0,
                                    children: state.dirs,
                                  ),
                                  scrollController: listScrollController,
                                );
                              } else {
                                if (state.dirs.isNotEmpty &&
                                    index - 1 < state.expandedDirs.length) {
                                  return DirWidget(
                                    dir: state.expandedDirs[index - 1],
                                    scrollController: listScrollController,
                                  );
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      BlocBuilder<AgendaConfigCubit, AgendaConfigState>(
                        builder: (context, state) {
                          return AnimatedScale(
                            scale: state.choosedIds.isNotEmpty ? 1 : 0,
                            duration: Res.animationDuration,
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: 10.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(context).primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5),
                                    blurRadius: 8,
                                    offset:
                                        const Offset(4, 4), // Shadow position
                                  ),
                                ],
                              ),
                              child: IconButton(
                                onPressed: () {
                                  context
                                      .read<AgendaConfigCubit>()
                                      .onBack(state.choosedIds);
                                },
                                icon: Icon(
                                  Icons.check_rounded,
                                  color: Theme.of(context)
                                      .bottomNavigationBarTheme
                                      .unselectedItemColor,
                                  size: 30.sp,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
              break;
          }

          return Scaffold(
            floatingActionButton: Material(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(100),
              child: OpenContainer<String>(
                transitionDuration: Res.animationDuration,
                openBuilder: (context, closechild) => const QrCodeScannerPage(),
                onClosed: (result) {
                  if (result != null) {
                    List<int> indexs = AgendaConfigLogic.urlToIndexs(result);
                    for (var index in indexs) {
                      context.read<AgendaConfigCubit>().toggleChooseDir(
                          context.read<AgendaConfigCubit>().state.dirs[index]);
                    }
                  }
                },
                closedColor: Theme.of(context).primaryColor,
                closedShape: const CircleBorder(),
                closedBuilder: (context, openchild) => InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: openchild,
                  child: Padding(
                    padding: EdgeInsets.all(0.8.h),
                    child: Icon(
                      Icons.qr_code_rounded,
                      color: Theme.of(context).textTheme.bodySmall!.color,
                      size: 30.sp,
                    ),
                  ),
                ),
              ),
            ),
            body: CommonScreenWidget(
              header: LayoutBuilder(builder: (context, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (!noBack)
                      Padding(
                        padding: EdgeInsets.only(left: 2.w),
                        child: Material(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            onTap: () {
                              if (state.status ==
                                  AgendaConfigStatus.searchResult) {
                                context.read<AgendaConfigCubit>().unSearch();
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Icon(
                              Icons.arrow_back_rounded,
                            ),
                          ),
                        ),
                      ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        margin: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (String query) {},
                          onSubmitted: (String query) {
                            context.read<AgendaConfigCubit>().search(
                                  query,
                                );
                            FocusScope.of(context).unfocus();
                          },
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.labelLarge!.color,
                          ),
                          cursorColor:
                              Theme.of(context).textTheme.bodyLarge!.color,
                          decoration: InputDecoration(
                            // contentPadding: EdgeInsets.symmetric(vertical: 1.5.h),
                            hintText:
                                AppLocalizations.of(context).searchInCalendars,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 4.w),
                          ),
                          expands: false,
                        ),
                      ),
                    ),
                  ],
                );
              }),
              body: body,
            ),
          );
        },
      ),
    );
  }
}
