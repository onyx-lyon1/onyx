import 'package:equatable/equatable.dart';

class RequestData extends Equatable {
  final Map<String, dynamic> body;
  final String url;
  RequestData(this.url, this.body);

  @override
  List<Object?> get props => [url, body];
  @override
  bool get stringify => true;
}
