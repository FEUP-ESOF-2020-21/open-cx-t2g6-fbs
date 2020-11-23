import 'package:askit/question.dart';
import 'package:askit/sign_in.dart';
import 'package:flutter/material.dart';

enum TypeOfLecture { previous, upcoming }

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  TypeOfLecture _type = TypeOfLecture.previous;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.purple[900]),
        home: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.0), // here the desired height
                child: AppBar(
                    title: Text('HOME!', style: TextStyle(fontSize: 30)))),
            body: new Column(
              children: [
                Container(
                  child: Text('MY LECTURES', style: TextStyle(fontSize: 20)),
                  padding: EdgeInsets.all(20.0),
                ),
                Column(
                  children: [
                    ListTile(
                        title: const Text('Previous'),
                        leading: Radio(
                          value: TypeOfLecture.previous,
                          groupValue: _type,
                          onChanged: (TypeOfLecture value) {
                            setState(() {
                              _type = value;
                            });
                          },
                        )),
                    ListTile(
                        title: const Text('Upcoming'),
                        leading: Radio(
                          value: TypeOfLecture.upcoming,
                          groupValue: _type,
                          onChanged: (TypeOfLecture value) {
                            setState(() {
                              _type = value;
                            });
                          },
                        ))
                  ],
                )
              ],
            )));
  }

  Widget _testButton() {
    return OutlineButton(
        splashColor: Colors.grey,
        onPressed: () {
          print('Hello World!');
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.grey));
  }
}
