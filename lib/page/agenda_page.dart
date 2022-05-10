import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

class Agenda extends StatelessWidget {
  final DatePickerController dateController = DatePickerController();
  final PageController pageController = PageController();
  final List<Object> events;
  final Function() onRefresh;

  Agenda({
    Key? key,
    required this.events,
    required this.onRefresh,
  }) : super(key: key);

  void jumpToTop() {
    pageController.animateTo(
      0,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
    );
  }

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
              const SizedBox(
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
