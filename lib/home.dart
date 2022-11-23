import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/screens/agenda/pages/agenda_page.dart';
import 'package:oloid2/screens/mails/pages/emails_page.dart';
import 'package:oloid2/screens/settings/pages/settings_page.dart';
import 'package:oloid2/screens/tomuss/pages/tomuss_page.dart';
import 'package:oloid2/screens/agenda/states/agenda_cubit.dart';
import 'package:oloid2/core/widgets/bottom_nav_bar_widget.dart';

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
          children: const [
            TomussPage(),
            AgendaPage(),
            EmailsPage(),
            SettingsPage(),
          ]),
      bottomNavigationBar: BottomNavBarWidget(
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
                    .read<AgendaCubit>()
                    .updateDisplayedDate(date: DateTime.now());
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
