// ignore_for_file: unnecessary_this, prefer_initializing_formals

part of 'home_cubit.dart';

@MappableEnum()
enum HomeStatus { initial, updateScreen }

@MappableClass()
class HomeState with HomeStateMappable {
  final HomeStatus status;
  final int? enabledSelectedIndex;
  final int? disabledSelectedIndex;
  final bool showSecondaryScreens;

  HomeState({
    required this.status,
    this.enabledSelectedIndex,
    this.disabledSelectedIndex,
    this.showSecondaryScreens = false,
  }) {
    //assert that we will never have both selected indexes to null or not null at the same time
    assert(enabledSelectedIndex != disabledSelectedIndex);
  }
}
