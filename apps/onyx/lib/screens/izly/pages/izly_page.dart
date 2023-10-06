import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class IzlyPage extends StatelessWidget {
  const IzlyPage({
    Key? key,
  }) : super(key: key);

  static double indexToOffset(int index) {
    return (15.w) * (index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IzlyCubit, IzlyState>(
      builder: (context, state) {
        if (kDebugMode) {
          print("IzlyPage: status: ${state.status}");
        }
        Widget? stateWidget;
        Widget body = Container();
        switch (state.status) {
          case IzlyStatus.initial:
            context.read<IzlyCubit>().connect(
                settings: context.read<SettingsCubit>().state.settings);
            body = const StateDisplayingPage(
              message: "Connexion en cours",
            );
            break;
          case IzlyStatus.connecting:
            body = const StateDisplayingPage(
              message: "Connexion en cours",
            );
            break;
          case IzlyStatus.error:
            Future.delayed(const Duration(seconds: 5), () {
              context.read<IzlyCubit>().connect(
                  settings: context.read<SettingsCubit>().state.settings);
            });
            stateWidget =
                const StateDisplayingPage(message: "Il y a eu une erreur");
            break;
          case IzlyStatus.noCredentials:
            return const IzlyLoginPage();
          case IzlyStatus.loading:
            stateWidget = const LoadingHeaderWidget(message: "Chargement...");
            break;
          case IzlyStatus.connected:
            break;
          case IzlyStatus.loaded:
            break;
          case IzlyStatus.cacheLoaded:
            break;
        }
        if (state.status != IzlyStatus.initial) {
          PageController pageController = PageController();
          body = PageView(
            controller: pageController,
            scrollDirection: Axis.vertical,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "${state.qrCodeAvailables} disponible${(state.qrCodeAvailables > 1) ? "s" : ""} hors ligne"),
                      SizedBox(
                        height: 60.w,
                        width: 60.w,
                        child: Card(
                          color: Colors.white,
                          elevation: 10,
                          clipBehavior: Clip.hardEdge,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.memory(state.qrCode!,
                              scale: 0.6, semanticLabel: "QR Code"),
                        ),
                      ),
                      Text(
                        "${state.balance.toStringAsFixed(2)}€",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    child: IconButton(
                      onPressed: () => pageController.animateToPage(1,
                          duration: Res.animationDuration,
                          curve: Curves.easeInOut),
                      icon: Icon(Icons.keyboard_double_arrow_down_rounded,
                          size: 40.sp,
                          color: Theme.of(context)
                              .bottomNavigationBarTheme
                              .unselectedItemColor),
                    ),
                  ),
                ],
              ),
              IzlyRechargePage(pageController: pageController),
            ],
          );
        }
        return CommonScreenWidget(
          state: stateWidget,
          onRefresh: () async {
            context.read<IzlyCubit>().connect(
                settings: context.read<SettingsCubit>().state.settings);
            while (state.status != IzlyStatus.loaded &&
                state.status != IzlyStatus.error) {
              await Future.delayed(const Duration(milliseconds: 100));
            }
            return;
          },
          header: Center(
            child: Text(
              'Izly',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: body,
        );
      },
    );
  }
}
