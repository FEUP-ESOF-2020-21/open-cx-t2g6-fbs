import 'package:askit/lecture.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:askit/home_page.dart';
import 'package:askit/sign_in.dart';
import 'dart:core';

class ViewQuestionsAsAttendee extends StatefulWidget {
  @override
  _ViewQuestionsAsAttendeeState createState() =>
      _ViewQuestionsAsAttendeeState();
}

class _ViewQuestionsAsAttendeeState extends State<ViewQuestionsAsAttendee> {
  Lecture lecture;

  _ViewQuestionsAsAttendeeState() {
    this.lecture = selectedLecture;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.purple[900]),
        home: Scaffold(
            appBar: PreferredSize(
                // Change this argument to customize the height of the app bar
                preferredSize: Size.fromHeight(50.0),
                child: AppBar(
                    title: Text('HOME', style: TextStyle(fontSize: 30)))),
            body: new Column(children: [
              new Container(
                  child: Text(
                      'Questions for Lecture #' +
                          selectedLecture.getId().toString(),
                      style: TextStyle(fontSize: 20)),
                  padding: EdgeInsets.only(top: 80.0, bottom: 20)),
            ])));
  }
}
