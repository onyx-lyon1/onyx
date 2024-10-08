// ignore_for_file: unnecessary_this, prefer_initializing_formals

part of 'home_cubit.dart';

@MappableEnum()
enum HomeStatus { initial, updateScreen }

@MappableClass()
class HomeState with HomeStateMappable {
  final HomeStatus status;
  final int selectedIndex;
  final bool showSecondaryScreens;

  HomeState({
    required this.status,
    this.selectedIndex = 0,
    this.showSecondaryScreens = false,
  });
}
