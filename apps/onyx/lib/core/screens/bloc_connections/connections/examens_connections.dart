import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:onyx/screens/agenda/states/agenda_cubit.dart';
import 'package:onyx/screens/colloscope/colloscope_export.dart';

class ExamensConnection extends BlocListener<ColloscopeCubit, ColloscopeState> {
  ExamensConnection({
    super.key,
  }) : super(
          listener: (context, state) {
            if (state.status == ColloscopeStatus.ready) {
              context.read<AgendaCubit>().resetCubit();
              context
                  .read<AgendaCubit>()
                  .addExternalEvent(state.studentColloscope!.kholles
                      .map(
                        (e) => Event(
                            name: "Kholle de ${e.subject}",
                            teacher: e.kholleur,
                            location: e.room ?? "",
                            start: e.date,
                            end: e.date.add(const Duration(hours: 1)),
                            description: e.message ?? ""),
                      )
                      .toList());
            }
          },
        );
}
