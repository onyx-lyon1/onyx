import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/examen/states/examen_cubit.dart';
import 'package:onyx/screens/login/states/authentification_cubit.dart';
import 'package:onyx/screens/settings/states/settings_cubit.dart';
import 'package:onyx/screens/tomuss/states/tomuss_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TomussConnection extends BlocListener<TomussCubit, TomussState> {
  TomussConnection({
    super.key,
  }) : super(
          listener: (context, state) {
            if (TomussStatus.ready == state.status) {
              context.read<ExamenCubit>().load(
                    context.read<TomussCubit>().state.name,
                    context.read<TomussCubit>().state.surname,
                    context.read<AuthentificationCubit>().state.username,
                    context.read<SettingsCubit>().state.settings,
                    context.read<AuthentificationCubit>().state.lyon1Cas,
                    AppLocalizations.of(context),
                  );
            }
          },
        );
}
