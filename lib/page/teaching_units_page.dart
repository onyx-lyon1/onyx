import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:oloid2/model/teaching_unit.dart';
import 'package:oloid2/states/authentification/authentification_bloc.dart';
import 'package:oloid2/states/grades/grades_bloc.dart';
import 'package:oloid2/states/settings/settings_bloc.dart';
import 'package:oloid2/widget/grades/grade_list_header.dart';
import 'package:oloid2/widget/grades/teaching_unit.dart';
import 'package:oloid2/widget/state_displaying.dart';

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
                        context.read<SettingsBloc>().settings.forceGreen,
                    onTap: (e) {
                      if (kDebugMode) {
                        print('Tapped on grade ${e.name}');
                      }
                    },
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
    return BlocProvider(
      create: (context) => GradesBloc(),
      child: BlocBuilder<GradesBloc, GradesState>(
        builder: (context, state) {
          if (state is GradesInitial) {
            context
                .read<GradesBloc>()
                .add(GradesLoad(context.read<AuthentificationBloc>().dartus));
            return const StateDisplaying(message: "Loading grades");
          }
          return Container(
              color: Theme.of(context).backgroundColor,
              child: RefreshIndicator(
                color: Theme.of(context).primaryColor,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    ...context
                        .read<GradesBloc>()
                        .teachingUnits
                        .where(
                          (element) =>
                              element.isHidden == false ||
                              context
                                  .read<SettingsBloc>()
                                  .settings
                                  .showHiddenUE,
                        )
                        .map(
                          (e) => TeachingUnit(
                            tu: e,
                            forceGreen: context
                                .read<SettingsBloc>()
                                .settings
                                .forceGreen,
                            onClick: (TeachingUnitModel tu) {
                              if (kDebugMode) {
                                print('Tapped on teaching unit ${tu.name}');
                              }
                              showAllGrades(context, tu);
                            },
                          ),
                        )
                  ],
                ),
                onRefresh: () async => context.read<GradesBloc>().add(
                    GradesLoad(context.read<AuthentificationBloc>().dartus)),
              ));
        },
      ),
    );
  }
}
