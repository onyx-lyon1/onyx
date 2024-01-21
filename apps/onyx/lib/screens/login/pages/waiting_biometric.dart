import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WaitingBiometric extends StatelessWidget {
  const WaitingBiometric({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(flex: 5),
            Flexible(
              flex: 5,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(flex: 10, child: Image.asset(Res.iconPath)),
                  const Spacer(
                    flex: 1,
                  ),
                  Flexible(
                    flex: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.onyx,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                fontSize: 20.sp,
                              ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.onyxSubTitle,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(
              flex: 5,
            ),
            InkWell(
              onTap: () => SettingsLogic.logout(context),
              child: Container(
                width: 40.w,
                height: 20.w,
                padding: EdgeInsets.symmetric(vertical: 2.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.logout,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 17.sp,
                        ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                context.read<AuthentificationCubit>().login(
                      settings: context.read<SettingsCubit>().state.settings,
                      appLocalizations: AppLocalizations.of(context)!,
                    );
              },
              borderRadius: BorderRadius.circular(500),
              child: Container(
                width: 40.w,
                height: 30.w,
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Center(
                    child: Icon(
                  Icons.fingerprint_rounded,
                  size: 40.sp,
                )),
              ),
            ),
            const Spacer(flex: 5),
          ],
        ),
      ),
    );
  }
}
