import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/agenda_config/agenda_config_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AgendaConfigPage extends StatelessWidget {
  const AgendaConfigPage({Key? key, required this.onBack, this.noBack = false})
      : super(key: key);
  final Function(int backIndex) onBack;
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
              context.read<AgendaConfigCubit>().loadDirs();
              body = const StateDisplayingPage(
                  message: "Chargement de la liste des agendas");
              break;
            case AgendaConfigStatus.loading:
              body = const StateDisplayingPage(
                  message: "Chargement de la liste des agendas");
              break;
            case AgendaConfigStatus.error:
              body =
                  const StateDisplayingPage(message: "Une erreur est survenue");
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
                child: WillPopScope(
                  onWillPop: () async {
                    pageController.animateToPage(
                        pageController.page!.toInt() - 1,
                        duration: Res.animationDuration,
                        curve: Curves.easeInOut);
                    return false;
                  },
                  child: DoubleScrollableWidget(
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
                                name: "Agendas",
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
                    context
                        .read<AgendaConfigCubit>()
                        .chooseDir(AgendaConfigLogic.urlToIndex(result));
                  }
                },
                closedColor: Theme.of(context).primaryColor,
                closedShape: const CircleBorder(),
                closedBuilder: (context, openchild) => InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: openchild,
                  child: Padding(
                    padding: EdgeInsets.all(1.5.h),
                    child: Icon(
                      Icons.qr_code_rounded,
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .unselectedItemColor,
                      size: 30.sp,
                    ),
                  ),
                ),
              ),
            ),
            body: CommonScreenWidget(
              header: LayoutBuilder(builder: (context, constraints) {
                return Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.01,
                      vertical: constraints.maxWidth * 0.01),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (!noBack)
                        Padding(
                          padding: EdgeInsets.only(left: 2.w),
                          child: Material(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
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
                        child: TextField(
                          onChanged: (String query) {},
                          onSubmitted: (String query) {
                            context.read<AgendaConfigCubit>().search(query);
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
                            hintText: "Recherche dans les agendas",
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: Theme.of(context)
                                  .bottomNavigationBarTheme
                                  .unselectedItemColor,
                            ),
                            border: InputBorder.none,
                            // contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
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
