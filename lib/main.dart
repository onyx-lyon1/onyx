import 'dart:math';

// import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_bottomnavbar/widget/email.dart';
import 'package:test_bottomnavbar/widget/email_header.dart';
import 'package:test_bottomnavbar/widget/teaching_unit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Nav Bar Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColorLight: const Color(0xffe5e9f0),
        primaryColorDark: const Color(0xff1f1f1f),
        primarySwatch: const MaterialColor(0xff4c566a, {
          50: Color(0xff4c566a),
          100: Color(0xff4c566a),
          200: Color(0xff4c566a),
          300: Color(0xff4c566a),
          400: Color(0xff4c566a),
          500: Color(0xff4c566a),
          600: Color(0xff4c566a),
          700: Color(0xff4c566a),
          800: Color(0xff4c566a),
          900: Color(0xff4c566a),
        }),
      ),
      home: const Home(),
    );
  }
}

class Grades extends StatelessWidget {
  const Grades({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xff4c566a),
        child: RefreshIndicator(
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              TeachingUnit.empty(),
              TeachingUnit.empty(),
              TeachingUnit.empty(),
              TeachingUnit.empty(),
              TeachingUnit.empty(),
              TeachingUnit.empty(),
              TeachingUnit.empty(),
              TeachingUnit.empty(),
              TeachingUnit.empty(),
              TeachingUnit.empty(),
              TeachingUnit.empty(),
            ],
          ),
          onRefresh: () async {},
        ));
  }
}

class Agenda extends StatelessWidget {
  Agenda({Key? key}) : super(key: key);

  final DatePickerController dateController = DatePickerController();
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xff4c566a),
        child: RefreshIndicator(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //     // CalendarTimeline(
              //     //   initialDate: DateTime.now(),
              //     //   firstDate: DateTime.now(),
              //     //   lastDate: DateTime.now().add(const Duration(days: 180)),
              //     //   onDateSelected: (date) {
              //     //     print("Selected date: $date");
              //     //   },
              //     //   monthColor: Colors.white70,
              //     //   dayColor: Colors.teal[200],
              //     //   dayNameColor: const Color(0xFF333A47),
              //     //   activeDayColor: Colors.white,
              //     //   activeBackgroundDayColor: Colors.redAccent[100],
              //     //   dotsColor: const Color(0xFF333A47),
              //     //   selectableDayPredicate: (date) => date.day != 23,
              //     //   locale: 'fr',
              //     // ),
              SizedBox(
                height: 30,
              ),
              DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                daysCount: 180,
                controller: dateController,
                locale: 'fr_FR',
                selectionColor: const Color(0xffd08770),
                selectedTextColor: const Color(0xffe5e9f0),
                monthTextStyle:
                    const TextStyle(color: Color(0xffe5e9f0), fontSize: 9),
                dayTextStyle:
                    const TextStyle(color: Color(0xffe5e9f0), fontSize: 9),
                dateTextStyle:
                    const TextStyle(color: Color(0xffd8dee9), fontSize: 14),
                onDateChange: (date) {
                  final int pageIndex =
                      (date.difference(DateTime.now()).inHours / 24 + 1)
                          .round();
                  pageController.jumpToPage(pageIndex);
                },
              ),
              // Text('hello'),
              Expanded(
                child: PageView(
                  controller: pageController,
                  scrollDirection: Axis.vertical,
                  onPageChanged: (index) {
                    // dateController.animateToDate(
                    //     DateTime.now().add(Duration(days: index)));
                  },
                  children: const [
                    Center(child: Text("Agenda 1")),
                    Center(child: Text("Agenda 2")),
                    Center(child: Text("Agenda 3")),
                  ],
                ),
              )
            ],
          ),
          onRefresh: () async {},
        ));
  }
}

class Emails extends StatelessWidget {
  const Emails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xff4c566a),
        child: RefreshIndicator(
          child: ListView.custom(
            childrenDelegate: SliverChildBuilderDelegate((context, index) {
              if (index == 0) {
                return EmailHeader();
              } else if (index < 150) {
                return Email(
                  subject: "Le sujet du mail",
                  sender: "hello@mail.com",
                  excerpt:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  isRead: Random().nextBool(),
                  date: DateTime.now()
                      .add(Duration(hours: -(Random().nextInt(15)))),
                );
              }
            }),
          ),

          // ListView(
          //   children: [
          //     Email(
          //       subject: "Le sujet du mail",
          //       sender: "hello@mail.com",
          //       excerpt:
          //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          //       isRead: false,
          //       date: DateTime.now().add(Duration(hours: -2)),
          //     ),
          //     Email(
          //       subject: "Le sujet du mail",
          //       sender: "jane@mail.com",
          //       excerpt:
          //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          //       isRead: false,
          //       date: DateTime.now().add(Duration(days: -3)),
          //     ),
          //     Email(
          //       subject: "Le sujet du mail",
          //       sender: "john@mail.com",
          //       excerpt:
          //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          //       isRead: true,
          //       date: DateTime.now().add(Duration(days: -3)),
          //     ),
          //     Email(
          //       subject: "Le sujet du mail",
          //       sender: "bob@mail.com",
          //       excerpt:
          //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          //       isRead: true,
          //       date: DateTime.now().add(Duration(days: -4)),
          //     ),
          //     Email.empty(),
          //     Email.empty(),
          //     Email.empty(),
          //     Email.empty(),
          //     Email.empty(),
          //   ],
          // ),
          onRefresh: () async {},
        ));
  }
}

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xff4c566a),
        child: const Center(child: Text("Settings")));
  }
}

class HomeController {
  final _selectedIndex = 0;

  final _pages = [
    const Grades(),
    Agenda(),
    const Emails(),
    const Settings(),
  ];

  int get index => _selectedIndex;

  Widget get currentPage => _pages[_selectedIndex.value];
  void setPage(int index) {
    _selectedIndex.value = index;
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static const int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return Scaffold(
          backgroundColor: const Color(0xff4c566a),
          body: PageView(
              children: [...controller._pages],
              controller: pageController,
              pageSnapping: true,
              physics: const RangeMaintainingScrollPhysics(),
              onPageChanged: (index) => {
                    if (index != controller._selectedIndex.value)
                      controller.setPage(index),
                  }),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color(0xff3b4252),
            selectedFontSize: 12,
            unselectedFontSize: 12,
            enableFeedback: false,
            currentIndex: controller.index,
            unselectedItemColor: const Color(0xffe5e9f0),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: const Color(0xffd08770),
            onTap: (index) {
              HomeController.to.setPage(index);
              pageController.jumpToPage(index);
            },
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.class__rounded), label: "Notes"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_rounded), label: "Agenda"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.email_rounded), label: "Emails"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Paramètres"),
            ],
          ),
        );
      },
    );
  }
}
