import 'package:flutter/material.dart';
import 'package:askit/view/create_lecture_page.dart';
import 'package:askit/view/choose_lecture_page.dart';

class AddLecturePage extends StatefulWidget {
  @override
  _AddLectureState createState() => _AddLectureState();
}

class _AddLectureState extends State<AddLecturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Column(
      children: [
        SizedBox(height: 35),
        _titleText("Add Lecture", 50),
        SizedBox(height: 35),
        _chooseALectureButton(context),
        SizedBox(height: 25),
        _createALectureButton(context)
      ],
    ));
  }

  Widget _chooseALectureButton(BuildContext context) {
    //!!Expanded is needed so that Align uses the whole available space and not the space available within the row/column
    return Container(
        child: ButtonTheme(
            height: 250.0,
            child: OutlineButton(
                child: _titleText("Choose a Lecture", 30),
                splashColor: Colors.purple[900],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChooseLecturePage()),
                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                highlightElevation: 0,
                borderSide: BorderSide(color: Colors.purple[900])),
            padding: EdgeInsets.only(top: 20, bottom: 20)));
  }

  Widget _createALectureButton(BuildContext context) {
    //!!Expanded is needed so that Align uses the whole available space and not the space available within the row/column
    return Container(
        child: ButtonTheme(
            height: 250.0,
            child: OutlineButton(
                child: _titleText("Create a Lecture", 30),
                splashColor: Colors.purple[900],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateLecturePage()),
                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                highlightElevation: 0,
                borderSide: BorderSide(color: Colors.purple[900])),
            padding: EdgeInsets.only(top: 20, bottom: 20)));
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
