# 🚀 PolytechColloscopeClient

PolytechColloscopeClient is a Dart library designed to provide a user-friendly interface for fetching data from the Polytech Lyon Colloscope website.

## ✨ Features

- Fetch data such as the list of students, individual student details, and their respective colloscope information.
- Easy integration with Dart projects for accessing Polytech Lyon Colloscope data.

## ⚙️ Usage

Start by adding the following dependency to your project's `pubspec.yaml` file:

```yaml
dependencies:
  polytechcolloscopeclient: any
```

Create an instance of the client by providing your Polytech Lyon Colloscope username and password:

```dart
import 'package:polytechcolloscopeclient/polytechcolloscopeclient.dart';

var client = PolytechColloscopeClient(username, password);
```

### Fetching Students

Get the list of all students for a specific year (Year.first or Year.second):

```dart
var students = await client.getStudents(Year.second);
```

### Fetching a Specific Student

Fetch details of a specific student using their name, surname, and year:

```dart
var student = await client.fetchStudent(Year.second, name, surname);
```

### Fetching Colloscope for a Student

Fetch the colloscope for a specific student, containing their trinomeID and a list of kholles:

```dart
var colloscope = await client.fetchColloscope(student);
```

The colloscope includes information about each kholle, such as the date, subject, kholleur, and optional room details.

Make sure to replace `username` and `password` with your actual Polytech Lyon Colloscope credentials.

## 🌍 Community and Support

For questions, bug reports, or feature requests related to `PolytechColloscopeClient`, please visit the [PolytechColloscopeClient GitHub repository](https://github.com/your-username/polytechcolloscopeclient). Contributions and feedback are welcome!