import 'package:askit/lecture.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:askit/sign_in.dart';
import 'package:askit/lecture.dart';

class JoinSpecificLecturePage extends StatefulWidget {
  Lecture lecture;
  JoinSpecificLecturePage(Lecture lecture) {
    this.lecture = lecture;
    print(lecture.printIdAndTitle());
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
                new Container(
                    child: Text('SELECTED LECTURE',
                        style: TextStyle(fontSize: 20)),
                    padding: EdgeInsets.only(top: 80.0, bottom: 20)),
                new ListTile(
                  title: Text(lecture.printIdAndTitle() +
                      "\n\n" +
                      lecture.printTheRest()),
                ),
                _joinButton()
              ],
            )));
  }

  Widget _joinButton() {
    return OutlineButton(
        child: Text('Join'),
        splashColor: Colors.grey,
        onPressed: () {
          associateLectureWithUser();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.grey));
  }

  Future associateLectureWithUser() async {
    print("Function was called!\n");
    var url =
        "https://web.fe.up.pt/~up201806296/database/joinExistingLecture.php";
    url = url + "?email=" + email + "&lectureId=" + this.lecture.id.toString();

    var encoded = Uri.encodeFull(url);
    http.Response response = await http.get(encoded);
  }
}
