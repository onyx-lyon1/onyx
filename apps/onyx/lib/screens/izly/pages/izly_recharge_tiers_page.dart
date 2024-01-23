import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IzlyRechargeTiersPage extends StatelessWidget {
  const IzlyRechargeTiersPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController messageController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: CommonScreenWidget(
          header: IzlyRechargeHeaderWidget(
              title: AppLocalizations.of(context).thirdParty),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IzlyRechargeAmountWidget(
                    min: 10,
                    controller: controller,
                    onSaved: () => _pay(context, controller, emailController,
                        messageController),
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(
                    width: 80.w,
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context).mail,
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(
                    width: 80.w,
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context).message,
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  MaterialButton(
                    onPressed: () => _pay(context, controller, emailController,
                        messageController),
                    color: Theme.of(context).primaryColor,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      AppLocalizations.of(context).transfer,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodySmall!.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _pay(
    BuildContext context,
    TextEditingController controller,
    TextEditingController mailController,
    TextEditingController messageController) {
  if (controller.text.isEmpty || double.tryParse(controller.text) == null) {
    showDialog(
        context: context,
        builder: (context) => ErrorDialogWidget(
            message: AppLocalizations.of(context).pleaseSelectAnAmount));
  } else if (double.parse(controller.text) < 10) {
    showDialog(
        context: context,
        builder: (context) => ErrorDialogWidget(
            message: AppLocalizations.of(context).minimumAmountIs(10)));
  } else if (!(RegExp(
          r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(mailController.text))) {
    showDialog(
        context: context,
        builder: (context) => ErrorDialogWidget(
            message: AppLocalizations.of(context).pleaseEnterAValidEmail));
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IzlyWorkingPage(
          callback: () async => await IzlyLogic.rechargeViaSomeoneElse(
              context.read<IzlyCubit>().state.izlyClient!,
              double.parse(controller.text),
              mailController.text,
              messageController.text),
        ),
      ),
    ).then((value) {
      context
          .read<IzlyCubit>()
          .connect(settings: context.read<SettingsCubit>().state.settings);
      Navigator.pop(context);
    });
  }
}
