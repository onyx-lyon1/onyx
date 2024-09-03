import 'package:flutter/material.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda_config/agenda_config_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DirListWidget extends StatelessWidget {
  const DirListWidget(
      {super.key, required this.dir, required this.scrollController});

  final AgendaResource dir;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    if (dir.children == null) {
      if (dir.name.isEmpty) {
        return const SizedBox.shrink();
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [DirWidget(dir: dir)],
      );
    } else {
      dir.children!.sort((a, b) => a.name.compareTo(b.name));
      return SizedBox(
        height: 100.h - Res.bottomNavBarHeight,
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          controller: scrollController,
          children: [
            for (var i in dir.children!)
              if (i.name.isNotEmpty) DirWidget(dir: i, parent: dir),
          ],
        ),
      );
    }
  }
}
