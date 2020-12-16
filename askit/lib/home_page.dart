import 'package:askit/lecture.dart';
import 'package:askit/add_lecture_page.dart';
import 'package:askit/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:askit/sign_in.dart';
import 'package:askit/individual_lecture_page_lecturer.dart';
import 'package:askit/individual_lecture_page_attendee.dart';

enum TypeOfLecture { previous, upcoming }
bool filterLecturer = true;
bool filterAttendee = true;
Widget temp = new Container();
List<Lecture> listOfLectures = new List();
Lecture selectedLecture;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TypeOfLecture _type = TypeOfLecture.previous;

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
        body: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      verticalDirection: VerticalDirection.down,
      children: [
        SizedBox(height: 35),
        Container(
            child: _titleText("My Lectures"), padding: EdgeInsets.all(20.0)),
        //!Important!
        //To display widgets that don't have an intrinsic width inside a row, you must nest them inside a flexible widget
        SizedBox(height: 15),
        new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            children: [
              Text("What lectures do you want to view?",
                  style: TextStyle(fontSize: 17, color: Colors.purple[900])),
              SizedBox(width: 80),
            ]),
        new Row(
          children: [
            new Flexible(
                child: RadioListTile(
              title: Text('Previous',
                  style: TextStyle(
                      color: Colors.purple[900], fontWeight: FontWeight.bold)),
              activeColor: Colors.purple[900],
              value: TypeOfLecture.previous,
              groupValue: _type,
              onChanged: (TypeOfLecture value) {
                setState(() {
                  _type = value;
                });
              },
            )),
            new Flexible(
                child: RadioListTile(
              title: Text('Upcoming',
                  style: TextStyle(
                      color: Colors.purple[900], fontWeight: FontWeight.bold)),
              activeColor: Colors.purple[900],
              value: TypeOfLecture.upcoming,
              groupValue: _type,
              onChanged: (TypeOfLecture value) {
                setState(() {
                  _type = value;
                });
              },
            ))
          ],
        ),
        SizedBox(height: 30),
        new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            children: [
              Text("Who do you want to search as?",
                  style: TextStyle(fontSize: 17, color: Colors.purple[900])),
              SizedBox(width: 115),
            ]),
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          children: [
            new Flexible(
                child: CheckboxListTile(
              title: Text('Lecturer',
                  style: TextStyle(
                      color: Colors.purple[900], fontWeight: FontWeight.bold)),
              activeColor: Colors.purple[900],
              value: filterLecturer,
              onChanged: (bool value) {
                setState(() {
                  filterLecturer = value;
                });
              },
            )),
            new Flexible(
                child: CheckboxListTile(
              title: Text('Attendee',
                  style: TextStyle(
                      color: Colors.purple[900], fontWeight: FontWeight.bold)),
              activeColor: Colors.purple[900],
              value: filterAttendee,
              onChanged: (bool value) {
                setState(() {
                  filterAttendee = value;
                });
              },
            )),
          ],
        ),
        temp,
        new Expanded(
            child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_addLectureButton(context), _signOutButton(context)],
        )),
      ],
    ));
  }

  Future getData() async {
    var timeFilter;
    if (_type == TypeOfLecture.previous) {
      timeFilter = "previous";
    } else
      timeFilter = "upcoming";

    var url = "https://web.fe.up.pt/~up201806296/database/getUserLectures.php";
    url = url +
        "?timeFilter=" +
        timeFilter +
        "&Lecturer=" +
        filterLecturer.toString() +
        "&Attendee=" +
        filterAttendee.toString() +
        "&email=" +
        email;

    var encoded = Uri.encodeFull(url);
    http.Response response = await http.get(encoded);

    listOfLectures = parseResults(response.body.toString());

    setState(() {
      if (listOfLectures.isEmpty) {
        temp = Container(
            height: 240.0,
            child: Text(
                'You have no lectures that meet your criteria.\n Try refining your search filters, sign up for an upcoming lecture or even create your own! ',
                style: TextStyle(fontSize: 15)),
            padding: EdgeInsets.only(left: 35.0, top: 50.0, right: 20.0));
      } else {
        temp = Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10),
          height: 240.0,
          child: new ListView.builder(
              itemCount: listOfLectures.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return new ListTile(
                    title: Text(listOfLectures[index].printIdAndTitle()),
                    subtitle: Text(listOfLectures[index].printTheRest()),
                    onTap: () {
                      selectedLecture = listOfLectures[index];
                      getRoleFromDatabase(selectedLecture).then((role) => {
                            role == "Lecturer"
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ViewSpecificUserLecturePageAsLecturer()))
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ViewSpecificUserLecturePageAsAttendee()))
                          });
                    });
              }),
        );
      }
    });
  }

  Widget _addLectureButton(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: OutlineButton(
          splashColor: Colors.grey,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddLecturePage()));
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          highlightElevation: 0,
          borderSide: BorderSide(color: Colors.purple[900]),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage("assets/cross.png"), height: 35.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Add Lecture',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.purple[900],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

//This function should return a list of Lectures
  List<Lecture> parseResults(String text) {
    List<String> list = text.split("\n");
    List<Lecture> result = new List();
    if (list.length == 0) return result;
    int numberOfLectures = (list.length) ~/ 7;

    int offset = 0;

    //Extract lectures depending on the filters. Time filters are being applied in the .php file
    for (int i = 1; i <= numberOfLectures; i++, offset += 7) {
      result.add(new Lecture(
          int.parse(list[offset]),
          list[offset + 1],
          list[offset + 2],
          list[offset + 3],
          int.parse(list[offset + 4]),
          int.parse(list[offset + 5]),
          list[offset + 6]));
    }

    return result;
  }

  Future<String> getRoleFromDatabase(Lecture lecture) async {
    String role;

    var url =
        "https://web.fe.up.pt/~up201806296/database/getRoleFromLecture.php";

    url = url + "?email=" + email + "&lectureId=" + lecture.getId().toString();

    var encoded = Uri.encodeFull(url);
    http.Response response = await http.get(encoded);

    role = response.body.toString();
    return role;
  }

  Widget _signOutButton(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: RaisedButton(
          onPressed: () {
            signOutGoogle();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) {
              return LoginPage();
            }), ModalRoute.withName('/'));
          },
          color: Colors.deepPurple,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
            child: Text(
              'Sign Out',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        ));
  }
}

Widget _titleText(String text) {
  return Center(
      child: Stack(
    children: [
      Text(
        text,
        style: TextStyle(
            fontSize: 50,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 6
              ..color = Colors.purple[900]),
      ),
      Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 50,
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
