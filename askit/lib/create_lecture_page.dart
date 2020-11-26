import 'package:askit/question.dart';
import 'package:askit/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CreateLecturePage extends StatefulWidget {
  @override
  _CreateLectureState createState() => _CreateLectureState();
}

String title;
String description;
int capacity;

String date = "2020-01-01";

class _CreateLectureState extends State<CreateLecturePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.purple[900]),
        home: Scaffold(
          appBar: PreferredSize(
              // Change this argument to customize the height of the app bar
              preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                  title:
                      Text('CREATE LECTURE', style: TextStyle(fontSize: 30)))),
          body: new ListView(children: [
            MyCustomForm(),
          ]),
        ));
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new TextFormField(
            decoration: InputDecoration(labelText: 'Enter the title'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              title = value;
              return null;
            },
          ),
          new TextFormField(
            decoration: InputDecoration(labelText: 'Enter the description'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              description = value;
              return null;
            },
          ),
          new TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a valid number';
              }
              capacity = int.parse(value);
              return null;
            },
            decoration: new InputDecoration(labelText: "Enter your number"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            // Only numbers can be entered
          ),
          new Container(
            child: Text("Choose the date:\n"),
            padding: EdgeInsets.only(top: 20),
          ),
          new Container(
            height: 60,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime(2020, 1, 1),
              onDateTimeChanged: (DateTime newDateTime) {
                date = newDateTime.year.toString() + "-";
                var month = newDateTime.month;
                if (month < 10) date += "0";
                date += month.toString() + "-";

                var day = newDateTime.day;
                if (day < 10) date += "0";
                date += day.toString();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  print(title);
                  print(description);
                  print(capacity);
                  print(date);
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                  sendData();
                  //Process data
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

Future sendData() async {
  print("Function was called!\n");
  var url = "https://web.fe.up.pt/~up201806296/database/add.php";

  url = url +
      "?title=" +
      title +
      "&description=" +
      description +
      "&capacity=" +
      capacity.toString() +
      "&date=" +
      date;

  var encoded = Uri.encodeFull(url);

  print(encoded + "\n");

  http.Response response = await http.get(encoded);
  print(response.body.toString);
}
