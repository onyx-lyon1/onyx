import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BottomNavBarSettings extends StatelessWidget {
  const BottomNavBarSettings({Key? key, required this.selected})
      : super(key: key);
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.settings_rounded,
        color: selected ? Theme.of(context).primaryColor : Colors.white,size: 30.sp,);
  }
}
