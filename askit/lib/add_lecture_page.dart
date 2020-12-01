import 'package:flutter/material.dart';
import 'package:askit/create_lecture_page.dart';
import 'package:askit/choose_lecture_page.dart';

class AddLecturePage extends StatefulWidget {
  @override
  _AddLectureState createState() => _AddLectureState();
}

class _AddLectureState extends State<AddLecturePage> {
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
            body: new Column(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: new Container(
                        child: Text('ADD A LECTURE',
                            style: TextStyle(fontSize: 20)),
                        padding: EdgeInsets.only(top: 150.0, bottom: 20))),
                _chooseALectureButton(context),
                _createALectureButton(context)
              ],
            )));
  }

  Widget _chooseALectureButton(BuildContext context) {
    //!!Expanded is needed so that Align uses the whole available space and not the space available within the row/column
    return Container(
        child: OutlineButton(
            child: Text('Choose a Lecture'),
            splashColor: Colors.grey,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChooseLecturePage()),
              );
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            highlightElevation: 0,
            borderSide: BorderSide(color: Colors.grey)),
        padding: EdgeInsets.only(top: 50, bottom: 20));
  }

  Widget _createALectureButton(BuildContext context) {
    //!!Expanded is needed so that Align uses the whole available space and not the space available within the row/column
    return Container(
        child: OutlineButton(
            child: Text('Create a Lecture'),
            splashColor: Colors.grey,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateLecturePage()),
              );
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            highlightElevation: 0,
            borderSide: BorderSide(color: Colors.grey)));
  }
}
