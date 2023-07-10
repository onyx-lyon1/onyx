import 'package:dartus/tomuss.dart';
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
import '../widgets/teaching_unit_children_widget.dart';

class TomussPage extends StatefulWidget {
  const TomussPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TomussPage> createState() => _TomussPageState();
}

class _TomussPageState extends State<TomussPage> {
  void showAllGrades(BuildContext context, TeachingUnit schoolSubject) {
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
                TeachingUnitChildrenTitleWidget(name: schoolSubject.title),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: TeachingUnitChildrenWidget(
                    teachingUnit: schoolSubject,
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
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (kDebugMode) {
          print("Grades state : ${state.status}");
        }
        Widget? loadingHeader;
        switch (state.status) {
          case TomussStatus.initial:
            context.read<TomussCubit>().load(
                  lyon1Cas:
                      context.read<AuthentificationCubit>().state.lyon1Cas,
                  settings: context.read<SettingsCubit>().state.settings,
                );
            loadingHeader = const LoadingHeaderWidget(
              message: "Connection à tomuss",
            );
            break;
          case TomussStatus.loading:
          case TomussStatus.cacheReady:
            loadingHeader = LoadingHeaderWidget(
              message: "Chargement des notes",
              timeout: state.timeout,
              timeoutCallBack: () {},
            );
            break;

          case TomussStatus.ready:
            break;
          case TomussStatus.error:
            Future.delayed(const Duration(seconds: 3), () {
              context.read<TomussCubit>().load(
                    lyon1Cas:
                        context.read<AuthentificationCubit>().state.lyon1Cas,
                    settings: context.read<SettingsCubit>().state.settings,
                  );
            });
            loadingHeader = const LoadingHeaderWidget(
              message: "Erreur pendant le chargement des notes",
            );
            break;
          case TomussStatus.updated:
            break;
          case TomussStatus.timeout:
            loadingHeader = LoadingHeaderWidget(
              message: "Chargement des notes",
              timeout: state.timeout,
              timeoutCallBack: () => context.read<TomussCubit>().load(
                    lyon1Cas:
                        context.read<AuthentificationCubit>().state.lyon1Cas,
                    semestreIndex: state.currentSemesterIndex,
                    cache: false,
                    settings: context.read<SettingsCubit>().state.settings,
                  ),
            );
            break;
        }
        return CommonScreenWidget(
          state: loadingHeader,
          header: Container(
            height: Res.bottomNavBarHeight,
            color: Theme.of(context).cardTheme.color,
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: HeaderChildren(
                      onTap: (TeachingUnit teachingUnit) =>
                          showAllGrades(context, teachingUnit)),
                ),
                //button to toggle semester with an icon
                Align(
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
                        builder: (context) => const SemesterChooserWidget(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          body: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: state.teachingUnits
                .map(
                  (schoolSubject) => Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    child: GradeWidget(
                      grades: schoolSubject.grades,
                      text2:
                          schoolSubject.masters.map((e) => e.name).join(", "),
                      text1: schoolSubject.title.replaceAll("_", " "),
                      onTap: () => showAllGrades(context, schoolSubject),
                      depth: 0,
                    ),
                  ),
                )
                .toList(),
          ),
          onRefresh: () async {
            context.read<TomussCubit>().load(
                  lyon1Cas:
                      context.read<AuthentificationCubit>().state.lyon1Cas,
                  settings: context.read<SettingsCubit>().state.settings,
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
