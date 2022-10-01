part of 'email_bloc.dart';

@immutable
abstract class EmailState {}

class EmailInitial extends EmailState {}
class EmailConnected extends EmailState {}
class EmailLoading extends EmailState {}
class EmailLoaded extends EmailState {}
class EmailSending extends EmailState {}
class EmailSended extends EmailState {}
class EmailUpdated extends EmailState {}
class EmailError extends EmailState {}
class EmailSorted extends EmailState {}
