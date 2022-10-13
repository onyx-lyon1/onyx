part of 'grades_bloc.dart';

@immutable
abstract class GradesEvent {}

class GradesLoad extends GradesEvent {
  final Dartus dartus;
  GradesLoad(this.dartus);
}
