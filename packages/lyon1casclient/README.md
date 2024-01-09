# 🚀 lyon1_casclient

A Dart library that provides authentication with the CAS (Central Authentication Service) system of Lyon 1 University (https://cas.univ-lyon1.fr).

## ✨ Features

- Authenticate users with Lyon 1 CAS credentials.
- Seamless integration with other Dart libraries, such as dartus-tomuss-client, izlyclient, lyon1-agendaclient, and lyon1-mail.

## ⚙️ Installation

Add the following to your project's `pubspec.yaml` file:

```yaml
dependencies:
  lyon1casclient: any
```

## 🔒 Usage

Start by importing the library:

```dart
import 'package:lyon1casclient/lyon1casclient.dart';
```

Then, use the `Lyon1Cas` class to authenticate a user with their Lyon 1 CAS credentials:

```dart
void main() async {
  final Lyon1Cas auth = Lyon1Cas();
  final bool isAuthenticated = (await auth.authenticate(Credential("p1234567", "a_valid_password"))).authResult;

  if (!isAuthenticated) {
    print("You are not authenticated. Please check your username and password");
    return;
  }

  // User is authenticated, perform additional operations
  // ...
}
```

Make sure to replace `"p1234567"` with the actual Lyon 1 CAS username and `"a_valid_password"` with the corresponding password.

## 🚀 Integration with Other Libraries

The `lyon1_casclient` library is designed to work seamlessly with other Dart libraries commonly used at Lyon 1 University, such as:

- [dartus-tomuss-client](https://pub.dev/packages/dartus_tomuss_client)
- [izlyclient](https://pub.dev/packages/izlyclient)
- [lyon1-agendaclient](https://pub.dev/packages/lyon1_agendaclient)
- [lyon1-mail](https://pub.dev/packages/lyon1_mail)

By combining these libraries, you can build powerful applications that leverage Lyon 1 University's CAS authentication system along with other essential services.

## 🌟 Example

Here's an example that demonstrates the authentication process using `lyon1_casclient`:

```dart
import 'package:lyon1casclient/lyon1casclient.dart';

void main() async {
  final Lyon1Cas auth = Lyon1Cas();
  final bool isAuthenticated = (await auth.authenticate(Credential("p1234567", "a_valid_password"))).authResult;

  if (!isAuthenticated) {
    print("You are not authenticated. Please check your username and password");
    return;
  }

  // User is authenticated, perform additional operations
  // ...
}
```

This example shows how to authenticate a user with their Lyon 1 CAS credentials and handle the authentication result.

> **Note**: Replace `"p1234567"` with the actual Lyon 1 CAS username and `"a_valid_password"` with the corresponding password.

## 🌍 Community and Support

For questions, bug reports, or feature requests, please visit the [lyon1_casclient GitHub repository](https://github.com/your-username/lyon1_casclient). Contributions and feedback are welcome!