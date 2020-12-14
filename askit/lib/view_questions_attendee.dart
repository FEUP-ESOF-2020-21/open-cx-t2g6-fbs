import 'package:askit/lecture.dart';
import 'package:askit/submit_question.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:askit/home_page.dart';
import 'package:askit/sign_in.dart';
import 'dart:core';
import 'package:askit/question.dart';

enum SortingType { byNew, byHot }

class ViewQuestionsAsAttendee extends StatefulWidget {
  @override
  _ViewQuestionsAsAttendeeState createState() =>
      _ViewQuestionsAsAttendeeState();
}

class _ViewQuestionsAsAttendeeState extends State<ViewQuestionsAsAttendee> {
  Lecture lecture;
  SortingType _type = SortingType.byNew;
  Widget temp_questions = new Container();
  List<Question> listOfQuestions = new List();

  _ViewQuestionsAsAttendeeState() {
    this.lecture = selectedLecture;
  }
  @override
  Widget build(BuildContext context) {
    getQuestions();
    return Scaffold(
        appBar: PreferredSize(
            // Change this argument to customize the height of the app bar
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(title: Text('HOME', style: TextStyle(fontSize: 30)))),
        body: new Column(children: [
          new Container(
              child: Text(
                  'Questions for Lecture #' +
                      selectedLecture.getId().toString(),
                  style: TextStyle(fontSize: 20)),
              padding: EdgeInsets.only(top: 20.0, bottom: 20)),
          new Row(
            children: [
              new Flexible(
                  child: ListTile(
                      title: const Text('New'),
                      leading: Radio(
                        value: SortingType.byNew,
                        groupValue: _type,
                        onChanged: (SortingType value) {
                          setState(() {
                            _type = value;
                          });
                        },
                      ))),
              new Flexible(
                  child: ListTile(
                      title: const Text('Rating'),
                      leading: Radio(
                        value: SortingType.byHot,
                        groupValue: _type,
                        onChanged: (SortingType value) {
                          setState(() {
                            _type = value;
                          });
                        },
                      )))
            ],
          ),
          temp_questions,
          _submitQuestionButton(context),
        ]));
  }

  Future getQuestions() async {
    var url =
        "https://web.fe.up.pt/~up201806296/database/getQuestionsFromLecture.php";
    url = url + "?lectureId=" + selectedLecture.getId().toString();

    if (_type == SortingType.byHot) {
      url = url + "&sort=hot";
    } else {
      url = url + "&sort=new";
    }

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
                        onTap: () {},
                        leading: new IconButton(
                            icon: new Icon(Icons.arrow_downward,
                                color: Colors.blueAccent[200]),
                            onPressed: () {
                              downvoteQuestion(listOfQuestions[index].getId());
                            }),
                        trailing: new IconButton(
                            icon: new Icon(Icons.arrow_upward,
                                color: Colors.orange),
                            onPressed: () {
                              upvoteQuestion(listOfQuestions[index].getId());
                            }),
                      );
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

  Widget _submitQuestionButton(BuildContext context) {
    //!!Expanded is needed so that Align uses the whole available space and not the space available within the row/column
    return Expanded(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: OutlineButton(
                    child: Text('Submit Question'),
                    splashColor: Colors.grey,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SubmitQuestionPage()));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    highlightElevation: 0,
                    borderSide: BorderSide(color: Colors.grey)))));
  }

  Future upvoteQuestion(int questionId) async {
    var url = "https://web.fe.up.pt/~up201806296/database/upvoteQuestion.php";

    url = url + "?email=" + email + "&questionId=" + questionId.toString();

    var encoded = Uri.encodeFull(url);

    http.get(encoded).then((response) => {
          setState(() {
            getQuestions();
          })
        });
  }

  Future downvoteQuestion(int questionId) async {
    var url = "https://web.fe.up.pt/~up201806296/database/downvoteQuestion.php";

    url = url + "?email=" + email + "&questionId=" + questionId.toString();

    var encoded = Uri.encodeFull(url);

    http.get(encoded).then((response) => {
          setState(() {
            getQuestions();
          })
        });
  }
}
