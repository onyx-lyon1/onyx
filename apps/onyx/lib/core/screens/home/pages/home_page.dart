import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:onyx/core/extensions/functionalities_extension.dart';
import 'package:onyx/core/screens/home/home_export.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final enabledFunctionalities =
        context.read<SettingsCubit>().state.settings.enabledFunctionalities;
    final disabledFunctionalities =
        context.read<SettingsCubit>().state.settings.disabledFunctionalities;

    List<Destination> enabledDestinations = [];
    for (var i = 0; i < enabledFunctionalities.length; i++) {
      enabledDestinations.add(Destination(i, enabledFunctionalities[i].name,
          enabledFunctionalities[i].toIcon()));
    }

    List<Destination> disabledDestinations =
        []; // the destinations for the secondary navigation bar
    for (var i = enabledFunctionalities.length;
        i < disabledFunctionalities.length + enabledFunctionalities.length;
        i++) {
      disabledDestinations.add(Destination(
          i,
          disabledFunctionalities[i - enabledFunctionalities.length].name,
          disabledFunctionalities[i - enabledFunctionalities.length].toIcon()));
    }

    //if there is more than 5 enabled functionalities, move the last one to the secondary navigation bar
    while (enabledDestinations.length > 4) {
      disabledDestinations.insert(
          0, enabledDestinations.removeLast()); //remove the last element
    }

    // add the more button
    enabledDestinations.add(Destination(enabledFunctionalities.length,
        AppLocalizations.of(context).more, Icons.more_horiz_rounded));
    // add the edition button

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, homeState) {
        return BlocBuilder<AuthentificationCubit, AuthentificationState>(
          builder: (context, authState) {
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              resizeToAvoidBottomInset: false,
              body: Expanded(
                child: CommonScreenWidget(
                    onRefresh: () async {},
                    state: (context
                                .read<AuthentificationCubit>()
                                .state
                                .status ==
                            AuthentificationStatus.authentificating)
                        ? LoadingHeaderWidget(
                            message: AppLocalizations.of(context).casConnexion)
                        : null,
                    body: Stack(
                      children: [
                        SizedBox(
                          height: 100.h - 80,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // we delete the last element because it is the more button
                              ...enabledDestinations.getRange(
                                  0, enabledDestinations.length - 1),
                              ...disabledDestinations
                            ].map((page) {
                              final index = page.index;
                              final view = [
                                ...enabledFunctionalities,
                                ...disabledFunctionalities
                              ][index]
                                  .toPage();
                              if (index ==
                                  (homeState.disabledSelectedIndex ??
                                      homeState.enabledSelectedIndex)) {
                                return Offstage(offstage: false, child: view);
                              } else {
                                return Offstage(child: view);
                              }
                            }).toList(),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: BottomNavBarWidget(
                            disabledDestinations: disabledDestinations,
                            enabledDestinations: enabledDestinations,
                          ),
                        )
                      ],
                    )),
              ),
            );
          },
        );
      },
    );
  }
}
