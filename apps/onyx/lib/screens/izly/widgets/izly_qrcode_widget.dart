import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/izly/states/izly_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:screen_brightness/screen_brightness.dart';

class IzlyQrcodeWidget extends StatelessWidget {
  const IzlyQrcodeWidget({super.key});

  Color calculateWarningColor(BuildContext context) {
    if (context
        .read<IzlyCubit>()
        .state
        .paymentList
        .isEmpty) {
      if (context
          .read<IzlyCubit>()
          .state
          .izlyClient != null &&
          context
              .read<IzlyCubit>()
              .state
              .status == IzlyStatus.loaded) {
        context.read<IzlyCubit>().loadPaymentHistory();
      }
      return Colors.transparent;
    }

    double average = 0.0;
    for (var i in context
        .read<IzlyCubit>()
        .state
        .paymentList) {
      if (i.amountSpent < 0) {
        average += -i.amountSpent;
      }
    }
    average /= context
        .read<IzlyCubit>()
        .state
        .paymentList
        .length;

    final green = 5 * average; //5 times the average should display green
    final red = 2 * average; //2 times the average should display red
    //do a linear interpolation between green and red
    double interpolation =
        (context
            .read<IzlyCubit>()
            .state
            .balance - red) / (green - red);
    return HSVColor.fromAHSV(1, (120 * interpolation).clamp(0, 120), 1, 1)
        .toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.5.w,
      // 60 + the padding 6 lines below
      width: 60.5.w,
      // 60 + the padding 5 lines below
      decoration: BoxDecoration(
        color: calculateWarningColor(context),
        borderRadius: BorderRadius.circular(15 + 2.w),
      ),
      padding: EdgeInsets.all(0.5.w),
      child: BlocConsumer<IzlyCubit, IzlyState>(
        listener: (context, state) async {
          if (Platform.isAndroid || Platform.isIOS) {
            if (state.showQrCode) {
              await ScreenBrightness.instance
                  .setApplicationScreenBrightness(1.0);
            } else {
              await ScreenBrightness.instance
                  .resetApplicationScreenBrightness();
            }
          }
        },
        builder: (context, state) {
          return Card(
            elevation: 10,
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Image.memory(
                  state.qrCode!,
                  scale: 0.6,
                  fit: BoxFit.cover,
                ),
                AnimatedOpacity(
                  duration: Res.animationDuration,
                  opacity: state.showQrCode ? 0 : 1,
                  curve: Curves.easeInOut,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(color: Colors.black.withOpacity(0.4)),
                  ),
                ),
                AnimatedOpacity(
                  duration: Res.animationDuration,
                  opacity: state.showQrCode ? 0 : 1,
                  curve: Curves.easeInOut,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.remove_red_eye_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          AppLocalizations
                              .of(context)
                              .unHideQrCode,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        context.read<IzlyCubit>().toggleShowQrCode();
                      },
                      splashColor: Colors.white
                          .withOpacity(0.3), // Customize splash color
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
