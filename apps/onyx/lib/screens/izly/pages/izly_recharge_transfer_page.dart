import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/l10n/app_localizations.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IzlyRechargeTranferPage extends StatelessWidget {
  const IzlyRechargeTranferPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return SafeArea(
      child: Material(
        child: CommonScreenWidget(
          header: IzlyRechargeHeaderWidget(
              title: AppLocalizations.of(context).refillWithBankTransfer),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IzlyRechargeAmountWidget(
                    min: 5,
                    controller: controller,
                    onSaved: () => _pay(context, controller),
                  ),
                  SizedBox(height: 5.h),
                  MaterialButton(
                    onPressed: () => _pay(context, controller),
                    color: Theme.of(context).primaryColor,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      AppLocalizations.of(context).transfer,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodySmall?.color,
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

  void _pay(BuildContext context, TextEditingController controller) async {
    if (controller.text.isEmpty || double.tryParse(controller.text) == null) {
      showDialog(
          context: context,
          builder: (context) => ErrorDialogWidget(
              message: AppLocalizations.of(context).pleaseSelectAnAmount));
    } else if (double.parse(controller.text) < 5) {
      showDialog(
          context: context,
          builder: (context) => ErrorDialogWidget(
              message: AppLocalizations.of(context).minimumAmountIs(5)));
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IzlyWorkingPage(callback: () async {
            return await IzlyLogic.getTransferUrl(
                context.read<IzlyCubit>().state.izlyClient!,
                double.parse(controller.text));
          }),
        ),
      ).then((request) {
        bool poped = false;
        WebViewController controller = WebViewController();
        controller.loadRequest(Uri.parse(request.url));
        controller.setJavaScriptMode(JavaScriptMode.unrestricted);
        controller.setNavigationDelegate(
          NavigationDelegate(
            onNavigationRequest: (NavigationRequest request) async {
              if (request.url.contains("PaymentInitiationConfirmation") &&
                  !poped) {
                Navigator.pop(context);
                poped = true;
              }
              return NavigationDecision.navigate;
            },
          ),
        );

        if (!context.mounted) return;
        final izlyCubit = context.read<IzlyCubit>();
        final settings = context.read<SettingsCubit>().state.settings;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SafeArea(
              child: WebViewWidget(
                controller: controller,
              ),
            ),
          ),
        ).then((value) {
          izlyCubit.connect(settings: settings);
          if (!context.mounted) return;
          Navigator.pop(context);
        });
      });
    }
  }
}
