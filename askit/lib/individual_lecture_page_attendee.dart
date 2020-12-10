import 'package:askit/lecture.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:askit/home_page.dart';
import 'package:askit/sign_in.dart';
import 'dart:core';

class ViewSpecificUserLecturePageAsAttendee extends StatefulWidget {
  @override
  _ViewSpecificUserLectureStateAsAttendee createState() =>
      _ViewSpecificUserLectureStateAsAttendee();
}

class _ViewSpecificUserLectureStateAsAttendee
    extends State<ViewSpecificUserLecturePageAsAttendee> {
  Lecture lecture;

  _ViewSpecificUserLectureStateAsAttendee() {
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
                  child:
                      Text('SELECTED LECTURE', style: TextStyle(fontSize: 20)),
                  padding: EdgeInsets.only(top: 80.0, bottom: 20)),
              new ListTile(
                  title: Text(lecture.printIdAndTitle() +
                      "\n" +
                      lecture.printTheRest() +
                      "\n" +
                      "Role: Attendee")),
              new OutlineButton(
                  child: Text('Download files'),
                  splashColor: Colors.grey,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  highlightElevation: 0,
                  borderSide: BorderSide(color: Colors.grey)),
              new OutlineButton(
                  child: Text('View Questions'),
                  splashColor: Colors.grey,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  highlightElevation: 0,
                  borderSide: BorderSide(color: Colors.grey))
            ])));
  }
}
