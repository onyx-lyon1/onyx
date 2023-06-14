import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:sizer/sizer.dart';

class SemesterChooserWidget extends StatelessWidget {
  const SemesterChooserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardTheme.color,
      title: Text(
        "Sélectionner un semestre",
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge!.color,
          fontSize: 15.sp,
        ),
      ),
      content: SizedBox(
        height: ((context.read<TomussCubit>().state.semesters.length < 3)
            ? 12.5.h
            : 30.h),
        width: 20.h,
        child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 20.w,
              crossAxisSpacing: 3.w,
              mainAxisSpacing: 3.w,
            ),
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
                            dartus: context
                                .read<AuthentificationCubit>()
                                .state
                                .dartus!,
                            semestreIndex: context
                                .read<TomussCubit>()
                                .state
                                .semesters
                                .indexOf(semester),
                            settings:
                                context.read<SettingsCubit>().state.settings,
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
                              fontSize: 15.sp,
                            ),
                          ),
                          Text(
                            semester.title.split("/")[1],
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                              fontSize: 15.sp,
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
