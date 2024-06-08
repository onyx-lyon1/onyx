import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_cubit.mapper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(HomeState(
          status: HomeStatus.initial,
          showSecondaryScreens: false,
        ));

  void updateSelectedIndex(int index) {
    emit(
      state.copyWith(
        selectedIndex: index,
        showSecondaryScreens: false,
      ),
    );
  }

  void toggleSecondaryScreens() {
    emit(
      state.copyWith(
        showSecondaryScreens: !state.showSecondaryScreens,
      ),
    );
  }
}
