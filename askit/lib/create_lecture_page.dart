import 'package:askit/question.dart';
import 'package:askit/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateLecturePage extends StatefulWidget {
  @override
  _CreateLectureState createState() => _CreateLectureState();
}

String title;
String description;
int capacity;

class _CreateLectureState extends State<CreateLecturePage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.purple[900]),
        home: Scaffold(
          appBar: PreferredSize(
              // Change this argument to customize the height of the app bar
              preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                  title:
                      Text('CREATE LECTURE', style: TextStyle(fontSize: 30)))),
          body: new Column(children: [
            MyCustomForm(),
          ]),
        ));
  }

  Widget _defaultButton() {
    //!!Expanded is needed so that Align uses the whole available space and not the space available within the row/column
    return Container(
        child: OutlineButton(
            child: Text('Button'),
            splashColor: Colors.grey,
            onPressed: () {
              //DO something
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            highlightElevation: 0,
            borderSide: BorderSide(color: Colors.grey)),
        padding: EdgeInsets.only(top: 50, bottom: 20));
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
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
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
