import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/colloscope/states/colloscope_cubit.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/settings/states/settings_cubit.dart';
import 'package:onyx/screens/tomuss/states/tomuss_cubit.dart';

import '../widgets/kholle_widget.dart';

class ColloscopePage extends StatelessWidget {
  const ColloscopePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String? name = context.read<TomussCubit>().state.name;
    String? surname = context.read<TomussCubit>().state.surname;

    String? username = context.read<AuthentificationCubit>().state.username;

    int yearOverride =
        context.read<SettingsCubit>().state.settings.colloscopeOverrideYearId;

    return BlocBuilder<ColloscopeCubit, ColloscopeState>(
      builder: (context, state) {
        Widget body;
        Widget? stateWidget;

        switch (state.status) {
          case ColloscopeStatus.initial:
            stateWidget = null;
            body = const SizedBox.shrink();
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              context
                  .read<ColloscopeCubit>()
                  .load(name, surname, username, yearOverride);
            });
          case ColloscopeStatus.loading:
            stateWidget = const LoadingHeaderWidget(
              message: "Chargement du colloscope",
            );
            body = const SizedBox.shrink();
            break;
          case ColloscopeStatus.error:
            stateWidget = const LoadingHeaderWidget(
              message: "Erreur lors du chargement du colloscope",
            );
            body = const SizedBox.shrink();
            break;
          case ColloscopeStatus.ready:
            stateWidget = null;
            body = Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView(
                children: [
                  for (var i in state.studentColloscope!.kholles)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: KholleWidget(kholle: i),
                    )
                ],
              ),
            );
            break;
        }

        return CommonScreenWidget(
          onRefresh: () async {
            context
                .read<ColloscopeCubit>()
                .load(name, surname, username, yearOverride);
            while (state.status != ColloscopeStatus.ready &&
                state.status != ColloscopeStatus.error) {
              await Future.delayed(const Duration(milliseconds: 100));
            }
            return;
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
}
