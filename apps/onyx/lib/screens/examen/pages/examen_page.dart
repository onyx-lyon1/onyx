import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1examenclient/lyon1examenclient.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/examen/examen_export.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/settings/states/settings_cubit.dart';
import 'package:onyx/screens/tomuss/states/tomuss_cubit.dart';
import 'package:polytechcolloscopeclient/polytechcolloscopeclient.dart';

class ExamenPage extends StatelessWidget {
  const ExamenPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamenCubit, ExamenState>(
      builder: (context, state) {
        Widget body = const SizedBox.shrink();
        Widget? stateWidget;

        switch (state.status) {
          case ExamenStatus.initial:
            break;
          case ExamenStatus.loading:
            stateWidget = const LoadingHeaderWidget(
              message: "Accès au Examens",
            );
            body = buildExamen(context);
            break;
          case ExamenStatus.ready:
            body = buildExamen(context);
            break;
          case ExamenStatus.error:
            stateWidget = const LoadingHeaderWidget(
              message: "Erreur lors du chargement de examens",
            );
            body = buildExamen(context);
            break;
        }

        return CommonScreenWidget(
          onRefresh: () async {
            context.read<ExamenCubit>().load(
                  context.read<TomussCubit>().state.name,
                  context.read<TomussCubit>().state.surname,
                  context.read<AuthentificationCubit>().state.username,
                  context.read<SettingsCubit>().state.settings,
                  context.read<AuthentificationCubit>().state.lyon1Cas,
                );
          },
          state: stateWidget,
          header: Center(
            child: Text(
              'Colloscope',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: body,
        );
      },
    );
  }

  Widget buildExamen(BuildContext context) {
    StudentColloscope? colloscope =
        context.watch<ExamenCubit>().state.studentColloscope;
    List<ExamenModel> examens = context.watch<ExamenCubit>().state.examens;
    List<dynamic> all = [...colloscope?.kholles ?? [], ...examens];
    all.sort((a, b) => a.date.compareTo(b.date));
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListView(children: [
        for (var e in all)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: (e is Kholle)
                ? KholleWidget(kholle: e)
                : ExamenWidget(examen: e),
          )
      ]),
    );
  }
}
