import 'package:askit/question.dart';
import 'package:askit/sign_in.dart';
import 'package:flutter/material.dart';

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
                Container(
                    child:
                        Text('ADD A LECTURE', style: TextStyle(fontSize: 20)),
                    padding: EdgeInsets.all(20.0)),
                _chooseALectureButton(),
                _createALectureButton()
              ],
            )));
  }

  Widget _chooseALectureButton() {
    //!!Expanded is needed so that Align uses the whole available space and not the space available within the row/column
    return OutlineButton(
        child: Text('Choose a Lecture'),
        splashColor: Colors.grey,
        onPressed: () {
          //DO something
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.grey));
  }

  Widget _createALectureButton() {
    //!!Expanded is needed so that Align uses the whole available space and not the space available within the row/column
    return OutlineButton(
        child: Text('Create a Lecture'),
        splashColor: Colors.grey,
        onPressed: () {
          //DO something
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.grey));
  }
}
