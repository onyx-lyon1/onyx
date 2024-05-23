import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/screens/home/home_export.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({
    super.key,
    required this.enabledDestinations,
    required this.disabledDestinations,
  });

  final List<Destination> enabledDestinations;
  final List<Destination> disabledDestinations;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AnimatedOpacity(
              duration: Res.animationDuration,
              curve: Curves.easeInOut,
              opacity: state.showSecondaryScreens ? 1 : 0,
              child: AnimatedPadding(
                duration: Res.animationDuration,
                curve: Curves.easeInOut,
                //80 is the default height of the navigation bar
                padding: EdgeInsets.only(
                    bottom: state.showSecondaryScreens ? 67 : 0),
                child: Container(
                  height: 80,
                  color: Theme.of(context).colorScheme.surface,
                  child: NavigationBar(
                    selectedIndex: ((state.disabledSelectedIndex ?? 0) -
                            enabledDestinations.length +
                            1)
                        .clamp(0, disabledDestinations.length - 1),
                    height: 80,
                    indicatorColor: (state.disabledSelectedIndex == null)
                        ? Colors.transparent
                        : Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5),
                    onDestinationSelected: (int index) {
                      context.read<HomeCubit>().updateSelectedIndex(
                          enabledDestinations.length - 1 + index, true);
                    },
                    destinations: disabledDestinations
                        .map((page) => NavigationDestination(
                            icon: Icon(
                              page.icon,
                              color: (state.disabledSelectedIndex == null)
                                  ? Theme.of(context).iconTheme.color
                                  : null,
                            ),
                            label: page.title))
                        .toList(),
                  ),
                ),
              ),
            ),
            NavigationBar(
              selectedIndex: (state.enabledSelectedIndex ?? 0)
                  .clamp(0, enabledDestinations.length - 2),
              indicatorColor: (state.enabledSelectedIndex == null)
                  ? Colors.transparent
                  : Theme.of(context).colorScheme.primary.withOpacity(0.5),
              onDestinationSelected: (int index) {
                Res.logger.e(enabledDestinations.length - 1);
                Res.logger.e(index);
                if (index == enabledDestinations.length - 1) {
                  context.read<HomeCubit>().toggleSecondaryScreens();
                } else {
                  context.read<HomeCubit>().updateSelectedIndex(index, false);
                }
              },
              destinations: enabledDestinations
                  .map((page) => NavigationDestination(
                        icon: Icon(
                          page.icon,
                          color: (state.enabledSelectedIndex == null)
                              ? Theme.of(context).iconTheme.color
                              : null,
                        ),
                        label: page.title,
                      ))
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
