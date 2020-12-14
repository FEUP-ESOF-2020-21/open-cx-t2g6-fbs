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
    return new Scaffold(
        appBar: PreferredSize(
            // Change this argument to customize the height of the app bar
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(title: Text('HOME', style: TextStyle(fontSize: 30)))),
        body: Builder(builder: (BuildContext context) {
          return new Column(
            children: [
              new Container(
                  child:
                      Text('SELECTED LECTURE', style: TextStyle(fontSize: 20)),
                  padding: EdgeInsets.only(top: 80.0, bottom: 20)),
              new ListTile(
                title: Text(lecture.printIdAndTitle() +
                    "\n\n" +
                    lecture.printTheRest()),
              ),
              ElevatedButton(
                  child: Text('Join'),
                  onPressed: () {
                    Scaffold.of(context).showSnackBar(snackBar);
                    associateLectureWithUser().then((result) {
                      Navigator.pop(context);
                    });
                  }),
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
