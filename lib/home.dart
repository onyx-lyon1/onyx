import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/core/widgets/core_widget_export.dart';
import 'package:oloid2/screens/agenda/agenda_export.dart';
import 'package:oloid2/screens/login/login_export.dart';
import 'package:oloid2/screens/mails/mails_export.dart';
import 'package:oloid2/screens/settings/settings_export.dart';
import 'package:oloid2/screens/tomuss/tomuss_export.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  final PageController pageController = PageController();
  late int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthentificationCubit, AuthentificationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: CommonScreenWidget(
            onRefresh: () async {
              if (kDebugMode) {
                print('refresh in home');
              }
              return;
            },
            state: (state.status == AuthentificationStatus.authentificating)
                ? const LoadingHeaderWidget(
                    message: "Connection à cas",
                  )
                : null,
            body: PageView(
                controller: pageController,
                pageSnapping: true,
                physics: const RangeMaintainingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    if (index != currentIndex) currentIndex = index;
                  });
                },
                children: const [
                  TomussPage(),
                  AgendaPage(),
                  EmailsPage(),
                  SettingsPage(),
                ]),
          ),
          bottomNavigationBar: BottomNavBarWidget(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                if (index == currentIndex + 1 || index == currentIndex - 1) {
                  pageController.animateToPage(
                    index,
                    curve: Curves.linear,
                    duration: const Duration(milliseconds: 300),
                  );
                } else if (currentIndex == index) {
                  if (currentIndex == 1) {
                    context.read<AgendaCubit>().updateDisplayedDate(
                        date: DateTime.now(), fromPageController: false);
                  }
                } else {
                  pageController.jumpToPage(index);
                }
                currentIndex = index;
              });
            },
          ),
        );
      },
    );
  }
}
