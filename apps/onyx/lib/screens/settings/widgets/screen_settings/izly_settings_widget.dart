import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:onyx/l10n/app_localizations.dart';
import 'package:onyx/screens/settings/domain/model/settings_model.dart';
import 'package:onyx/screens/settings/states/settings_cubit.dart';
import 'package:onyx/screens/settings/widgets/text_switch_widget.dart';

class IzlySettingsWidget extends StatelessWidget {
  const IzlySettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextSwitchWidget(
          text: AppLocalizations.of(context).enableIzlyNotif,
          value: context.read<SettingsCubit>().settings.izlyNotification,
          onChanged: (value) {
            context.read<SettingsCubit>().modify(
                  settings: context
                      .read<SettingsCubit>()
                      .settings
                      .copyWith(izlyNotification: value),
                );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          color: const Color(0xffbf616a),
          textColor: Colors.white70,
          child: Text(AppLocalizations.of(context).logoutIzly),
          onPressed: () {
            CacheService.reset<IzlyCredential>();
            context.read<IzlyCubit>().disconnect();
          },
        ),
      ],
    );
  }
}
