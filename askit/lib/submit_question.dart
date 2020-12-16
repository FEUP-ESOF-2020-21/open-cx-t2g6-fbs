import 'package:askit/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
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
    return Scaffold(
      body: new ListView(children: [
        SizedBox(height: 35),
        Padding(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: _titleText("Submit Question", 50),
            )),
        SizedBox(height: 35),
        MyCustomForm(),
      ]),
    );
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
            cursorColor: Colors.purple[900],
            decoration: InputDecoration(
                labelText: 'Enter the question',
                labelStyle: TextStyle(color: Colors.purple[900]),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: Colors.purple[900]))),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              question = value;
              return null;
            },
          ),
          new TextFormField(
            cursorColor: Colors.purple[900],
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a valid number';
              }
              slide = int.parse(value);
              return null;
            },
            decoration: InputDecoration(
                labelText: 'Enter the slide number',
                labelStyle: TextStyle(color: Colors.purple[900]),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: Colors.purple[900]))),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            // Only numbers can be entered
          ),
          SizedBox(height: 35),
          Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: ElevatedButton(
                  child: Text('Submit', style: new TextStyle(fontSize: 15)),
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Submitting question...')));
                      sendData().then((result) {
                        Navigator.pop(context);
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.purple[900],
                      minimumSize: Size(50, 50),
                      side: BorderSide(width: 3.0, color: Colors.white),
                      shadowColor: Colors.black),
                ),
              )),
        ],
      ),
    );
  }

  Future sendData() async {
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
    await http.get(encoded);
  }
}

Widget _titleText(String text, double size) {
  return Center(
      child: Stack(
    children: [
      Text(
        text,
        style: TextStyle(
            fontSize: size,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 6
              ..color = Colors.purple[900]),
      ),
      Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: size,
          shadows: <Shadow>[
            Shadow(
              offset: Offset(6.0, 6.0),
              blurRadius: 8.0,
              color: Colors.purple[900],
            ),
          ],
        ),
      ),
    ],
  ));
}
