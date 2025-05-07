import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:onyx/screens/agenda_config/agenda_config_export.dart';

class DirWidget extends StatelessWidget {
  const DirWidget({super.key, required this.dir, this.parent});

  final AgendaResource? parent;
  final AgendaResource dir;

  @override
  Widget build(BuildContext context) {
    if (dir.children == null) {
      if (dir.name.isEmpty) {
        return const SizedBox.shrink();
      }
      return Container(
        color:
            context.read<AgendaConfigCubit>().state.choosedIds.contains(dir.id)
                ? Theme.of(context).primaryColor.withValues(alpha: 0.3)
                : null,
        child: ListTile(
          title: Text(Uri.decodeFull(
              Uri.encodeFull(dir.name.split(".").last.replaceAll("\\x", "%"))
                  .replaceAll("%25", "%"))),
          leading: const Icon(Icons.calendar_today_rounded),
          onTap: () {
            context
                .read<AgendaConfigCubit>()
                .toggleChooseDir(dir, collapse: false);
          },
        ),
      );
    } else {
      return Material(
        color:
            context.read<AgendaConfigCubit>().state.choosedIds.contains(dir.id)
                ? Theme.of(context).primaryColor.withValues(alpha: 0.3)
                : null,
        child: InkWell(
          onTap: () =>
              context.read<AgendaConfigCubit>().expandAgenda(dir, parent!),
          onLongPress: () =>
              context.read<AgendaConfigCubit>().toggleChooseDir(dir),
          child: ListTile(
            key: key,
            title: Text(Uri.decodeFull(
                Uri.encodeFull(dir.name.split(".").last.replaceAll("\\x", "%"))
                    .replaceAll("%25", "%"))),
            leading: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () =>
                    context.read<AgendaConfigCubit>().toggleChooseDir(dir),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: BlocBuilder<AgendaConfigCubit, AgendaConfigState>(
                    buildWhen: (previous, current) =>
                        !listEquals(previous.choosedIds, current.choosedIds),
                    builder: (context, state) {
                      if (state.choosedIds.contains(dir.id)) {
                        return const Icon(Icons.check_box);
                      }
                      return const Icon(Icons.folder);
                    },
                  ),
                )),
          ),
        ),
      );
    }
  }
}
