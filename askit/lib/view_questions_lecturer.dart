import 'package:askit/lecture.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:askit/home_page.dart';
import 'dart:core';
import 'package:askit/question.dart';

class ViewQuestionsAsLecturer extends StatefulWidget {
  @override
  _ViewQuestionsAsLecturerState createState() =>
      _ViewQuestionsAsLecturerState();
}

class _ViewQuestionsAsLecturerState extends State<ViewQuestionsAsLecturer> {
  Lecture lecture;
  Widget temp_questions = new Container();
  List<Question> listOfQuestions = new List();

  _ViewQuestionsAsLecturerState() {
    getQuestions();
    this.lecture = selectedLecture;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: new Color.fromARGB(255, 190, 180, 255),
        body: new Column(children: [
          SizedBox(height: 35),
          FittedBox(
              fit: BoxFit.fitWidth,
              child:  _titleText("Questions for Lecture #" + selectedLecture.getId().toString(), 50),
            ),
          SizedBox(height: 35),
          temp_questions
        ]));
  }

  Future getQuestions() async {
    var url =
        "https://web.fe.up.pt/~up201806296/database/getQuestionsFromLecture.php";
    url =
        url + "?lectureId=" + selectedLecture.getId().toString() + "&sort=hot";

    var encoded = Uri.encodeFull(url);

    http.get(encoded).then((response) => {
          listOfQuestions = parseQuestions(response.body.toString()),
          setState(() {
            if (listOfQuestions.isEmpty) {
              temp_questions = Container(
                  child: Text('This lecture has no questions yet',
                      style: TextStyle(fontSize: 15)),
                  padding: EdgeInsets.only(left: 35.0, top: 50.0, right: 20.0));
            } else {
              temp_questions = Container(
                padding: EdgeInsets.all(10.0),
                height: 300.0,
                child: new ListView.builder(
                    itemCount: listOfQuestions.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return new ListTile(
                          title:
                              Text(listOfQuestions[index].printIdAndQuestion()),
                          subtitle: Text("Slide: " +
                              listOfQuestions[index].getSlide().toString() +
                              "\nRating: " +
                              listOfQuestions[index].getRating().toString()),
                          onTap: () {});
                    }),
              );
            }
          })
        });
  }

  List<Question> parseQuestions(String text) {
    List<String> list = text.split("\n");

    List<Question> result = new List();
    if (list.length == 0) return result;

    int numberOfQuestions = (list.length) ~/ 4;

    int offset = 0;

    for (int i = 1; i <= numberOfQuestions; i++, offset += 4) {
      result.add(new Question(int.parse(list[offset]), list[offset + 1],
          int.parse(list[offset + 2]), int.parse(list[offset + 3])));
    }

    return result;
  }
}

Widget _titleText(String text, double size) {
  return Center(
    child: 
      Stack(
        children: [
          Text(text,
            style: TextStyle(
              fontSize: size,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 6
                ..color = Colors.purple[900]
              ),
            ),
          Text(text,
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
      )
  );
}
