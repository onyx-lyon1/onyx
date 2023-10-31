import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda_config/agenda_config_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DirWidget extends StatelessWidget {
  const DirWidget(
      {super.key, required this.dir, required this.scrollController});

  final DirModel dir;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    if (dir.children == null) {
      if (dir.name.isEmpty) {
        return const SizedBox.shrink();
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: context
                    .read<AgendaConfigCubit>()
                    .state
                    .choosedIds
                    .contains(dir.identifier)
                ? Theme.of(context).primaryColor.withOpacity(0.3)
                : null,
            child: ListTile(
              title: Text(Uri.decodeFull(Uri.encodeFull(
                      dir.name.split(".").last.replaceAll("\\x", "%"))
                  .replaceAll("%25", "%"))),
              leading: const Icon(Icons.calendar_today_rounded),
              onTap: () {
                context
                    .read<AgendaConfigCubit>()
                    .toggleChooseDir(dir, collapse: false);
              },
            ),
          )
        ],
      );
    } else {
      return SizedBox(
        height: 100.h - Res.bottomNavBarHeight,
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          controller: scrollController,
          children: [
            for (var i in dir.children!)
              if (i.name.isNotEmpty)
                Material(
                  color: context
                          .read<AgendaConfigCubit>()
                          .state
                          .choosedIds
                          .contains(i.identifier)
                      ? Theme.of(context).primaryColor.withOpacity(0.3)
                      : null,
                  child: InkWell(
                    onTap: () =>
                        context.read<AgendaConfigCubit>().expandDir(i, dir),
                    onLongPress: () =>
                        context.read<AgendaConfigCubit>().toggleChooseDir(i),
                    child: ListTile(
                      key: key,
                      title: Text(Uri.decodeFull(Uri.encodeFull(
                              i.name.split(".").last.replaceAll("\\x", "%"))
                          .replaceAll("%25", "%"))),
                      leading: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () => context
                              .read<AgendaConfigCubit>()
                              .toggleChooseDir(i),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: BlocBuilder<AgendaConfigCubit,
                                AgendaConfigState>(
                              buildWhen: (previous, current) => !listEquals(
                                  previous.choosedIds, current.choosedIds),
                              builder: (context, state) {
                                if (state.choosedIds.contains(i.identifier)) {
                                  return const Icon(Icons.check_box);
                                }
                                return const Icon(Icons.folder);
                              },
                            ),
                          )),
                    ),
                  ),
                ),
          ],
        ),
      );
    }
  }
}
