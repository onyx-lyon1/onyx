# 💳 izlyclient

A Dart library for interacting with the Izly platform, allowing you to perform various operations such as retrieving balances, generating QR codes, recharging accounts, and more.

## ✨ Features

- Authenticate users with Izly credentials.
- Get account balances.
- Generate QR codes.
- Recharge accounts using various methods.
- Interact with the Izly platform efficiently and easily.

## ⚙️ Installation

Add the following to your project's `pubspec.yaml` file:

```yaml
dependencies:
  izlyclient: ^1.0.0
```

## 🔒 Usage

Start by importing the library:

```dart
import 'package:izlyclient/izlyclient.dart';
```

Create a new instance of the `IzlyClient` class with your Izly credentials:

```dart
void main() async {
  IzlyClient izlyClient = IzlyClient("username", "password");

  // Connect to Izly
  await izlyClient.login();

  // Get the balance
  double balance = await izlyClient.getBalance();

  // Get 3 QR codes
  List<Uint8List> qrCodes = await izlyClient.getNQRCode(3);

  // Save the QR codes
  for (int i = 0; i < qrCodes.length; i++) {
    await File("qrCode$i.png").writeAsBytes(qrCodes[i]);
  }

  // Get the URL to recharge with an account transfer
  String url = await izlyClient.getTransferPaymentUrl(10.0);

  // Recharge with a credit card
  bool result = await izlyClient.rechargeWithCB(10.0);

  // Recharge via someone else
  bool result2 = await izlyClient.rechargeViaSomeoneElse(10.0, "email", "message");
}
```

Make sure to replace `"username"` and `"password"` with your actual Izly credentials.