import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:lyon1examenclient/lyon1examenclient.dart';

void main() async {
  Lyon1CasClient.registerAdapters();
  final lyon1Cas = Lyon1CasClient();
  lyon1Cas.authenticate(Credential("username", "password"));
  final examClient = Lyon1ExamenClient(lyon1Cas);
  final exams = await examClient.fetchExams();
  for (var i in exams) {
    print(i);
  }
}
