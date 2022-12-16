import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/core/res.dart';
import 'package:oloid2/core/widgets/core_widget_export.dart';
import 'package:oloid2/screens/agenda/agenda_export.dart';
import 'package:oloid2/screens/login/login_export.dart';
import 'package:oloid2/screens/mails/mails_export.dart';
import 'package:oloid2/screens/settings/settings_export.dart';
import 'package:oloid2/screens/tomuss/tomuss_export.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  final PageController mainPageController = PageController();
  final PageController rightPageController = PageController();
  final PageController leftPageController = PageController();
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
    // return (index - 1) * Res.bottomNavBarItemWidth -
    //     (Res.bottomNavBarItemWidth / 2);//version centree
    return (index + 1) * Res.bottomNavBarItemWidth; //version a droite
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
      //Check that at least the root page view exist
      if (currentRealIndex < 0) {
        //if we are negative so we should be on index 1 of mainPageView
        int tmpIndex =
            currentRealIndex; //because the index could change during the animation
        if (mainPageController.page != 1) {
          //main is on the wrong move it
          mainPageController.animateToPage(1,
              duration: Res.animationDuration, curve: Curves.easeInOut);
        }
        executeWhenClient(() {
          //move the page but wait for attaching controller before
          rightPageController.animateToPage(-tmpIndex - 1,
              duration: Res.animationDuration, curve: Curves.easeInOut);
        }, () => rightPageController.hasClients);
      } else {
        int tmpIndex =
            currentRealIndex; //because the index could change during the animation
        if (mainPageController.page != 0) {
          //wrong index so move
          mainPageController.animateToPage(0,
              duration: Res.animationDuration, curve: Curves.easeInOut);
        }
        executeWhenClient(() {
          leftPageController.animateToPage(tmpIndex,
              duration: Res.animationDuration, curve: Curves.easeInOut);
        }, () => leftPageController.hasClients);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthentificationCubit, AuthentificationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Column(
            children: [
              CommonScreenWidget(
                onRefresh: () async {
                  if (kDebugMode) {
                    print('refresh in home');
                  }
                  return;
                },
                state: (state.status == AuthentificationStatus.authentificating)
                    ? const LoadingHeaderWidget(
                        message: "Connection à cas",
                      )
                    : null,
                body: PageView(
                  controller: mainPageController,
                  reverse: true,
                  children: [
                    PageView.builder(
                      controller: leftPageController,
                      itemBuilder: (context, index) {
                        switch (index % Res.screenCount) {
                          case 0:
                            return const TomussPage();
                          case 1:
                            return const AgendaPage();
                          case 2:
                            return const EmailsPage();
                          case 3:
                            return const SettingsPage();
                          default:
                            return Container();
                        }
                      },
                      onPageChanged: (index) {
                        setState(() {
                          currentRealIndex = index;
                          animateScroll();
                        });
                      },
                    ),
                    PageView.builder(
                      controller: rightPageController,
                      reverse: true,
                      itemBuilder: (context, index) {
                        int realIndex = -index - 1;
                        switch (realIndex % Res.screenCount) {
                          case 0:
                            return const TomussPage();
                          case 1:
                            return const AgendaPage();
                          case 2:
                            return const EmailsPage();
                          case 3:
                            return const SettingsPage();
                          default:
                            return Container();
                        }
                      },
                      onPageChanged: (index) {
                        setState(() {
                          currentRealIndex = -index - 1; //-1 to avoid double 0
                          animateScroll();
                        });
                      },
                    ),
                  ],
                  onPageChanged: (index) {
                    setState(() {
                      if (index == 1) {
                        currentRealIndex = -1;
                      } else {
                        currentRealIndex = 0;
                      }
                      animateScroll();
                    });
                  },
                ),
              ),
              SizedBox(
                height: Res.bottomNavBarHeight,
                child: BottomNavBarWidget(
                  scrollController: scrollController,
                  currentIndex: currentRealIndex,
                  onTap: (realIndex) {
                    if (realIndex % Res.screenCount == 2 &&
                        currentRealIndex == realIndex) {
                      if (currentRealIndex == 1) {
                        context.read<AgendaCubit>().updateDisplayedDate(
                            date: DateTime.now(), fromPageController: false);
                      }
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
        );
      },
    );
  }
}
