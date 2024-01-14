import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:onyx/screens/agenda/states/agenda_cubit.dart';
import 'package:onyx/screens/examen/states/examen_cubit.dart';
import 'package:onyx/screens/settings/states/settings_cubit.dart';

class ExamensConnection extends BlocListener<ExamenCubit, ExamenState> {
  ExamensConnection({
    super.key,
  }) : super(
          listener: (context, state) {
            if (state.status == ExamenStatus.ready &&
                context
                    .read<SettingsCubit>()
                    .state
                    .settings
                    .examenAddToAgenda) {
              context.read<AgendaCubit>().clearExternalEvent();
              context.read<AgendaCubit>().addExternalEvent([
                ...state.studentColloscope?.kholles.map(
                      (e) => Event(
                          name: "Kholle de ${e.subject}",
                          teacher: e.kholleur,
                          location: e.room ?? "",
                          start: e.date,
                          end: e.date.add(const Duration(hours: 1)),
                          description: e.message ?? ""),
                    ) ??
                    [],
                ...state.examens.map(
                  (e) => Event(
                      name: "Examen : ${e.title}",
                      teacher: "",
                      location: "${e.location}, place: ${e.place}",
                      start: e.date,
                      end: e.date.add(e.duration),
                      description: e.codeName),
                )
              ]);
            }
          },
        );
}
