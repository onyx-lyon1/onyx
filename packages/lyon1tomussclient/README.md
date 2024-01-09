# 📚 lyon1tomussclient

A Dart library for interacting with Tomuss, Lyon 1 University's academic platform, using Lyon1CasClient for authentication.

## ✨ Features

- Authenticate users with Lyon 1 CAS credentials.
- Retrieve academic information from Lyon 1 Tomuss.
- Access grades, teaching units, masters, and more.

## ⚙️ Installation

Add the following to your project's `pubspec.yaml` file:

```yaml
dependencies:
  lyon1tomussclient: any
  lyon1casclient: any
```

## 🔒 Usage

Start by importing the required libraries:

```dart
import 'package:dartus/tomuss.dart';
import 'package:lyon1_casclient/lyon1_cas.dart';
```

Then, use the `Lyon1Cas` class to authenticate a user with their Lyon 1 CAS credentials. After authentication, create a new instance of the `Dartus` class with the Lyon 1 CAS object:

```dart
void main() async {
  Lyon1Cas lyon1Cas = Lyon1Cas();
  final bool isAuthenticated = (await lyon1Cas.authenticate(Credential("p1234567", "a_valid_password"))).authResult;

  if (!isAuthenticated) {
    print("You are not authenticated. Please check your username and password");
    return;
  }

  final Dartus tomuss = Dartus(lyon1Cas);

  final ParsedPage? parsedPageOpt = await tomuss.getParsedPage(Dartus.currentSemester());

  if (parsedPageOpt == null) {
    print("There was an error while fetching Tomuss");
    return;
  }

  final ParsedPage parsedPage = parsedPageOpt;

  // List teaching units
  for (final TeachingUnit tu in parsedPage.teachingunits!) {
    print(tu.title);
    print("\tGrades:");
    for (final Grade g in tu.grades) {
      print("\t\t${g.title}: ${g.numerator}/${g.denominator}");
    }

    // List masters for the current TU
    print("\tMasters:");
    for (final Teacher t in tu.masters) {
      print("\t\t${t.name} (${t.email})");
    }
  }

  // List semesters
  for (final Semester s in parsedPage.semesters!) {
    print("${s.title} (${s.url})");
  }
}
```

Make sure to replace `"p1234567"` with the actual Lyon 1 CAS username and `"a_valid_password"` with the corresponding password.