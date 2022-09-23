import 'package:flutter/material.dart';
import 'package:oloid2/model/teaching_unit.dart';
import 'package:sizer/sizer.dart';

class GradeListHeader extends StatelessWidget {
  final TeachingUnitModel tu;

  const GradeListHeader({
    Key? key,
    required this.tu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 3,
          width: 12.w,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color:
                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.3),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Text(
          tu.name,
          textAlign: TextAlign.center,
          style: const TextStyle(),
        ),
      ],
    );
  }
}
