import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IzlyRechargeTranferPage extends StatelessWidget {
  const IzlyRechargeTranferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Hero(
      tag: "izly_recharge_transfer",
      child: SafeArea(
        child: Material(
          child: CommonScreenWidget(
            header: const IzlyRechargeHeaderWidget(
                title: "Recharger par un virement"),
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
                      child: const Text("Transferer"),
                    ),
                  ],
                ),
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
          builder: (context) =>
              const ErrorDialogWidget(message: "Veuillez saisir un montant"));
    } else if (double.parse(controller.text) < 5) {
      showDialog(
          context: context,
          builder: (context) => const ErrorDialogWidget(
              message: "Le montant doit être supérieur à 5€"));
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
        WebViewController controller = WebViewController();
        controller.loadRequest(request.url);
        controller.setJavaScriptMode(JavaScriptMode.unrestricted);
        controller.setNavigationDelegate(NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) async {
            if (request.url.contains("PaymentInitiationConfirmation")) {
              Navigator.pop(context);
            }
            return NavigationDecision.navigate;
          },
        ),);
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
          context.read<IzlyCubit>().connect();
          Navigator.pop(context);
        });
      });
    }
  }
}
