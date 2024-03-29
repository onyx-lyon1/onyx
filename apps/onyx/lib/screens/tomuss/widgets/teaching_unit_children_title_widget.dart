import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TeachingUnitChildrenTitleWidget extends StatelessWidget {
  final String name;

  const TeachingUnitChildrenTitleWidget({
    super.key,
    required this.name,
  });

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
                Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.3),
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
