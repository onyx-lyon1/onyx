import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/home/home_export.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:sizer/sizer.dart';

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

  @override
  void initState() {
    bottomBarController =
        ScrollController(initialScrollOffset: pageIndexToBottomBarOffset(-1));
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

  double bottomBarOffsetToPageOffset(double offset) {
    return (offset / Res.bottomNavBarItemWidth) * 100.w;
  }

  void animateScroll() {
    if (bottomBarController.hasClients) {
      bottomBarController.jumpTo(
        pageOffsetToBottomBarOffset(mainPageController.offset),
      );
      // bottomBarController.animateTo(pageIndexToBottomBarOffset(currentRealIndex - 1),
      //     duration: Res.animationDuration, curve: Curves.easeInOut);
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

  void animatePage(int index) {
    if (mainPageController.hasClients) {
      mainPageController.animateTo(index * 100.w,
          duration: Res.animationDuration, curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthentificationCubit, AuthentificationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
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
                        return [
                          SizedBox(
                              width: 100.w,
                              height: 100.h,
                              child: const TomussPage()),
                          SizedBox(
                              width: 100.w,
                              height: 100.h,
                              child: const AgendaPage()),
                          SizedBox(
                              width: 100.w,
                              height: 100.h,
                              child: const EmailsPage()),
                          SizedBox(
                              width: 100.w,
                              height: 100.h,
                              child: const SettingsPage()),
                          SizedBox(
                              width: 100.w,
                              height: 100.h,
                              child: const IzlyPage()),
                          SizedBox(
                              width: 100.w,
                              height: 100.h,
                              child: const MapPage()),
                        ][(index) % Res.screenCount];
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
                SizedBox(
                  height: Res.bottomNavBarHeight,
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
                      if (realIndex % Res.screenCount == 1 &&
                          (bottomBarController.hasClients
                                  ? (bottomBarController.offset ~/
                                          Res.bottomNavBarItemWidth) +
                                      2
                                  : 0) ==
                              realIndex) {
                        context.read<AgendaCubit>().updateDisplayedDate(
                            date: DateTime.now(), fromPageController: false);
                      }
                      setState(() {
                        animatePage(realIndex);
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
