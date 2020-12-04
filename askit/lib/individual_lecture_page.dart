import 'package:askit/lecture.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:askit/sign_in.dart';
import 'dart:core';

class ViewSpecificUserLecturePage extends StatefulWidget {
  Lecture lecture;

  ViewSpecificUserLecturePage(Lecture lecture) {
    this.lecture = lecture;
    print(lecture.printIdAndTitle());
  }

  @override
  _ViewSpecificUserLectureState createState() =>
      _ViewSpecificUserLectureState(lecture);
}

class _ViewSpecificUserLectureState extends State<ViewSpecificUserLecturePage> {
  Lecture lecture;

  _ViewSpecificUserLectureState(Lecture lecture) {
    this.lecture = lecture;
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
                  child:
                      Text('SELECTED LECTURE', style: TextStyle(fontSize: 20)),
                  padding: EdgeInsets.only(top: 80.0, bottom: 20)),
              new ListTile(
                title: Text(lecture.printIdAndTitle() +
                    "\n\n" +
                    lecture.printTheRest()),
              )
            ])));
  }

  Widget getRole(Lecture lecture, String email) {}

  Future getRoleFromDatabase(Lecture lecture, String email) {}
}
