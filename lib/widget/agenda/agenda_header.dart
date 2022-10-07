// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:oloid2/others/month_to_string.dart';
// import 'package:oloid2/others/weekday_to_string.dart';
// import 'package:oloid2/states/agenda/agenda_bloc.dart';
// import 'package:sizer/sizer.dart';
//
// class AgendaHeader extends StatefulWidget {
//   const AgendaHeader(
//       {Key? key, required this.scrollController, required this.pageController})
//       : super(key: key);
//   final ScrollController scrollController;
//   final PageController pageController;
//
//   @override
//   State<AgendaHeader> createState() => _AgendaHeaderState();
//
//
// }
//
// class _AgendaHeaderState extends State<AgendaHeader> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(2.w),
//       child: Material(
//         borderRadius: BorderRadius.circular(10),
//         color: (AgendaHeader.offsetToIndex(
//             scrollController.offset) ==
//             compteur)
//             ? Theme.of(context).primaryColor
//             : Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(10),
//           onTap: () {
//             setState(() {
//               final int pageIndex = context
//                   .read<AgendaBloc>()
//                   .dayModels
//                   .indexWhere((element) =>
//               element.date.year ==
//                   currentDate.year &&
//                   element.date.month ==
//                       currentDate.month &&
//                   element.date.day ==
//                       currentDate.day);
//               pageController.animateToPage(
//                 pageIndex,
//                 curve: Curves.easeInOut,
//                 duration:
//                 const Duration(milliseconds: 500),
//               );
//
//               scrollController.animateTo(
//                   AgendaHeader.indexToOffset(compteur),
//                   duration:
//                   const Duration(milliseconds: 500),
//                   curve: Curves.easeInOut);
//             });
//           },
//           child: SizedBox(
//             height: 10.h,
//             width: 15.w,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(monthToString(currentDate.month,
//                     short: true)),
//                 Text(currentDate.day.toString()),
//                 Text(weekdayToString(currentDate.weekday,
//                     short: true)),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//
//   }
// }
