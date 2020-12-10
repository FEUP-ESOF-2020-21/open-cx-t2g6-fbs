import 'package:askit/choose_lecture_page.dart';
import 'package:askit/sign_in.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:askit/home_page.dart'; //for selectedLecture

class SubmitQuestionPage extends StatefulWidget {
  @override
  _SubmitQuestionState createState() => _SubmitQuestionState();
}

String question;
int slide;

class _SubmitQuestionState extends State<SubmitQuestionPage> {
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
                      Text('SUBMIT QUESTION', style: TextStyle(fontSize: 30)))),
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
            decoration: InputDecoration(labelText: 'Enter the question'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              question = value;
              return null;
            },
          ),
          new TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a valid number';
              }
              slide = int.parse(value);
              return null;
            },
            decoration:
                new InputDecoration(labelText: "Enter the slide number"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            // Only numbers can be entered
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
                child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  print(question);
                  print(slide);
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                  sendData();
                  //Process data
                }
              },
              child: Text('Submit'),
            )),
          ),
        ],
      ),
    );
  }

  Future sendData() async {
    print("Function was called!\n");

    var url = "https://web.fe.up.pt/~up201806296/database/submitQuestion.php";

    url = url +
        "?question=" +
        question +
        "&email=" +
        email +
        "&lectureId=" +
        selectedLecture.getId().toString() +
        "&slide=" +
        slide.toString();

    var encoded = Uri.encodeFull(url);

    print(encoded + "\n");

    http.Response response = await http.get(encoded);
    print(response.body.toString);
  }
}
