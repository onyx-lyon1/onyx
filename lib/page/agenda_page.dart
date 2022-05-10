import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:oloid2/model/day.dart';

class Agenda extends StatelessWidget {
  final DatePickerController dateController = DatePickerController();
  final PageController pageController = PageController();
  final List<DayModel> events;
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
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.only(top: 27),
        child: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                color: Theme.of(context).cardTheme.color,
                child: DatePicker(
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
                    pageController.animateToPage(
                      pageIndex,
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 500),
                    );
                  },
                ),
              ),
              // Text('hello'),
              Expanded(
                child: PageView(
                  controller: pageController,
                  scrollDirection: Axis.vertical,
                  onPageChanged: (index) {
                    dateController.animateToDate(
                      DateTime.now().add(Duration(days: index)),
                    );
                  },
                  children: [
                    ...events.map((e) => const SizedBox(
                          height: 100,
                          child: Card(
                            child: Text('heyy'),
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
          onRefresh: () async {},
        ));
  }
}
