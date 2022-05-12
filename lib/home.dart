import 'package:flutter/material.dart';
import 'package:oloid2/model/event.dart';
import 'package:oloid2/model/grade.dart';

import 'package:oloid2/model/settings.dart';
import 'package:oloid2/model/day.dart';
import 'package:oloid2/model/email.dart';
import 'package:oloid2/model/teaching_unit.dart';

import 'package:oloid2/page/teaching_units_page.dart';
import 'package:oloid2/page/agenda_page.dart';
import 'package:oloid2/page/emails_page.dart';
import 'package:oloid2/page/settings_page.dart';

import 'package:oloid2/widget/grades/bottom_nav_bar.dart';

class Home extends StatefulWidget {
  final SettingsModel settings;
  final Function(SettingsModel s) onSettingsChanged;

  const Home(this.settings, this.onSettingsChanged, {Key? key})
      : super(key: key);

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
      body: PageView(
          children: [
            TeachingUnitsPage(
              teachingUnits: [
                TeachingUnitModel(
                  isSeen: false,
                  isHidden: false,
                  name: 'A',
                  grades: [
                    GradeModel(
                      name: 'Example Grade',
                      author: 'Grade author',
                      gradeNumerator: 15,
                      gradeDenominator: 20,
                      rank: 2,
                      average: 10,
                      mediane: 9.5,
                    )
                  ],
                  masters: [],
                  textValues: [],
                ),
                TeachingUnitModel(
                  isSeen: false,
                  isHidden: true,
                  name: 'B',
                  grades: [
                    GradeModel(
                      name: 'Example Grade',
                      author: 'Grade author',
                      gradeNumerator: 9,
                      gradeDenominator: 20,
                      rank: 2,
                      average: 10,
                      mediane: 9.5,
                    )
                  ],
                  masters: [],
                  textValues: [],
                ),
                TeachingUnitModel(
                  isSeen: false,
                  isHidden: false,
                  name: 'C',
                  grades: [
                    GradeModel(
                      name: 'Example Grade',
                      author: 'Grade author',
                      gradeNumerator: 11,
                      gradeDenominator: 20,
                      rank: 2,
                      average: 10,
                      mediane: 9.5,
                    )
                  ],
                  masters: [],
                  textValues: [],
                ),
              ],
              forceGreen: widget.settings.forceGreen,
              showHidden: widget.settings.showHiddenUE,
              onRefresh: () async => {/*TODO*/},
            ),
            AgendaPage(
              showMiniCalendar: widget.settings.showMiniCalendar,
              events: [
                DayModel('Aujoudhui', [EventModel(), EventModel()]),
                DayModel('Demain', []),
                DayModel('un jour', []),
              ],
              onRefresh: () async => {/*TODO*/},
            ),
            EmailsPage(
              emails: [
                EmailModel(
                  date: DateTime.now(),
                  excerpt: 'lorem ipsum dolor sit amet',
                  isRead: false,
                  sender: 'sender@mail.com',
                  subject: 'the subject of the mail',
                ),
              ],
              createEmail: () {/*TODO*/},
              searchEmail: (String query) async {/*TODO*/},
              onRefresh: () async {/*TODO*/},
            ),
            SettingsPage(
              settings: widget.settings,
              onSettingsChanged: (SettingsModel s) {
                widget.settings.copy(s);
                widget.onSettingsChanged(s);

                setState(() {});
              },
            ),
          ],
          controller: pageController,
          pageSnapping: true,
          physics: const RangeMaintainingScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              if (index != currentIndex) currentIndex = index;
            });
          }),
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
