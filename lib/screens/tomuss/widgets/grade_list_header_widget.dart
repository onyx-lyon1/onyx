import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class GradeListHeaderWidget extends StatelessWidget {
  final String name;

  const GradeListHeaderWidget({
    Key? key,
    required this.name,
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
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(),
        ),
      ],
    );
  }
}
