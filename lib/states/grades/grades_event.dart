part of 'grades_bloc.dart';

@immutable
abstract class GradesEvent {}

class GradesLoad extends GradesEvent {
  final Dartus dartus;
  final bool cache;
  GradesLoad(this.dartus,{this.cache=true});
}
