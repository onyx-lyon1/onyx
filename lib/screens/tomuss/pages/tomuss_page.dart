import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:oloid2/core/res.dart';
import 'package:oloid2/core/widgets/common_screen_widget.dart';
import 'package:oloid2/screens/login/login_export.dart';
import 'package:oloid2/screens/settings/settings_export.dart';
import 'package:oloid2/screens/tomuss/tomuss_export.dart';
import 'package:sizer/sizer.dart';

import '../../../core/widgets/states_displaying/state_displaying_widget_export.dart';

class TomussPage extends StatelessWidget {
  const TomussPage({
    Key? key,
  }) : super(key: key);

  void showAllGrades(BuildContext context, SchoolSubjectModel schoolSubject) {
    showMaterialModalBottomSheet(
      context: context,
      expand: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Theme.of(context).backgroundColor,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
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
                  depth: 0,
                  lastElement: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TomussCubit, TomussState>(
      builder: (context, state) {
        Widget? loadingHeader;
        if (state.status == TomussStatus.loading ||
            state.status == TomussStatus.cacheReady) {
          loadingHeader = const LoadingHeaderWidget(
            message: "Chargement des notes",
          );
        }
        if (kDebugMode) {
          print("Grades state : ${state.status}");
        }
        if (state.status == TomussStatus.initial) {
          context
              .read<TomussCubit>()
              .load(dartus: context.read<AuthentificationCubit>().state.dartus);
          loadingHeader = const LoadingHeaderWidget(
            message: "Connection à tomuss",
          );
        } else if (state.status == TomussStatus.error) {
          Future.delayed(const Duration(seconds: 3), () {
            context.read<TomussCubit>().load(
                dartus: context.read<AuthentificationCubit>().state.dartus!);
          });
          loadingHeader = const LoadingHeaderWidget(
            message: "Erreur pendant le chargement des notes",
          );
        }
        return CommonScreenWidget(
          state: loadingHeader,
          header: Container(
            height: Res.bottomNavBarHeight,
            color: Theme.of(context).cardTheme.color,
            child: Center(
              child: Text(
                'Notes',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          body: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              ...state.teachingUnits.where(
                    (element) =>
                        element.isHidden == false ||
                        context
                            .read<SettingsCubit>()
                            .state
                            .settings
                            .showHiddenUE,
                  )
                  .map(
                    (schoolSubject) => Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.w, vertical: 1.h),
                      child: GradeWidget(
                        grades: schoolSubject.grades,
                        isSeen: schoolSubject.isSeen,
                        text2: "${schoolSubject.mastersShort()} • grp ?",
                        text1: schoolSubject.name,
                        onTap: () => showAllGrades(context, schoolSubject),
                        depth: 0,
                      ),
                    ),
                  )
            ],
          ),
          onRefresh: () async {
            context.read<TomussCubit>().load(
                dartus: context.read<AuthentificationCubit>().state.dartus!);
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
