import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class IzlyPaidPage extends StatelessWidget {
  const IzlyPaidPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: IzlyLogic.getUserPayments(
          context.read<IzlyCubit>().state.izlyClient!),
      builder: (context, state) {
        if (state.hasData) {
          List<PaymentModel> paymentsList = state.data!;
          return SafeArea(
            child: Material(
              child: CommonScreenWidget(
                header: const IzlyRechargeHeaderWidget(
                    title: "Historique des paiements"),
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 5,
                          ),
                          shrinkWrap: true,
                          itemCount: paymentsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            Color colorBackground;
                            paymentsList[index].isSucess
                                ? colorBackground = Colors.green
                                : colorBackground = Colors.red;

                            return Container(
                              decoration: BoxDecoration(
                                color: colorBackground,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              margin: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      paymentsList[index].paymentTime,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      paymentsList[index].amountSpent,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
              strokeWidth: 7.sp,
            ),
          );
        }
      },
    );
  }
}
