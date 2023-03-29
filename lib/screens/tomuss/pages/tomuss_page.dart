import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/widgets/common_screen_widget.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:sizer/sizer.dart';

import '../../../core/widgets/states_displaying/state_displaying_widget_export.dart';

class TomussPage extends StatefulWidget {
  const TomussPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TomussPage> createState() => _TomussPageState();
}

class _TomussPageState extends State<TomussPage> {
  void showAllGrades(BuildContext context, SchoolSubjectModel schoolSubject) {
    showMaterialModalBottomSheet(
      context: context,
      expand: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Theme.of(context).colorScheme.background,
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          controller: ModalScrollController.of(context),
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                GradeListHeaderWidget(name: schoolSubject.name),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: GradeListWidget(
                    grades: schoolSubject.grades,
                    depth: 1,
                    lastElement: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TomussCubit, TomussState>(
      builder: (context, state) {
        if (kDebugMode) {
          print("Grades state : ${state.status}");
        }
        Widget? loadingHeader;
        if (state.status == TomussStatus.loading ||
            state.status == TomussStatus.cacheReady) {
          loadingHeader = LoadingHeaderWidget(
            message: "Chargement des notes",
            timeout: state.timeout,
            timeoutCallBack: () => context.read<TomussCubit>().load(
                dartus: context.read<AuthentificationCubit>().state.dartus,
                semestreIndex: state.currentSemesterIndex,
                cache: false),
          );
        }
        if (state.status == TomussStatus.initial) {
          context.read<TomussCubit>().load(
                dartus: context.read<AuthentificationCubit>().state.dartus,
              );
          loadingHeader = const LoadingHeaderWidget(
            message: "Connection à tomuss",
          );
        } else if (state.status == TomussStatus.error) {
          Future.delayed(const Duration(seconds: 3), () {
            context
                .read<AuthentificationCubit>()
                .login(
                    keepLogedIn: context
                        .read<SettingsCubit>()
                        .state
                        .settings
                        .keepMeLoggedIn)
                .then(
                  (value) => context.read<TomussCubit>().load(
                        dartus:
                            context.read<AuthentificationCubit>().state.dartus!,
                      ),
                );
          });
          loadingHeader = const LoadingHeaderWidget(
            message: "Erreur pendant le chargement des notes",
          );
        }

        List<GradeModel> newGrades = [];
        for (var teachingUnit in state.teachingUnits.where(
          (element) =>
              element.isHidden == false ||
              context.read<SettingsCubit>().state.settings.showHiddenUE,
        )) {
          for (var grade in teachingUnit.grades) {
            if ((grade.date != null) &&
                grade.date!.isAfter(
                    DateTime.now().subtract(const Duration(days: 7)))) {
              newGrades.add(grade);
            }
          }
        }
        newGrades.sort((a, b) => b.date!.compareTo(a.date!));
        return CommonScreenWidget(
          state: loadingHeader,
          header: Container(
            height: Res.bottomNavBarHeight,
            color: Theme.of(context).cardTheme.color,
            child: Stack(
              children: [
                ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...newGrades.map(
                      (grade) => Container(
                        width: Res.bottomNavBarItemWidth,
                        height: Res.bottomNavBarHeight,
                        padding: EdgeInsets.all(0.8.w),
                        child: GradeWidget(
                          grades: [grade],
                          text1: grade.name,
                          text2: state.teachingUnits
                              .firstWhere(
                                  (element) => element.grades.contains(grade))
                              .name,
                          depth: 0,
                          compact: true,
                          onTap: () => showAllGrades(
                            context,
                            state.teachingUnits.firstWhere(
                                (element) => element.grades.contains(grade)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //button to toggle semester with an icon
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.list,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                      onPressed: () {
                        //show a dialog to select the semester
                        showDialog(
                          context: context,
                          builder: (context) => const SemestreChooserWidget(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: state.teachingUnits
                .where(
                  (element) =>
                      element.isHidden == false ||
                      context.read<SettingsCubit>().state.settings.showHiddenUE,
                )
                .map(
                  (schoolSubject) => Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    child: GradeWidget(
                      grades: schoolSubject.grades,
                      isSeen: schoolSubject.isSeen,
                      text2:
                          schoolSubject.masters.map((e) => e.name).join(", "),
                      text1: schoolSubject.name,
                      onTap: () => showAllGrades(context, schoolSubject),
                      depth: 0,
                    ),
                  ),
                )
                .toList(),
          ),
          onRefresh: () async {
            context.read<TomussCubit>().load(
                  dartus: context.read<AuthentificationCubit>().state.dartus!,
                );
            while (context.read<TomussCubit>().state.status !=
                    TomussStatus.ready &&
                context.read<TomussCubit>().state.status !=
                    TomussStatus.error) {
              await Future.delayed(const Duration(milliseconds: 100));
            }
            return;
          },
        );
      },
    );
  }
}
