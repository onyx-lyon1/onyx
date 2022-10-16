import 'package:flutter/material.dart';
import 'package:oloid2/functionalities/background_notifications/background_tasks.dart';
import 'package:oloid2/model/wrapper/day_model_wrapper.dart';
import 'package:oloid2/model/wrapper/email_model_wrapper.dart';
import 'package:oloid2/model/wrapper/teaching_unit_model_wrapper.dart';
import 'package:oloid2/others/cache_service.dart';
import 'package:oloid2/page/agenda_page.dart';
import 'package:oloid2/page/mails/emails_page.dart';
import 'package:oloid2/page/settings_page.dart';
import 'package:oloid2/page/teaching_units_page.dart';
import 'package:oloid2/widget/grades/bottom_nav_bar.dart';
import 'package:workmanager/workmanager.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  final PageController pageController = PageController();
  late int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          PageView(
              controller: pageController,
              pageSnapping: true,
              physics: const RangeMaintainingScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  if (index != currentIndex) currentIndex = index;
                });
              },
              children: [
                const TeachingUnitsPage(),
                const AgendaPage(),
                EmailsPage(),
                SettingsPage(),
              ]),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      tmpGrades();
                      // Workmanager().registerOneOffTask(
                      //   "notesChecking2",
                      //   "check new grades",
                      //   constraints:
                      //       Constraints(networkType: NetworkType.connected),
                      // );
                    },
                    child: const Text("run note check")),
                TextButton(
                    onPressed: () {
                      CacheService.reset<TeachingUnitModelWrapper>();
                    },
                    child: const Text("clean notes")),
                TextButton(
                    onPressed: () {
                      Workmanager().registerOneOffTask(
                          "notesChecking3", "check new agenda events",
                          constraints:
                              Constraints(networkType: NetworkType.connected));
                    },
                    child: const Text("run agenda check")),
                TextButton(
                    onPressed: () {
                      CacheService.reset<DayModelWrapper>();
                    },
                    child: const Text("clean agenda")),
                TextButton(
                    onPressed: () {
                      Workmanager().registerOneOffTask(
                          "notesChecking4", "check new emails",
                          constraints:
                              Constraints(networkType: NetworkType.connected));
                    },
                    child: const Text("run mail check")),
                TextButton(
                    onPressed: () {
                      CacheService.reset<EmailModelWrapper>();
                    },
                    child: const Text("clean mails")),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            if (index == currentIndex + 1 || index == currentIndex - 1) {
              pageController.animateToPage(
                index,
                curve: Curves.linear,
                duration: const Duration(milliseconds: 300),
              );
            } else if (currentIndex == index) {
              if (currentIndex == 2) {
                // TODO
              } else if (currentIndex == 3) {
                // TODO
              }

              // if (pages[currentIndex] is EmailsPage) {
              //   (pages[currentIndex] as EmailsPage).jumpToTop();
              // } else if (pages[currentIndex] is AgendaPage) {
              //   (pages[currentIndex] as AgendaPage).jumpToTop();
              // }
            } else {
              pageController.jumpToPage(index);
            }
            currentIndex = index;
          });
        },
      ),
    );
  }
}
