import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/screens/bloc_connections/connections/agenda_connections.dart';
import 'package:onyx/core/screens/bloc_connections/connections/authentification_connections.dart';
import 'package:onyx/core/screens/bloc_connections/connections/examen_connections.dart';
import 'package:onyx/core/screens/bloc_connections/connections/settings_connections.dart';
import 'package:onyx/core/screens/bloc_connections/connections/tomuss_connections.dart';

class BlocConnectionScreen extends StatelessWidget {
  const BlocConnectionScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        TomussConnection(),
        AuthentificationConnection(),
        SettingsConnection(),
        ExamensConnection(),
        AgendaConnection(),
      ],
      child: child,
    );
  }
}
