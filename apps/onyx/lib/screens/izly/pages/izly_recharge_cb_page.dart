import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IzlyRechargeCBPage extends StatefulWidget {
  const IzlyRechargeCBPage({super.key});

  @override
  State<IzlyRechargeCBPage> createState() => _IzlyRechargeCBPageState();
}

class _IzlyRechargeCBPageState extends State<IzlyRechargeCBPage> {
  TextEditingController controller = TextEditingController();
  int dropDownValue = 0;
  List<CbModel> cbs = [];

  @override
  void initState() {
    asyncInit();
    super.initState();
  }

  void asyncInit() async {
    cbs = await IzlyLogic.getCb(context.read<IzlyCubit>().state.izlyClient!);
    setState(() {
      dropDownValue = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: CommonScreenWidget(
          header: const IzlyRechargeHeaderWidget(
              title: "Recharger par carte bancaire"),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IzlyRechargeAmountWidget(
                    min: 10,
                    controller: controller,
                    onSaved: () => _pay(context, controller),
                  ),
                  SizedBox(height: 5.h),
                  if (cbs.isNotEmpty)
                    DropdownButton(
                      dropdownColor: Theme.of(context).colorScheme.background,
                      value: dropDownValue,
                      items: [
                        for (var i = 0; i < cbs.length; i++)
                          DropdownMenuItem(
                            value: i,
                            child: Text(cbs[i].name),
                          ),
                      ],
                      onChanged: (id) {
                        setState(() {
                          dropDownValue = id as int;
                        });
                      },
                    ),
                  if (cbs.isEmpty)
                    CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  SizedBox(height: 5.h),
                  MaterialButton(
                    onPressed: () => _pay(context, controller),
                    color: Theme.of(context).primaryColor,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("Payer",
                        style: TextStyle(
                            color: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.color ??
                                ((Theme.of(context).brightness ==
                                        Brightness.light)
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : const Color.fromARGB(255, 0, 0, 0)))),
                  )
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
          builder: (context) =>
              const ErrorDialogWidget(message: "Veuillez saisir un montant"));
    } else if (double.parse(controller.text) < 10) {
      showDialog(
          context: context,
          builder: (context) => const ErrorDialogWidget(
              message: "Le montant doit être supérieur à 10€"));
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IzlyWorkingPage(
            callback: () async {
              return await IzlyLogic.rechargeWithCB(
                  context.read<IzlyCubit>().state.izlyClient!,
                  double.parse(controller.text),
                  cbs[dropDownValue]);
            },
          ),
        ),
      ).then((request3ds) {
        bool poped = false;
        String bodyString = "";
        for (String key in request3ds.body.keys) {
          bodyString = '$bodyString&$key=${request3ds.body[key]}';
        }
        bodyString = bodyString.substring(1);
        bodyString = Uri.encodeFull(bodyString);
        Uint8List body = Uint8List.fromList(bodyString.codeUnits);

        WebViewController controller = WebViewController();
        controller.setJavaScriptMode(JavaScriptMode.unrestricted);
        controller.setNavigationDelegate(
          NavigationDelegate(
            onNavigationRequest: (NavigationRequest request) async {
              if (request.url.contains("izly") && !poped) {
                Navigator.pop(context);
                poped = true;
              }
              return NavigationDecision.navigate;
            },
          ),
        );
        controller.loadRequest(
          Uri.parse(request3ds.url),
          method: LoadRequestMethod.post,
          body: body,
        );
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
          context
              .read<IzlyCubit>()
              .connect(settings: context.read<SettingsCubit>().state.settings);
          Navigator.pop(context);
        });
      });
    }
  }
}
