import 'package:askit/lecture.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:askit/sign_in.dart';
import 'package:askit/join_specific_lecture_page.dart';

enum FilterAvailableLectures { all, available }
int numberOfResults = 0;
Widget temp = new Container();
List<Lecture> listOfLectures = new List();

class ChooseLecturePage extends StatefulWidget {
  @override
  _ChooseLectureState createState() => _ChooseLectureState();
}

class _ChooseLectureState extends State<ChooseLecturePage> {
  FilterAvailableLectures _filter = FilterAvailableLectures.available;
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
        appBar: PreferredSize(
            // Change this argument to customize the height of the app bar
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
                title: Text('CHOOSE LECTURE', style: TextStyle(fontSize: 30)))),
        body: new Column(
          children: [
            Container(
                child: Text('CHOOSE A LECTURE', style: TextStyle(fontSize: 20)),
                padding: EdgeInsets.all(20.0)),
            //!Important!
            //To display widgets that don't have an intrinsic width inside a row, you must nest them inside a flexible widget
            new Row(
              children: [
                new Flexible(
                    child: ListTile(
                        title: const Text('All'),
                        leading: Radio(
                          value: FilterAvailableLectures.all,
                          groupValue: _filter,
                          onChanged: (FilterAvailableLectures value) {
                            setState(() {
                              _filter = value;
                            });
                          },
                        ))),
                new Flexible(
                    child: ListTile(
                        title: const Text('Available'),
                        leading: Radio(
                          value: FilterAvailableLectures.available,
                          groupValue: _filter,
                          onChanged: (FilterAvailableLectures value) {
                            setState(() {
                              _filter = value;
                            });
                          },
                        )))
              ],
            ),
            temp,
          ],
        ));
  }

  Future getData() async {
    var availabilityFilter;
    if (_filter == FilterAvailableLectures.all) {
      availabilityFilter = "all";
    } else
      availabilityFilter = "available";

    var url =
        "https://web.fe.up.pt/~up201806296/database/getUpcomingLectures.php";
    url = url + "?availabilityFilter=" + availabilityFilter + "&email=" + email;
    http.Response response = await http.get(url);
    listOfLectures = parseResults(response.body.toString());

    setState(() {
      if (listOfLectures.isEmpty) {
        temp = Container(
            child: Text(
                'There are no lectures that meet your criteria! Please change them or try again later!',
                style: TextStyle(fontSize: 15)),
            padding: EdgeInsets.only(left: 35.0, top: 50.0, right: 20.0));
      } else {
        temp = Container(
          padding: EdgeInsets.all(10.0),
          height: 300.0,
          child: new ListView.builder(
              itemCount: listOfLectures.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return new ListTile(
                    title: Text(listOfLectures[index].printIdAndTitle()),
                    subtitle:
                        Text(listOfLectures[index].printDateAndCapacity()),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                JoinSpecificLecturePage(listOfLectures[index])),
                      );
                    });
              }),
        );
      }
    });
  }

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
}
