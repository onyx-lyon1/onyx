import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:onyx/screens/tomuss/widgets/teaching_unit_children_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
          child: Column(
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
            color: Theme.of(context).cardTheme.color,
            padding: EdgeInsets.all(
                (Device.orientation == Orientation.portrait) ? 1.w : 1.h),
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
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: MaterialLocalizations.of(context)
                            .modalBarrierDismissLabel,
                        pageBuilder: (ctx, a1, a2) {
                          return Container();
                        },
                        transitionBuilder: (ctx, a1, a2, child) {
                          var curve = Curves.easeInOut.transform(a1.value);
                          return Transform.translate(
                            offset: Offset(
                                50.w - 50.w * curve, -(45.h - 45.h * curve)),
                            child: Transform.scale(
                              scale: curve,
                              child: const SemesterChooserWidget(),
                            ),
                          );
                        },
                        transitionDuration: Duration(
                            milliseconds:
                                (Res.animationDuration.inMilliseconds / 2)
                                    .round()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          body: ResponsiveGridView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10.0),
            childAspectRatio: 3 / 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            maxCrossAxisExtent: (!Res.isWide) ? 70.w : 70.h,
            children: [
              for (var teachingUnit in state.teachingUnits)
                GradeWidget(
                  grades: teachingUnit.grades,
                  text2: teachingUnit.masters.map((e) => e.name).join(", "),
                  text1: teachingUnit.title.replaceAll("_", " "),
                  onTap: () => showAllGrades(context, teachingUnit),
                  depth: 0,
                ),
            ],
          ),
          onRefresh: () async {
            context.read<TomussCubit>().load(
                  lyon1Cas:
                      context.read<AuthentificationCubit>().state.lyon1Cas,
                  settings: context.read<SettingsCubit>().state.settings,
                  force: true,
                );
            // ignore: use_build_context_synchronously
            while (context.read<TomussCubit>().state.status !=
                    TomussStatus.ready &&
                // ignore: use_build_context_synchronously
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
