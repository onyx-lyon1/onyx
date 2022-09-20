part of 'grades_bloc.dart';

@immutable
abstract class GradesEvent {}

// ignore: must_be_immutable
class GradesLoad extends GradesEvent {
  Dartus dartus;
  GradesLoad(this.dartus);
}
