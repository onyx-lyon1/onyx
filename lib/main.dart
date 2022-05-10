import 'package:flutter/material.dart';

import 'package:oloid2/model/day.dart';
import 'package:oloid2/model/email.dart';
import 'package:oloid2/model/settings.dart';
import 'package:oloid2/model/teaching_unit.dart';

import 'package:oloid2/page/agenda_page.dart';
import 'package:oloid2/page/emails_page.dart';
import 'package:oloid2/page/settings_page.dart';
import 'package:oloid2/page/teaching_units_page.dart';

import 'package:oloid2/widget/grades/bottom_nav_bar.dart';

void main() {
  runApp(MaterialApp(
    title: 'Oloid 2.0',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      cardTheme: const CardTheme(color: Color(0xff4c566a)),
      primaryColor: const Color(0xffd08770), // 0xffff9f00
      backgroundColor: const Color(0xff434c5e),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xff4c566a),
        unselectedItemColor: Color(0xffffffff),
        selectedItemColor: Color(0xffd08770),
      ),
      textTheme: const TextTheme(
        button: TextStyle(color: Color(0xffffffff)),
        bodyText1: TextStyle(color: Color(0xffd8dee9)),
        bodyText2: TextStyle(color: Color(0xffc2c8d2)),
      ),
    ),
    darkTheme: ThemeData(),
    home: const Home(),
  ));
}

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

  final pages = [
    TeachingUnits(
      teachingUnits: [
        TeachingUnitModel(false, '_name', [], [], []),
        TeachingUnitModel(false, '_name', [], [], []),
        TeachingUnitModel(false, '_name', [], [], []),
        TeachingUnitModel(false, '_name', [], [], []),
      ],
      forceGreen: false,
      onRefresh: () async => {/*TODO*/},
    ),
    Agenda(
      events: [
        DayModel(),
        DayModel(),
        DayModel(),
      ],
      onRefresh: () async => {/*TODO*/},
    ),
    Emails(
      emails: [
        EmailModel(),
        EmailModel(),
        EmailModel(),
        EmailModel(),
      ],
      createEmail: () {/*TODO*/},
      searchEmail: (String query) async {/*TODO*/},
      onRefresh: () async {/*TODO*/},
    ),
    SettingsPage(
      settings: SettingsModel('', ''),
      onSettingsChanged: (SettingsModel s) {},
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: PageView(
          children: pages,
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
              if (pages[currentIndex] is Emails) {
                (pages[currentIndex] as Emails).jumpToTop();
              } else if (pages[currentIndex] is Agenda) {
                (pages[currentIndex] as Agenda).jumpToTop();
              }
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
