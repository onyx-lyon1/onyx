import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/screens/agenda/states/agenda_cubit.dart';
import 'package:onyx/screens/examen/states/examen_cubit.dart';
import 'package:onyx/screens/login/states/authentification_cubit.dart';
import 'package:onyx/screens/mails/states/email_cubit.dart';
import 'package:onyx/screens/settings/domain/model/settings_model.dart';
import 'package:onyx/screens/settings/states/settings_cubit.dart';
import 'package:onyx/screens/tomuss/states/tomuss_cubit.dart';

class AuthentificationConnection
    extends BlocListener<AuthentificationCubit, AuthentificationState> {
  AuthentificationConnection({
    super.key,
  }) : super(
          listener: (context, authState) {
            if (authState.status == AuthentificationStatus.authentificated) {
              CacheService.getEncryptionKey(context
                      .read<SettingsCubit>()
                      .state
                      .settings
                      .biometricAuth)
                  .then((key) => CacheService.get<Credential>(secureKey: key)
                      .then((value) => context.read<EmailCubit>().connect(
                          username: value!.username,
                          password: value.password)));
              if (context.read<SettingsCubit>().state.settings.firstLogin) {
                context.read<SettingsCubit>().modify(
                    settings: context
                        .read<SettingsCubit>()
                        .state
                        .settings
                        .copyWith(firstLogin: false));
              }
              if (AgendaStatus.ready !=
                  context.read<AgendaCubit>().state.status) {
                context.read<AgendaCubit>().load(
                    lyon1Cas: authState.lyon1Cas,
                    settings: context.read<SettingsCubit>().state.settings);
              }
              if (TomussStatus.ready !=
                  context.read<TomussCubit>().state.status) {
                context.read<TomussCubit>().load(
                      lyon1Cas: authState.lyon1Cas,
                      settings: context.read<SettingsCubit>().state.settings,
                      force: true,
                    );
              }
              if (ExamenStatus.ready !=
                  context.read<ExamenCubit>().state.status) {
                context.read<ExamenCubit>().load(
                      context.read<TomussCubit>().state.name,
                      context.read<TomussCubit>().state.surname,
                      context.read<AuthentificationCubit>().state.username,
                      context.read<SettingsCubit>().state.settings,
                      context.read<AuthentificationCubit>().state.lyon1Cas,
                    );
              }
            }
          },
        );
}
