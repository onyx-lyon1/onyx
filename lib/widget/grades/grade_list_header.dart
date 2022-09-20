import 'package:flutter/material.dart';
import 'package:oloid2/model/teaching_unit.dart';

class GradeListHeader extends StatelessWidget {
  final TeachingUnitModel tu;
  const GradeListHeader({
    Key? key,
    required this.tu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 3,
          width: 50,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color:
                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.3),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Text(
          tu.name,
          textAlign: TextAlign.start,
          style: const TextStyle(),
        ),
      ],
    );
  }
}
