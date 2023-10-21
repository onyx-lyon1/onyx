# PolytechColloscopeClient

PolytechColloscopeClient is a library aiming at providing a simple interface to fetch data from Polytech Lyon Colloscope
Website

### Usage :

To begin with, you need to create a new instance of the client :

```Dart
var client = PolytechColloscopeClient(username, password);
```

Then, you can fetch various data from the website :

Get the list of all the students (returns a list of Student objects containing student name and ID) :
You must specify the year of the students you want to fetch using the Year enum (Year.first or Year.second)
Example :

```Dart
var students = await client.getStudents(Year.second);
```

You can also fetch a specific student using his name, surname and year (actually, only the first letter of the name is
required since the website only shows the inital) :

```Dart
var student = await client.fetchStudent(Year.second, name, surname);
```

You can then get the student's colloscope :

```Dart
var colloscope = await client.fetchColloscope(student);
```

The colloscope contains a Student object, its trinomeID, and a list of kholles
Each Kholle object contains the date of the kholle, the subject, the kholleur, and possibly a message containing the
room (if present on the website)
