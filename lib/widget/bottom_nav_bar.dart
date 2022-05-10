import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  /*
    HomeController.to.setPage(index);
    pageController.jumpToPage(index);
  */
  final Function(int index) onTap;
  final int currentIndex;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      enableFeedback: false,
      currentIndex: currentIndex,
      unselectedItemColor:
          Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor:
          Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
      onTap: (index) => onTap(index),
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
    );
  }
}
