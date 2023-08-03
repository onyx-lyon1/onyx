# 📅 lyon1agendaclient

A Dart library for retrieving Lyon 1 University agendas using Lyon1CasClient for authentication.

## ✨ Features

- Retrieve agendas for Lyon 1 University using Lyon1CasClient for authentication.

## ⚙️ Installation

Add the following to your project's `pubspec.yaml` file:

```yaml
dependencies:
  lyon1agendaclient: ^1.0.0
  lyon1casclient: ^1.0.0
```

## 🔒 Usage

Start by importing the required libraries:

```dart
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
```

Then, use the `Lyon1AgendaClient` class to retrieve agendas, authenticating with Lyon 1 CAS credentials using `Lyon1CasClient`:

```dart
void main() async {
  final Lyon1AgendaClient agendaClient = Lyon1AgendaClient.useLyon1Cas(Lyon1CasClient());
  final Agenda? agendaOpt = await agendaClient.getAgenda(id: 10069);

  if (agendaOpt == null) {
    // Handle gracefully
    return;
  }

  final Agenda agenda = agendaOpt;

  for (final Day day in agenda.days) {
    print(day.date.toString());

    for (final Event e in day.events) {
      print(e.name);
      print("\t${e.location} | ${e.teacher}");
      print("\t${e.start.toString()} -> ${e.end.toString()}");
    }
  }
}
```

Make sure to replace `10069` with the desired agenda ID.