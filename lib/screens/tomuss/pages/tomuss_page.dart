import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:oloid2/core/widgets/states_displaying/loading_snakbar_widget.dart';
import 'package:oloid2/core/widgets/states_displaying/state_displayer_page.dart';
import 'package:oloid2/screens/tomuss/domain/model/school_subject_model.dart';
import 'package:oloid2/screens/login/states/authentification_cubit.dart';
import 'package:oloid2/screens/tomuss/states/tomuss_cubit.dart';
import 'package:oloid2/screens/settings/states/settings_cubit.dart';
import 'package:oloid2/screens/tomuss/widgets/grade_list_header_widget.dart';
import 'package:oloid2/screens/tomuss/widgets/grade_widget.dart';
import 'package:sizer/sizer.dart';

class TomussPage extends StatelessWidget {
  const TomussPage({
    Key? key,
  }) : super(key: key);

  void showAllGrades(BuildContext context, SchoolSubjectModel tu) {
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
                GradeListHeaderWidget(
                  tu: tu,
                ),
                ...tu.grades.map(
                  (grades) => GradeWidget(
                    model: grades,
                    forceGreen:
                        context.read<SettingsCubit>().state.settings.forceGreen,
                    isSeen: true,
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
    return BlocListener<TomussCubit, TomussState>(
      listener: (context, state) {
        if (state.status == TomussStatus.loading) {
          ScaffoldMessenger.of(context).showSnackBar(loadingSnackbar(
              message: "Chargement des notes",
              context: context,
              shouldDisable: context
                  .read<TomussCubit>()
                  .stream
                  .map<bool>((event) => event.status != TomussStatus.ready)));
        }
      },
      child: BlocBuilder<TomussCubit, TomussState>(
        builder: (context, state) {
          if (kDebugMode) {
            print("Grades state : $state");
          }
          if (state.status == TomussStatus.initial) {
            context
                .read<TomussCubit>()
                .load(dartus: context.read<AuthentificationCubit>().state.dartus!);
            return const StateDisplayingPage(message: "Loading grades");
          } else if (state.status == TomussStatus.error) {
            Future.delayed(const Duration(seconds: 3), () {
              context.read<TomussCubit>().load(dartus: context.read<AuthentificationCubit>().state.dartus!);
            });
            return const StateDisplayingPage(
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
                                            .read<SettingsCubit>()
                                            .state
                                            .settings
                                            .showHiddenUE,
                                  )
                                  .map(
                                    (e) => GradeWidget(
                                      model: e,
                                      forceGreen: context
                                          .read<SettingsCubit>()
                                          .state
                                          .settings
                                          .forceGreen,
                                      isSeen: e.isSeen,
                                      onTap: (tu) {
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
                      context.read<TomussCubit>().load(dartus:
                          context.read<AuthentificationCubit>().state.dartus!);
                      while (context.read<TomussCubit>().state.status != TomussStatus.ready &&
                          context.read<TomussCubit>().state.status != TomussStatus.error) {
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
