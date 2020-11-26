import 'package:askit/question.dart';
import 'package:askit/sign_in.dart';
import 'package:flutter/material.dart';

class CreateLecturePage extends StatefulWidget {
  @override
  _CreateLectureState createState() => _CreateLectureState();
}

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
                    title: Text('CREATE LECTURE',
                        style: TextStyle(fontSize: 30)))),
            body: new Column(
              children: [],
            )));
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
