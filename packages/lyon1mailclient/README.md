# 📧 lyon1mailclient

A Dart library for interacting with Lyon 1 University's email system, providing functionality to fetch and manage email messages.

## ✨ Features

- Authenticate users with Lyon 1 CAS credentials.
- Fetch email messages from Lyon 1 University's mail server.
- Access email metadata such as sender, subject, date, read status, and attachments.
- Retrieve email content and attachments.

## ⚙️ Installation

Add the following to your project's `pubspec.yaml` file:

```yaml
dependencies:
  lyon1mailclient: any
```

## 🔒 Usage

Start by importing the library:

```dart
import 'package:lyon1mailclient/lyon1mailclient.dart';
```

Create a new instance of the `Lyon1Mail` class with your Lyon 1 CAS credentials:

```dart
void main() async {
  final Lyon1Mail mailClient = Lyon1Mail("p1234567", "a_valid_password");

  if (!await mailClient.login()) {
    // Handle gracefully
    return;
  }

  final List<Mail>? emailOpt = await mailClient.fetchMessages(15);

  if (emailOpt == null || emailOpt.isEmpty) {
    // No emails
    return;
  }

  for (final Mail mail in emailOpt) {
    print("${mail.getSender()} sent ${mail.getSubject()} @${mail.getDate().toIso8601String()}");
    print("\tseen: ${mail.isRead()}");
    print("\t${mail.getBody(excerpt: true, excerptLength: 50)}");
    print("\thasPJ: ${mail.hasAttachments()}");
    mail.getAttachmentsNames().forEach((fname) {
      print("\t\t$fname");
    });
  }

  await mailClient.logout();
}
```

Make sure to replace `"p1234567"` with the actual Lyon 1 CAS username and `"a_valid_password"` with the corresponding password.