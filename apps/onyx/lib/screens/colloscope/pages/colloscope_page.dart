import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/colloscope/states/colloscope_cubit.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/settings/states/settings_cubit.dart';
import 'package:onyx/screens/tomuss/states/tomuss_cubit.dart';
import 'package:polytechcolloscopeclient/polytechcolloscopeclient.dart';

import '../widgets/kholle_widget.dart';

class ColloscopePage extends StatelessWidget {
  const ColloscopePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColloscopeCubit, ColloscopeState>(
      builder: (context, state) {
        Widget body = const SizedBox.shrink();
        Widget? stateWidget;

        switch (state.status) {
          case ColloscopeStatus.initial:
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              context.read<ColloscopeCubit>().load(
                  context.read<TomussCubit>().state.name,
                  context.read<TomussCubit>().state.surname,
                  context.read<AuthentificationCubit>().state.username,
                  context.read<SettingsCubit>().state.settings);
            });
          case ColloscopeStatus.gatheringColloscopeData:
            stateWidget = const LoadingHeaderWidget(
              message: "Accès au colloscope",
            );
            body = buildColloscope(state.studentColloscope!);
            break;
          case ColloscopeStatus.ready:
            body = buildColloscope(state.studentColloscope!);
            break;
          case ColloscopeStatus.error:
            stateWidget = const LoadingHeaderWidget(
              message: "Erreur lors du chargement du colloscope",
            );
            body = buildColloscope(state.studentColloscope!);
            break;
        }

        return CommonScreenWidget(
          onRefresh: () async {
            context.read<ColloscopeCubit>().load(
                context.read<TomussCubit>().state.name,
                context.read<TomussCubit>().state.surname,
                context.read<AuthentificationCubit>().state.username,
                context.read<SettingsCubit>().state.settings);
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

  Widget buildColloscope(StudentColloscope colloscope) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListView(
        children: [
          for (var i in colloscope.kholles)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: KholleWidget(kholle: i),
            )
        ],
      ),
    );
  }
}
