import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:oloid2/model/teaching_unit.dart';
import 'package:oloid2/states/authentification/authentification_cubit.dart';
import 'package:oloid2/states/grades/grades2_cubit.dart';
import 'package:oloid2/states/settings/settings_bloc.dart';
import 'package:oloid2/widget/grades/grade_list_header.dart';
import 'package:oloid2/widget/grades/teaching_unit.dart';
import 'package:oloid2/widget/loading_snakbar.dart';
import 'package:oloid2/widget/state_displaying.dart';
import 'package:sizer/sizer.dart';

import '../widget/grades/grade.dart';

class TeachingUnitsPage extends StatelessWidget {
  const TeachingUnitsPage({
    Key? key,
  }) : super(key: key);

  void showAllGrades(BuildContext context, TeachingUnitModel tu) {
    showMaterialModalBottomSheet(
      context: context,
      expand: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Theme.of(context).backgroundColor,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: SafeArea(
          bottom: false,
          child: Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                GradeListHeader(
                  tu: tu,
                ),
                ...tu.grades.map(
                  (e) => Grade(
                    gradeModel: e,
                    forceGreen:
                        context.read<SettingsBloc>().state.settings.forceGreen,
                    onTap: (e) {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GradesCubit, GradesState>(
      listener: (context, state) {
        if (state.status == GradesStatus.loading) {
          ScaffoldMessenger.of(context).showSnackBar(loadingSnackbar(
              message: "Chargement des notes",
              context: context,
              shouldDisable: context
                  .read<GradesCubit>()
                  .stream
                  .map<bool>((event) => event.status != GradesStatus.ready)));
        }
      },
      child: BlocBuilder<GradesCubit, GradesState>(
        builder: (context, state) {
          if (kDebugMode) {
            print("Grades state : $state");
          }
          if (state.status == GradesStatus.initial) {
            context
                .read<GradesCubit>()
                .load(dartus: context.read<AuthentificationCubit>().state.dartus!);
            return const StateDisplaying(message: "Loading grades");
          } else if (state.status == GradesStatus.error) {
            Future.delayed(const Duration(seconds: 3), () {
              context.read<GradesCubit>().load(dartus: context.read<AuthentificationCubit>().state.dartus!);
            });
            return const StateDisplaying(
                message: "Erreur pendant le chargement des notes");
          }
          return SafeArea(
            child: Container(
                color: Theme.of(context).backgroundColor,
                child: RefreshIndicator(
                    color: Theme.of(context).primaryColor,
                    backgroundColor: Theme.of(context).backgroundColor,
                    child: Column(
                      children: [
                        Container(
                          height: 10.h,
                          color: Theme.of(context).cardTheme.color,
                          child: Center(
                            child: Text(
                              'Notes',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              ...state
                                  .teachingUnits
                                  .where(
                                    (element) =>
                                        element.isHidden == false ||
                                        context
                                            .read<SettingsBloc>()
                                            .state
                                            .settings
                                            .showHiddenUE,
                                  )
                                  .map(
                                    (e) => TeachingUnit(
                                      tu: e,
                                      forceGreen: context
                                          .read<SettingsBloc>()
                                          .state
                                          .settings
                                          .forceGreen,
                                      onClick: (TeachingUnitModel tu) {
                                        if (kDebugMode) {
                                          print(
                                              'Tapped on teaching unit ${tu.name}');
                                        }
                                        showAllGrades(context, tu);
                                      },
                                    ),
                                  )
                            ],
                          ),
                        ),
                      ],
                    ),
                    onRefresh: () async {
                      context.read<GradesCubit>().load(dartus:
                          context.read<AuthentificationCubit>().state.dartus!);
                      while (context.read<GradesCubit>().state.status != GradesStatus.ready &&
                          context.read<GradesCubit>().state.status != GradesStatus.error) {
                        await Future.delayed(const Duration(milliseconds: 100));
                      }
                      return;
                    })),
          );
        },
      ),
    );
  }
}
