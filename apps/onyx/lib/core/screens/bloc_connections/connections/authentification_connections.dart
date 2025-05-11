import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/l10n/app_localizations.dart';
import 'package:onyx/screens/agenda/states/agenda_cubit.dart';
import 'package:onyx/screens/examen/states/examen_cubit.dart';
import 'package:onyx/screens/login/states/auth_cubit.dart';
import 'package:onyx/screens/mails/states/email_cubit.dart';
import 'package:onyx/screens/settings/domain/model/settings_model.dart';
import 'package:onyx/screens/settings/states/settings_cubit.dart';
import 'package:onyx/screens/tomuss/states/tomuss_cubit.dart';

class AuthentificationConnection extends BlocListener<AuthCubit, AuthState> {
  AuthentificationConnection({
    super.key,
  }) : super(
          listener: (context, authState) {
            if (authState.status == AuthentificationStatus.authentificated) {
              final emailCubit = context.read<EmailCubit>();
              final localization = AppLocalizations.of(context);
              final settings = context.read<SettingsCubit>().settings;

              CacheService.getEncryptionKey(settings.biometricAuth).then(
                (key) => CacheService.get<Credential>(secureKey: key).then(
                  (value) => emailCubit.connect(
                    username: value!.username,
                    password: value.password,
                    appLocalizations: localization,
                  ),
                ),
              );
              if (settings.firstLogin) {
                context
                    .read<SettingsCubit>()
                    .modify(settings: settings.copyWith(firstLogin: false));
              }
              if (AgendaStatus.ready !=
                  context.read<AgendaCubit>().state.status) {
                context.read<AgendaCubit>().load(
                    lyon1Cas: context.read<AuthCubit>().lyon1Cas,
                    settings: settings);
              }
              if (TomussStatus.ready !=
                  context.read<TomussCubit>().state.status) {
                context.read<TomussCubit>().load(
                      lyon1Cas: context.read<AuthCubit>().lyon1Cas,
                      settings: settings,
                      force: true,
                    );
              }
              if (ExamenStatus.ready !=
                  context.read<ExamenCubit>().state.status) {
                context.read<ExamenCubit>().load(
                      context.read<TomussCubit>().state.name,
                      context.read<TomussCubit>().state.surname,
                      context.read<AuthCubit>().state.username,
                      settings,
                      context.read<AuthCubit>().lyon1Cas,
                      AppLocalizations.of(context),
                    );
              }
              context.read<AgendaCubit>().agendaClient =
                  Lyon1AgendaClient.useLyon1Cas(
                      context.read<AuthCubit>().lyon1Cas);
              context.read<AgendaCubit>().login(settings);
            }
          },
        );
}
