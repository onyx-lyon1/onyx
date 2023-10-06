import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class IzlyPaymentHistory extends StatelessWidget {
  const IzlyPaymentHistory({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<IzlyCubit>().loadPaymentHistory();
    return BlocConsumer<IzlyCubit, IzlyState>(
      listenWhen: (previous, current) =>
          previous.izlyClient != current.izlyClient,
      listener: (context, state) {
        context.read<IzlyCubit>().loadPaymentHistory();
      },
      builder: (context, state) {
        Widget body;
        if (state.izlyClient == null) {
          body = const StateDisplayingPage(
            message: "Vous n'êtes pas encore connecté à Izly",
          );
        } else if (state.paymentList.isEmpty) {
          body = CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
            strokeWidth: 7.sp,
          );
        } else {
          body = ListView(
            children: [
              for (var i in state.paymentList)
                Container(
                  decoration: BoxDecoration(
                    color: i.isSucess ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: EdgeInsets.all(1.h),
                  padding: EdgeInsets.all(4.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        i.paymentTime,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        i.amountSpent,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
            ],
          );
        }
        return SafeArea(
          child: Material(
            child: CommonScreenWidget(
              state: (IzlyStatus.loading == state.status)
                  ? const LoadingHeaderWidget(message: "Chargement...")
                  : null,
              header: const IzlyRechargeHeaderWidget(
                  title: "Historique des paiements"),
              body: Center(
                child: body,
              ),
              onRefresh: () async {
                context.read<IzlyCubit>().loadPaymentHistory(cache: false);
              },
            ),
          ),
        );
      },
    );
  }
}
