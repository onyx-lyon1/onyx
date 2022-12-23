import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/core/res.dart';
import 'package:oloid2/core/widgets/core_widget_export.dart';
import 'package:oloid2/screens/agenda/agenda_export.dart';
import 'package:oloid2/screens/login/login_export.dart';
import 'package:oloid2/screens/mails/mails_export.dart';
import 'package:oloid2/screens/map/map_export.dart';
import 'package:oloid2/screens/settings/settings_export.dart';
import 'package:oloid2/screens/tomuss/tomuss_export.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  final ScrollController mainPageController = ScrollController();
  late ScrollController scrollController;
  late int currentRealIndex = 0;
  bool isAnimating = false;
  bool fromBottom = false;

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: getOffset(-1));
    super.initState();
  }

  double getOffset(int index) {
    return (index - 1) * Res.bottomNavBarItemWidth;
    // return (index + 1) * Res.bottomNavBarItemWidth; //version a droite
  }

  void animateScroll() {
    if (scrollController.hasClients && !isAnimating) {
      scrollController.animateTo(getOffset(currentRealIndex - 1),
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

  void animatePage() {
    if (mainPageController.hasClients && !isAnimating) {
      mainPageController.animateTo(currentRealIndex * 100.w,
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
                      builder: (context, index) {
                        switch ((index) % Res.screenCount) {
                          case 0:
                            return SizedBox(
                                width: 100.w,
                                height: 50.h - Res.bottomNavBarHeight,
                                child: const TomussPage());
                          case 1:
                            return SizedBox(
                                width: 100.w,
                                height: 100.h,
                                child: const AgendaPage());
                          case 2:
                            return SizedBox(
                                width: 100.w,
                                height: 100.h,
                                child: const EmailsPage());
                          case 3:
                            return SizedBox(
                                width: 100.w,
                                height: 100.h,
                                child: const SettingsPage());
                          case 4:
                            return SizedBox(
                                width: 100.w,
                                height: 100.h,
                                child: const MapPage());
                          default:
                            return Container();
                        }
                      },
                      scrollController: mainPageController,
                      axisDirection: AxisDirection.right,
                      physics: const PageScrollPhysics(),
                      onChange: (doubleIndex) {
                        int index = doubleIndex.toInt();
                        setState(() {
                          currentRealIndex = index;
                          animateScroll();
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: Res.bottomNavBarHeight,
                  child: BottomNavBarWidget(
                    scrollController: scrollController,
                    currentIndex: currentRealIndex,
                    onTap: (realIndex) {
                      if (realIndex % Res.screenCount == 1 &&
                          currentRealIndex == realIndex) {
                        context.read<AgendaCubit>().updateDisplayedDate(
                            date: DateTime.now(), fromPageController: false);
                      }
                      setState(() {
                        currentRealIndex = realIndex;
                        fromBottom = true;
                        animateScroll();
                        animatePage();
                        isAnimating = true;
                        Future.delayed(Res.animationDuration, () {
                          isAnimating = false;
                        });
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
