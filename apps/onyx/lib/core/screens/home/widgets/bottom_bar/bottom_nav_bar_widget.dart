import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/screens/home/home_export.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({
    super.key,
    required this.enabledDestinations,
  });

  final List<Destination> enabledDestinations;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            if (enabledDestinations.length > 4)
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
                      selectedIndex: (state.enabledSelectedIndex - 3)
                          .clamp(0, enabledDestinations.length - 5),
                      height: 80,
                      indicatorColor: (state.enabledSelectedIndex < 3)
                          ? Colors.transparent
                          : Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                      onDestinationSelected: (int index) {
                        context
                            .read<HomeCubit>()
                            .updateSelectedIndex(index + 3);
                      },
                      destinations: enabledDestinations
                          .sublist(4)
                          .map((page) => NavigationDestination(
                              icon: Icon(
                                page.icon,
                                color: (state.enabledSelectedIndex < 4)
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
              selectedIndex: state.enabledSelectedIndex.clamp(0, 3),
              indicatorColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.5),
              onDestinationSelected: (int index) {
                if (index ==
                        ((enabledDestinations.length < 4)
                            ? enabledDestinations.length - 1
                            : 3) &&
                    enabledDestinations.length > 4) {
                  context.read<HomeCubit>().toggleSecondaryScreens();
                } else {
                  context.read<HomeCubit>().updateSelectedIndex(index);
                }
              },
              destinations: enabledDestinations
                  .sublist(
                      0,
                      (enabledDestinations.length >= 5)
                          ? 4
                          : enabledDestinations.length)
                  .map((page) => NavigationDestination(
                        icon: Icon(
                          page.icon,
                          color: Theme.of(context).iconTheme.color,
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
