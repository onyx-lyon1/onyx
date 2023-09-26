import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/extensions/functionalities_extension.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/screens/home/home_export.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final ScrollController mainPageController = ScrollController();
  late ScrollController bottomBarController;
  int lastIndex = 0;

  @override
  void initState() {
    bottomBarController =
        ScrollController(initialScrollOffset: pageIndexToBottomBarOffset(-1));
    mainPageController.addListener(() {
      if (lastIndex != pageOffsetToPageIndex(mainPageController.offset)) {
        lastIndex = pageOffsetToPageIndex(mainPageController.offset);
        actionOnScreen(context, lastIndex);
      }
    });
    super.initState();
  }

  double pageIndexToBottomBarOffset(int index) {
    return (index - 1) * Res.bottomNavBarItemWidth;
    // return (index + 1) * Res.bottomNavBarItemWidth; //version a droite
  }

  double pageOffsetToBottomBarOffset(double offset) {
    return (offset / 100.w) * Res.bottomNavBarItemWidth -
        2 * Res.bottomNavBarItemWidth;
  }

  int pageOffsetToPageIndex(double offset) {
    return (offset + ((offset < 0) ? -1 : 1)) ~/ 100.w;
  }

  double bottomBarOffsetToPageOffset(double offset) {
    return (offset / Res.bottomNavBarItemWidth) * 100.w;
  }

  void animateScroll() {
    if (bottomBarController.hasClients) {
      bottomBarController.jumpTo(
        pageOffsetToBottomBarOffset(mainPageController.offset),
      );
    }
  }

  void animatePage(int index) {
    if (mainPageController.hasClients) {
      if (mainPageController.offset == index * 100.w) {
        bottomBarController
            .animateTo(pageOffsetToBottomBarOffset(mainPageController.offset),
                duration: Res.animationDuration, curve: Curves.easeInOut)
            .then((value) => setState(
                () {})); //setState needed to get the right color at animation end
      }
      mainPageController.animateTo(index * 100.w,
          duration: Res.animationDuration, curve: Curves.easeInOut);
    }
  }

  void executeWhenClient(void Function() onClient, bool Function() condition) {
    if (!condition()) {
      Future.delayed(Res.animationDuration, () {
        for (int i = 0; i < 10; i++) {
          if (condition()) {
            onClient();
            break;
          }
          sleep(Res.animationDuration);
        }
      });
    } else {
      onClient();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthentificationCubit, AuthentificationState>(
      builder: (context, state) {
        return BlocListener<SettingsCubit, SettingsState>(
          //fetch agenda whenn settings change
          listenWhen: (previous, current) =>
              previous.settings.agendaId != current.settings.agendaId ||
              previous.settings.fetchAgendaAuto !=
                  current.settings.fetchAgendaAuto,
          listener: (context, state) {
            context.read<AgendaCubit>().load(
                lyon1Cas: context.read<AuthentificationCubit>().state.lyon1Cas,
                settings: context.read<SettingsCubit>().state.settings,
                cache: false);
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            resizeToAvoidBottomInset: false,
            // floatingActionButton: Row(
            //   children: [
            //     IconButton(
            //         onPressed: () {
            //           DesktopWindow.setWindowSize(const Size(375, 667));
            //         },
            //         icon: const Icon(Icons.phone_android_rounded)),
            //     IconButton(
            //         onPressed: () {
            //           DesktopWindow.setWindowSize(const Size(1280, 720));
            //         },
            //         icon: const Icon(Icons.tablet_rounded)),
            //   ],
            // ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: CommonScreenWidget(
                      onRefresh: () async {},
                      state: (state.status ==
                              AuthentificationStatus.authentificating)
                          ? const LoadingHeaderWidget(
                              message: "Connection à cas",
                            )
                          : null,
                      body: InfiniteScrollLoopWidget(
                        key: const Key("home"),
                        builder: (context, index) {
                          return SizedBox(
                            width: 100.w,
                            height: 100.h,
                            child: context
                                .read<SettingsCubit>()
                                .state
                                .settings
                                .enabledFunctionalities[index %
                                    context
                                        .read<SettingsCubit>()
                                        .state
                                        .settings
                                        .enabledFunctionalities
                                        .length]
                                .toPage(),
                          );
                        },
                        scrollController: mainPageController,
                        axisDirection: AxisDirection.right,
                        physics: const PageScrollPhysics(),
                        onChange: (offset) {
                          setState(() {
                            animateScroll();
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: Res.bottomNavBarHeight,
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    child: BottomNavBarWidget(
                      scrollController: bottomBarController,
                      currentIndex: bottomBarController.hasClients
                          ? (((bottomBarController.offset +
                                      ((bottomBarController.offset > 0)
                                          ? Res.bottomNavBarItemWidth / 2
                                          : -Res.bottomNavBarItemWidth / 2)) ~/
                                  Res.bottomNavBarItemWidth) +
                              2)
                          : 0,
                      onTap: (realIndex) {
                        actionOnTap(context, realIndex, mainPageController);
                        setState(() {
                          animatePage(realIndex);
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
