import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SemesterChooserWidget extends StatelessWidget {
  const SemesterChooserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardTheme.color,
      title: Text(
        AppLocalizations.of(context)!.selectSemester,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge!.color,
          fontSize: 20.sp,
        ),
      ),
      content: SizedBox(
        width: (!Res.isWide) ? 20.h : 25.h,
        child: GridView.extent(
            maxCrossAxisExtent: 25.h,
            mainAxisSpacing: (!Res.isWide) ? 3.w : 3.h,
            crossAxisSpacing: (!Res.isWide) ? 3.w : 3.h,
            childAspectRatio: 3 / 2,
            shrinkWrap: true,
            children: [
              for (var semester in context.read<TomussCubit>().state.semesters)
                Material(
                  color:
                      (context.read<TomussCubit>().state.currentSemesterIndex ==
                              context
                                  .read<TomussCubit>()
                                  .state
                                  .semesters
                                  .indexOf(semester))
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      context.read<TomussCubit>().load(
                            lyon1Cas: context
                                .read<AuthentificationCubit>()
                                .state
                                .lyon1Cas,
                            semestreIndex: context
                                .read<TomussCubit>()
                                .state
                                .semesters
                                .indexOf(semester),
                            settings:
                                context.read<SettingsCubit>().state.settings,
                            force: true,
                          );
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            semester.title.split("/")[0],
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                              fontSize: 18.sp,
                            ),
                          ),
                          Text(
                            semester.title.split("/")[1],
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ]),
      ),
    );
  }
}
