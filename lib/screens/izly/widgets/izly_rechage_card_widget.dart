import 'package:flutter/material.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:sizer/sizer.dart';

class IzlayRechargeCardWidget extends StatelessWidget {
  const IzlayRechargeCardWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onTap,
      required this.tag})
      : super(key: key);
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return CustomHeroWidget(
      tag: tag,
      beginColor: Theme.of(context).primaryColor,
      endColor: Theme.of(context).backgroundColor,
      child: Material(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 30.w,
            height: 30.w,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon),
                Text(
                  text,
                  textAlign: TextAlign.center,
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
