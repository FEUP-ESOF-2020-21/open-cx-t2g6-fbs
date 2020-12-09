import 'package:askit/lecture.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:askit/home_page.dart';
import 'package:askit/sign_in.dart';
import 'dart:core';

class ViewSpecificUserLecturePage extends StatefulWidget {
  
  @override
  _ViewSpecificUserLectureState createState() =>
      _ViewSpecificUserLectureState();
}

class _ViewSpecificUserLectureState extends State<ViewSpecificUserLecturePage> {
  Lecture lecture;
  String role = "";
  Widget tmp = new Text("");

  _ViewSpecificUserLectureState() {
    this.lecture = selectedLecture;
    getRole();
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
                      "\n")),
                      
                      tmp ,
             
            ])));
  }

  Widget getRole(){
    getRoleFromDatabase(this.lecture, email);
  }

  Future getRoleFromDatabase(Lecture lecture, String email) async {
    print("Function was called!\n");

    var url =
        "https://web.fe.up.pt/~up201806296/database/getRoleFromLecture.php";

    url = url + "?email=" + email + "&lectureId=" + lecture.getId().toString();

    var encoded = Uri.encodeFull(url);
    http.Response response = await http.get(encoded);
    role = response.body.toString();
    setState(() {
      tmp = new Text("Role: " + role);
    });
  }
}
