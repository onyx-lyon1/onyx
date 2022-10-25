import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/page/agenda_page.dart';
import 'package:oloid2/page/mails/emails_page.dart';
import 'package:oloid2/page/settings_page.dart';
import 'package:oloid2/page/teaching_units_page.dart';
import 'package:oloid2/states/agenda/agenda_bloc.dart';
import 'package:oloid2/widget/grades/bottom_nav_bar.dart';

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
      body: PageView(
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
              if (currentIndex == 1) {
                context
                    .read<AgendaBloc>()
                    .add(AgendaUpdateDisplayedDate(DateTime.now()));
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
