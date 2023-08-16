import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda_config/agenda_config_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DirWidget extends StatelessWidget {
  const DirWidget({Key? key, required this.dir, required this.scrollController})
      : super(key: key);
  final DirModel dir;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    if (dir.children.isEmpty) {
      if (dir.name.isEmpty) {
        return const SizedBox.shrink();
      }
      return ListTile(
        title: Text(Uri.decodeFull(
            Uri.encodeFull(dir.name.split(".").last.replaceAll("\\x", "%"))
                .replaceAll("%25", "%"))),
        leading: const Icon(Icons.calendar_today_rounded),
        onTap: () {
          context.read<AgendaConfigCubit>().chooseDir(dir.id);
        },
      );
    } else {
      return GestureDetector(
        onLongPress: () {
          context.read<AgendaConfigCubit>().chooseDir(dir.id);
        },
        child: SizedBox(
          height: 100.h - Res.bottomNavBarHeight,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            controller: scrollController,
            children: [
              for (var i in dir.children)
                if (i.name.isNotEmpty)
                  ListTile(
                    key: key,
                    title: Text(Uri.decodeFull(Uri.encodeFull(
                            i.name.split(".").last.replaceAll("\\x", "%"))
                        .replaceAll("%25", "%"))),
                    leading: const Icon(Icons.folder),
                    onTap: () {
                      context.read<AgendaConfigCubit>().expandDir(i, dir);
                    },
                  ),
            ],
          ),
        ),
      );
    }
  }
}
