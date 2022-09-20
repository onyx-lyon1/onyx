part of 'grades_bloc.dart';

@immutable
abstract class GradesState {}

class GradesInitial extends GradesState {}
class GradesReady extends GradesState {}
class GradesLoading extends GradesState {}
class GradesError extends GradesState {}
