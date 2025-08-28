import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/settings/settings_export.dart';

class BlocLogger extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is SettingsCubit) {
      Res.logger.d(("${bloc.runtimeType}: ${change.nextState.runtimeType}"));
    } else {
      Res.logger.d(("${bloc.runtimeType}: ${change.nextState.status}"));
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    Res.logger.e("${bloc.runtimeType}: $error");
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    Res.logger.d("${bloc.runtimeType}: $event");
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    Res.logger.d("${bloc.runtimeType}: ${transition.nextState.status}");
    super.onTransition(bloc, transition);
  }

  @override
  void onCreate(BlocBase bloc) {
    Res.logger.d("${bloc.runtimeType}: created");
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    Res.logger.d("${bloc.runtimeType}: closed");
    super.onClose(bloc);
  }
}
