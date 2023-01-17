import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izlyclient/dart_izlyclient.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IzlyRechargeCBPage extends StatefulWidget {
  const IzlyRechargeCBPage({Key? key}) : super(key: key);

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
    cbs.removeAt(cbs.length - 1);
    setState(() {
      dropDownValue = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "izly_recharge_cb",
      child: SafeArea(
        child: Material(
          child: CommonScreenWidget(
            header: const IzlyRechargeHeaderWidget(
                title: "Recharger par Carte bancaire"),
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
                        dropdownColor: Theme.of(context).backgroundColor,
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
                      child: const Text("Payer"),
                    )
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
        String bodyString = "";
        for (String key in request3ds.body.keys) {
          bodyString = '$bodyString&$key=${request3ds.body[key]}';
        }
        Uint8List body = Uint8List.fromList(bodyString.codeUnits);
        // List<WebViewCookie> initialCookies = [];
        // print(request3ds.initialCookies);
        // for (var cookie in request3ds.initialCookies) {
        //   initialCookies.add(WebViewCookie(
        //       name: cookie.name,
        //       value: cookie.value,
        //       domain: "mon-espace.izly.fr"));
        // }
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SafeArea(
              child: WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  // initialCookies: initialCookies,
                  onWebViewCreated: (controller) {
                    controller.loadRequest(
                      WebViewRequest(
                        uri: Uri.parse(request3ds.url),
                        method: WebViewRequestMethod.post,
                        body: body,
                      ),
                    );
                  },
                  navigationDelegate: (NavigationRequest request) async {
                    if (request.url.contains("izly")) {
                      Navigator.pop(context);
                    }
                    return NavigationDecision.navigate;
                  }),
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
