# 🚀 lyon1examenClient

A Dart library that provides seamless integration with Lyon 1 University's exam service, leveraging the Lyon 1 CAS (Central Authentication Service) system for user authentication.

## ✨ Features

- Authenticate users with Lyon 1 CAS credentials using the `lyon1casclient` library.
- Fetch and retrieve exam information from Lyon 1 University's exam service.
- Designed for easy integration with Lyon 1 CAS, allowing a streamlined authentication process.

## ⚙️ Installation

Add the following dependencies to your project's `pubspec.yaml` file:

```yaml
dependencies:
  lyon1casclient: any
  lyon1examenclient: any
```

## 🔒 Usage

Start by importing the necessary libraries:

```dart
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:lyon1examenclient/lyon1examenclient.dart';
```

Register adapters for Lyon1CasClient:

```dart
Lyon1CasClient.registerAdapters();
```

Authenticate the user using Lyon1CasClient:

```dart
final lyon1Cas = Lyon1CasClient();
lyon1Cas.authenticate(Credential("username", "password"));
```

Initialize Lyon1ExamenClient with the authenticated Lyon1CasClient:

```dart
final examClient = Lyon1ExamenClient(lyon1Cas);
```

Fetch and print exam information:

```dart
final exams = await examClient.fetchExams();
for (var exam in exams) {
  print(exam);
}
```

Make sure to replace `"username"` with the actual Lyon 1 CAS username and `"password"` with the corresponding password.

## 🌍 Community and Support

For questions, bug reports, or feature requests related to `lyon1examenClient`, please visit the [lyon1examenClient GitHub repository](https://github.com/onyx-lyon1/onyx/tree/main/packages/lyon1examenclient). Contributions and feedback are always welcome!