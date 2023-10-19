import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TextSwitchWidget extends StatelessWidget {
  final String text;
  final Function(bool b) onChanged;
  final bool value;

  const TextSwitchWidget({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => onChanged(!value),
          child: SizedBox(
            width: 60.w,
            child: Text(
              text,
              softWrap: true,
              overflow: TextOverflow.visible,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 12,
              ),
            ),
          ),
        ),
        Switch(
          activeColor: Theme.of(context).primaryColor,
          value: value,
          onChanged: (bool b) => onChanged(b),
        ),
      ],
    );
  }
}
