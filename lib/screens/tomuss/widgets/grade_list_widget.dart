import 'package:flutter/material.dart';
import 'package:oloid2/screens/tomuss/tomuss_export.dart';
import 'package:sizer/sizer.dart';

class GradeListWidget extends StatelessWidget {
  const GradeListWidget({Key? key, required this.grades, required this.depth})
      : super(key: key);
  final List<GradeModel> grades;
  final int depth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          List.generate(grades.length, (index) => index).map((gradeIndex) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (depth == 0)
              Container(
                height: 2.h,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                treeBuilder(context, depth, gradeIndex == grades.length - 1),
                Expanded(
                  child: SizedBox(
                    height: 11.h,
                    child: GradeWidget(
                      grades: [grades[gradeIndex]],
                      isSeen: true,
                      text1: grades[gradeIndex].name,
                      text2:
                          "moyenne: ${grades[gradeIndex].average.toStringAsFixed(2)} · mediane: ${grades[gradeIndex].mediane.toStringAsFixed(2)}\nclassement:${grades[gradeIndex].rank + 1}/${grades[gradeIndex].groupSize}\nprofesseur: ${grades[gradeIndex].author}",
                      depth: depth,
                    ),
                  ),
                ),
              ],
            ),
            if (grades[gradeIndex].children.isNotEmpty)
              GradeListWidget(
                grades: grades[gradeIndex].children,
                depth: depth + 1,
              ),
          ],
        );
      }).toList(),
    );
  }

  Widget treeBuilder(BuildContext context, int depth, bool lastElement) {
    if (depth == 0) {
      return Container();
    }
    return Padding(
      padding: EdgeInsets.only(left: 12.5.w * depth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 1.w,
                height: ((lastElement) ? (15.h / 2) + (0.5.h / 2) : 15.h),
                color: Theme.of(context).primaryColor,
              ),
              Container(
                width: 1.w,
                height: ((lastElement) ? (15.h / 2) - (0.5.h / 2) : 0),
                color: Theme.of(context).backgroundColor,
              ),
            ],
          ),
          Container(
            width: 12.5.w - 1.w,
            height: 0.5.h,
            color: Theme.of(context).primaryColor,
          ),
          for (var i = 0; i < depth - 1; i++)
            Container(
              width: 10.w,
              height: 2.h,
              color: Theme.of(context).primaryColor,
            ),
        ],
      ),
    );
  }
}
