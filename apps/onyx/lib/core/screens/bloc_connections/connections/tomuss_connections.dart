import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/l10n/app_localizations.dart';
import 'package:onyx/screens/examen/states/examen_cubit.dart';
import 'package:onyx/screens/login/states/auth_cubit.dart';
import 'package:onyx/screens/settings/states/settings_cubit.dart';
import 'package:onyx/screens/tomuss/states/tomuss_cubit.dart';

class TomussConnection extends BlocListener<TomussCubit, TomussState> {
  TomussConnection({
    super.key,
  }) : super(
          listener: (context, state) {
            if (TomussStatus.ready == state.status) {
              context.read<ExamenCubit>().load(
                    context.read<TomussCubit>().state.name,
                    context.read<TomussCubit>().state.surname,
                    context.read<AuthCubit>().state.username,
                    context.read<SettingsCubit>().settings,
                    context.read<AuthCubit>().lyon1Cas,
                    AppLocalizations.of(context),
                  );
            }
          },
        );
}
