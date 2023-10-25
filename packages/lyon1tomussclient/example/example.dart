import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:lyon1casclient/lyon1casclient.dart';

void main() async {
  Lyon1CasClient lyon1Cas = Lyon1CasClient();
  final bool isAuthenticated =
      (await lyon1Cas.authenticate(Credential("p1234567", "a_valid_password")))
          .authResult;
  if (!isAuthenticated) {
    print("You are not authenticated. Please check your username and password");
    return;
  }
  final Lyon1TomussClient tomuss = Lyon1TomussClient(lyon1Cas);

  final ParsedPage? parsedPageOpt =
      await tomuss.getParsedPage(Lyon1TomussClient.currentSemester().url);

  if (parsedPageOpt == null) {
    print("There was an error while fetching Tomuss");
    return;
  }

  final ParsedPage parsedPage = parsedPageOpt;

  // list teaching units
  for (final TeachingUnit tu in parsedPage.teachingunits) {
    print(tu.title);
    print("\tGrades:");
    for (final Grade g in tu.grades) {
      print("\t\t${g.title}: ${g.numerator}/${g.denominator}");
    }

    // list masters for current TU
    print("\tMasters:");
    for (final Teacher t in tu.masters) {
      print("\t\t${t.name} (${t.email})");
    }
  }

  // list semesters
  for (final Semester s in parsedPage.semesters) {
    print("${s.title} (${s.url})");
  }
}
