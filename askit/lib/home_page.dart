import 'package:askit/question.dart';
import 'package:askit/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum TypeOfLecture { previous, upcoming }
bool filterLecturer = true;
bool filterAttendee = true;
int numberOfResults = 0;
Widget temp = new Container();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TypeOfLecture _type = TypeOfLecture.previous;

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
                    child: Text('MY LECTURES', style: TextStyle(fontSize: 20)),
                    padding: EdgeInsets.all(20.0)),
                //!Important!
                //To display widgets that don't have an intrinsic width inside a row, you must nest them inside a flexible widget
                new Row(
                  children: [
                    new Flexible(
                        child: ListTile(
                            title: const Text('Previous'),
                            leading: Radio(
                              value: TypeOfLecture.previous,
                              groupValue: _type,
                              onChanged: (TypeOfLecture value) {
                                setState(() {
                                  _type = value;
                                });
                              },
                            ))),
                    new Flexible(
                        child: ListTile(
                            title: const Text('Upcoming'),
                            leading: Radio(
                              value: TypeOfLecture.upcoming,
                              groupValue: _type,
                              onChanged: (TypeOfLecture value) {
                                setState(() {
                                  _type = value;
                                });
                              },
                            )))
                  ],
                ),
                new Row(
                  children: [
                    new Flexible(
                        child: ListTile(
                            title: const Text('Lecturer'),
                            leading: Checkbox(
                              value: filterLecturer,
                              onChanged: (bool value) {
                                setState(() {
                                  filterLecturer = value;
                                });
                              },
                            ))),
                    new Flexible(
                        child: ListTile(
                            title: const Text('Attendee'),
                            leading: Checkbox(
                              value: filterAttendee,
                              onChanged: (bool value) {
                                setState(() {
                                  filterAttendee = value;
                                });
                              },
                            )))
                  ],
                ),
                _searchButton(),
                temp,
                _addLectureButton(),
              ],
            )));
  }

  void _displayResults() {
    setState(() {
      if (numberOfResults % 2 == 0) {
        temp = Container(
            child: Text(
                'You have no lectures that meet your criteria.\n Try refining your search filters, sign up for an upcoming lecture or even create your own! ',
                style: TextStyle(fontSize: 15)),
            padding: EdgeInsets.only(left: 35.0, top: 50.0, right: 20.0));
      } else
        temp = Container(
            child: Text('You have lectures that meet your criteria! ',
                style: TextStyle(fontSize: 15)),
            padding: EdgeInsets.only(left: 35.0, top: 50.0, right: 20.0));
    });
  }

  Widget _searchButton() {
    return OutlineButton(
        child: Text('Search'),
        splashColor: Colors.grey,
        onPressed: () {
          //Must filter all lectures that match the filters
          //display
          getData();
          //_displayResults();
          numberOfResults++;
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.grey));
  }

  Future getData() async {
    print("Function was called!\n");
    var timeFilter;
    if (_type == TypeOfLecture.previous) {
      timeFilter = "previous";
    } else
      timeFilter = "upcoming";

    var url = "https://web.fe.up.pt/~up201806296/database/get.php";
    url = url +
        "?timeFilter=" +
        timeFilter +
        "&Lecturer=" +
        filterLecturer.toString() +
        "&Attendee=" +
        filterAttendee.toString();
    http.Response response = await http.get(url);
    print(response.body);

    setState(() {
      temp = Container(
          child: Text(response.body, style: TextStyle(fontSize: 15)),
          padding: EdgeInsets.only(left: 35.0, top: 50.0, right: 20.0));
    });
  }
}

Widget _addLectureButton() {
  //!!Expanded is needed so that Align uses the whole available space and not the space available within the row/column
  return Expanded(
      child: Align(
          alignment: Alignment.bottomCenter,
          child: OutlineButton(
              child: Text('Add Lecture'),
              splashColor: Colors.grey,
              onPressed: () {
                //DO something
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              highlightElevation: 0,
              borderSide: BorderSide(color: Colors.grey))));
}
