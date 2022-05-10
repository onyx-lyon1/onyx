import 'package:flutter/material.dart';
import 'package:oloid2/page/settings_page.dart';

import 'package:oloid2/widget/widgets.dart' as widgets;
import 'package:oloid2/page/pages.dart' as page;

void main() {
  runApp(MaterialApp(
    title: 'Oloid 2.0',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      cardTheme: const CardTheme(color: Color(0xff4c566a)),
      primaryColor: const Color(0xffff9f00),
      backgroundColor: const Color(0xff434c5e),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xff4c566a),
        unselectedItemColor: Color(0xffffffff),
        selectedItemColor: Color(0xffff9f00),
      ),
      textTheme: const TextTheme(
        button: TextStyle(color: Color(0xffffffff)),
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
  final pages = [
    page.TeachingUnits(
      teachingUnits: [],
      onRefresh: () async => {/*TODO*/},
    ),
    page.Agenda(
      events: [],
      onRefresh: () async => {/*TODO*/},
    ),
    page.Emails(),
    const SettingsPage(),
  ];
  int currentIndex = 0;

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
      bottomNavigationBar: widgets.BottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            if (index == currentIndex + 1 || index == currentIndex - 1) {
              pageController.animateToPage(
                index,
                curve: Curves.linear,
                duration: const Duration(milliseconds: 400),
              );
            } else if (currentIndex == index) {
              if (pages[currentIndex] is page.Emails) {
                (pages[currentIndex] as page.Emails).jumpToTop();
              } else if (pages[currentIndex] is page.Agenda) {
                (pages[currentIndex] as page.Agenda).jumpToTop();
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
