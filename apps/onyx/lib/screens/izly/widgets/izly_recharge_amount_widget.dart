import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class IzlyRechargeAmountWidget extends StatelessWidget {
  const IzlyRechargeAmountWidget(
      {super.key,
      required this.min,
      required this.controller,
      required this.onSaved});
  final double min;
  final TextEditingController controller;
  final VoidCallback onSaved;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70.w,
      height: 70.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 20.w,
            height: 20.w,
            child: Center(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                onSubmitted: (value) {
                  controller.text = value;
                  onSaved();
                },
                decoration: const InputDecoration(
                  hintText: "€",
                  border: InputBorder.none,
                ),
                style: TextStyle(
                    fontSize: 15.sp,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
              ),
            ),
          ),
          IzlyRechargeAmountExampleValuesWidget(
            left: 0,
            controller: controller,
            value: min,
          ),
          IzlyRechargeAmountExampleValuesWidget(
            top: (70.w / 4) - (17.w / 2),
            left: (70.w / 4) - (17.w / 2),
            controller: controller,
            value: min + (5 * 1),
          ),
          IzlyRechargeAmountExampleValuesWidget(
            top: 0,
            left: (70.w / 2) - (17.w / 2),
            controller: controller,
            value: min + (5 * 2),
          ),
          IzlyRechargeAmountExampleValuesWidget(
            top: (70.w / 4) - (17.w / 2),
            right: (70.w / 4) - (17.w / 2),
            controller: controller,
            value: min + (5 * 3),
          ),
          IzlyRechargeAmountExampleValuesWidget(
            right: 0,
            controller: controller,
            value: min + (5 * 4),
          ),
          IzlyRechargeAmountExampleValuesWidget(
            bottom: (70.w / 4) - (17.w / 2),
            right: (70.w / 4) - (17.w / 2),
            controller: controller,
            value: min + (5 * 5),
          ),
          IzlyRechargeAmountExampleValuesWidget(
            bottom: 0,
            left: (70.w / 2) - (17.w / 2),
            controller: controller,
            value: min + (5 * 6),
          ),
          IzlyRechargeAmountExampleValuesWidget(
            bottom: (70.w / 4) - (17.w / 2),
            left: (70.w / 4) - (17.w / 2),
            controller: controller,
            value: min + (5 * 7),
          ),
        ],
      ),
    );
  }
}

class IzlyRechargeAmountExampleValuesWidget extends StatelessWidget {
  const IzlyRechargeAmountExampleValuesWidget(
      {super.key,
      this.top,
      this.left,
      this.right,
      this.bottom,
      required this.controller,
      required this.value});
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final TextEditingController controller;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: Material(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(100),
        child: InkWell(
          onTap: () {
            controller.text = value.toString();
          },
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
            width: 17.w,
            height: 17.w,
            child: Center(
              child: Text(
                value.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Theme.of(context).textTheme.bodySmall!.color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
