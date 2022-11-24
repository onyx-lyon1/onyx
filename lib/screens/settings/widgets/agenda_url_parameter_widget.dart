import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/screens/settings/settings_export.dart';
import 'package:sizer/sizer.dart';

class AgendaUrlParameterWidget extends StatelessWidget {
  const AgendaUrlParameterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController qrCodeURLController = TextEditingController();
    qrCodeURLController.text = context.read<SettingsCubit>().state.settings.agendaURL;
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Column(
          children: [
            TextSwitchWidget(
              text: 'Récupérer automatiquement les ressources de l\'agenda',
              value: context.read<SettingsCubit>().state.settings.fetchAgendaAuto,
              onChanged: (bool b) {
                context.read<SettingsCubit>().modify(settings: context
                    .read<SettingsCubit>()
                    .state.settings
                    .copyWith(fetchAgendaAuto: b));
              },
            ),
            (!context.read<SettingsCubit>().state.settings.fetchAgendaAuto)
                ? Container(
                    clipBehavior: Clip.hardEdge,
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 110,
                            height: 8.h,
                            padding: EdgeInsets.only(left: 3.w),
                            decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                            ),
                            child: Center(
                              child: TextField(
                                controller: qrCodeURLController,
                                enableSuggestions: false,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                ),
                                onChanged: (String value) {
                                  context.read<SettingsCubit>().modify(settings: context
                                          .read<SettingsCubit>()
                                          .state.settings
                                          .copyWith(agendaURL: value));
                                  if (kDebugMode) {
                                    print(
                                        'value: ${context.read<SettingsCubit>().state.settings.agendaURL}');
                                  }
                                },
                                decoration: const InputDecoration(
                                  isDense: true,
                                  labelStyle: TextStyle(fontSize: 12),
                                  hintStyle: TextStyle(fontSize: 12),
                                  hintText: 'URL de l\'agenda',
                                  border: InputBorder.none,
                                ),
                                textAlignVertical: TextAlignVertical.center,
                                maxLines: 1,
                                minLines: 1,
                              ),
                            ),
                          ),
                          Container(
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => const QrCodeScannerPage(),
                                ))
                                    .then((dynamic url) {
                                  qrCodeURLController.value = TextEditingValue(
                                      text: url ??
                                          qrCodeURLController.value.text);
                                  context.read<SettingsCubit>().modify(settings: context
                                          .read<SettingsCubit>()
                                          .state.settings
                                          .copyWith(
                                              agendaURL: url ??
                                                  context
                                                      .read<SettingsCubit>()
                                                      .state.settings
                                                      .agendaURL));
                                });
                              },
                              enableFeedback: true,
                              splashColor: Colors.transparent,
                              icon: Icon(
                                Icons.qr_code,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        );
      },
    );
  }
}
