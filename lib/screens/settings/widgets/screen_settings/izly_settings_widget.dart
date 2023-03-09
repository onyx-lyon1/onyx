import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/screens/izly/izly_export.dart';

class IzlySettingsWidget extends StatelessWidget {
  const IzlySettingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      color: const Color(0xffbf616a),
      textColor: Colors.white70,
      child: const Text('Déconnexion de izly'),
      onPressed: () {
        CacheService.reset<IzlyCredential>();
        context.read<IzlyCubit>().disconnect();
      },
    );
  }
}
