import 'package:askit/lecture.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:askit/sign_in.dart';

class JoinSpecificLecturePage extends StatefulWidget {
  Lecture lecture;
  JoinSpecificLecturePage(Lecture lecture) {
    this.lecture = lecture;
  }
  @override
  _JoinSpecificLectureState createState() => _JoinSpecificLectureState(lecture);
}

class _JoinSpecificLectureState extends State<JoinSpecificLecturePage> {
  Lecture lecture;

  _JoinSpecificLectureState(Lecture lecture) {
    this.lecture = lecture;
  }
  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(content: Text('Joining lecture...'));
    return new Scaffold(body: Builder(builder: (BuildContext context) {
      return new Column(
        children: [
          SizedBox(height: 35),
          _titleText("Selected Lecture", 40),
          SizedBox(height: 35),
          new ListTile(
            title: Text(
                lecture.printIdAndTitle() + "\n\n" + lecture.printTheRest()),
          ),
          SizedBox(height: 35),
          ElevatedButton(
              child: Text('Join', style: new TextStyle(fontSize: 25)),
              onPressed: () {
                Scaffold.of(context).showSnackBar(snackBar);
                associateLectureWithUser().then((result) {
                  Navigator.pop(context);
                });
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.purple[900],
                  minimumSize: Size(120, 70),
                  side: BorderSide(width: 3.0, color: Colors.white),
                  shadowColor: Colors.black)),
        ],
      );
    }));
  }

  Future associateLectureWithUser() async {
    var url =
        "https://web.fe.up.pt/~up201806296/database/joinExistingLecture.php";
    url = url + "?email=" + email + "&lectureId=" + this.lecture.id.toString();

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
