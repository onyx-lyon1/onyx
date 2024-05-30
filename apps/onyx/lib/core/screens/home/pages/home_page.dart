import 'package:flutter/foundation.dart';
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
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, homeState) {
        return BlocBuilder<AuthentificationCubit, AuthentificationState>(
          builder: (context, authState) {
            return BlocBuilder<SettingsCubit, SettingsState>(
              buildWhen: (previous, current) {
                if (!listEquals(previous.settings.enabledFunctionalities,
                        current.settings.enabledFunctionalities) ||
                    !listEquals(previous.settings.disabledFunctionalities,
                        current.settings.disabledFunctionalities)) {
                  //the page order has changer so we need to adapt the current page to avoir jump

                  final previousIndex = homeState.selectedIndex;
                  final functionalityName = [
                    ...previous.settings.enabledFunctionalities,
                  ][previousIndex]
                      .name;
                  final newEnabledIndex =
                      current.settings.enabledFunctionalities.indexWhere(
                          (element) => element.name == functionalityName);
                  if (newEnabledIndex != -1) {
                    context
                        .read<HomeCubit>()
                        .updateSelectedIndex(newEnabledIndex);
                  }
                  return true;
                }
                return false;
              },
              builder: (context, settingState) {
                final enabledFunctionalities =
                    settingState.settings.enabledFunctionalities;

                List<Destination> enabledDestinations = [];
                for (var i = 0; i < enabledFunctionalities.length; i++) {
                  enabledDestinations.add(Destination(
                      i,
                      enabledFunctionalities[i].name,
                      enabledFunctionalities[i].toIcon()));
                }

                // add the more button
                if (enabledDestinations.length > 4) {
                  enabledDestinations.insert(
                      3,
                      Destination(
                          enabledFunctionalities.length,
                          AppLocalizations.of(context).more,
                          Icons.more_horiz_rounded));
                }
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
                                message:
                                    AppLocalizations.of(context).casConnexion)
                            : null,
                        body: Stack(
                          children: [
                            SizedBox(
                              height: 100.h - 80,
                              child: Stack(
                                fit: StackFit.expand,
                                children: enabledDestinations
                                    .map((page) {
                                      var index = page.index;
                                      if (index >=
                                          enabledFunctionalities.length) {
                                        return null;
                                      }
                                      final view = enabledFunctionalities[index]
                                          .toPage();
                                      //Using offstage to avoid the hidden pages to rebuild
                                      if (index == homeState.selectedIndex) {
                                        return Offstage(
                                            offstage: false, child: view);
                                      } else {
                                        return Offstage(child: view);
                                      }
                                    })
                                    .whereType<
                                        Widget>() //little hack to drop null values
                                    .toList(),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: BottomNavBarWidget(
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
      },
    );
  }
}
