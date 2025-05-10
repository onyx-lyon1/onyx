import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:onyx/l10n/app_localizations.dart';
import 'package:onyx/screens/agenda/states/agenda_cubit.dart';
import 'package:onyx/screens/examen/states/examen_cubit.dart';
import 'package:onyx/screens/settings/states/settings_cubit.dart';

class ExamensConnection extends BlocListener<ExamenCubit, ExamenState> {
  ExamensConnection({
    super.key,
  }) : super(
          listener: (context, state) {
            if (state.status == ExamenStatus.ready &&
                context.read<SettingsCubit>().settings.examenAddToAgenda) {
              context.read<AgendaCubit>().clearExternalEvent();
              context.read<AgendaCubit>().addExternalEvent([
                ...state.studentColloscope?.kholles.map(
                      (e) => Event(
                          name:
                              AppLocalizations.of(context).kholleOf(e.kholleur),
                          teacher: e.kholleur,
                          location: e.room?.trim() ?? "",
                          start: e.date,
                          end: e.date.add(const Duration(hours: 1)),
                          description: e.message ?? ""),
                    ) ??
                    [],
                ...state.examens
                    .map(
                      (e) {
                        if (e.date != null && e.duration != null) {
                          return Event(
                              name: AppLocalizations.of(context)
                                  .examOf(e.codeName),
                              teacher: "",
                              location: AppLocalizations.of(context)
                                  .examLocationPlace(
                                      e.location ?? "", e.place ?? -1),
                              start: e.date!,
                              end: e.date!.add(e.duration!),
                              description: e.codeName);
                        }
                        return null;
                      },
                      //clean null values
                    )
                    .toList()
                    .whereType<Event>()
              ]);
            }
          },
        );
}
