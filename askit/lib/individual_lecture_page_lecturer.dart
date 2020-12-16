import 'package:askit/lecture.dart';
import 'package:askit/view_questions_lecturer.dart';
import 'package:flutter/material.dart';
import 'package:askit/home_page.dart';
import 'dart:core';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:ext_storage/ext_storage.dart';

class ViewSpecificUserLecturePageAsLecturer extends StatefulWidget {
  @override
  _ViewSpecificUserLectureStateAsLecturer createState() =>
      _ViewSpecificUserLectureStateAsLecturer();
}

class _ViewSpecificUserLectureStateAsLecturer
    extends State<ViewSpecificUserLecturePageAsLecturer> {
  Lecture lecture;

  _ViewSpecificUserLectureStateAsLecturer() {
    this.lecture = selectedLecture;
  }
  @override
  Widget build(BuildContext context) {
    Color _color = lecture.getFileName() != "" ? Colors.purple[900] : null;
    return Scaffold(
        backgroundColor: new Color.fromARGB(255, 190, 180, 255),
        body: new Column(children: [
          SizedBox(height: 35),
          Padding(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: _titleText(lecture.getTitle(), 40),
            )
          ),
          SizedBox(height: 35),
          new ListTile(
              title: Text(lecture.printIdAndTitle() +
                  "\n" +
                  lecture.printTheRest() +
                  "\n" +
                  "Role: Lecturer")
          ),
          SizedBox(height: 35),
          new Text("File uploaded: " +
              (lecture.getFileName() == ""
                  ? "No file uploaded"
                  : lecture.getFileName())),
          //TODO Add option in same row to upload new file and let user know whether a file is already uploaded or not
          SizedBox(height: 35),
          new Row(children: [
            new Padding(
                //TODO CENTER THIS PROPERLY

                padding: EdgeInsets.only(left: 60, right: 20),
                child: OutlineButton(
                    child: Text('Replace file'),
                    splashColor: Colors.grey,
                    onPressed: () {
                      /*TODO This must do something aka upload a file as if user was creating a lecture*/
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    highlightElevation: 0,
                    borderSide: BorderSide(color: Colors.purple[900]))),
            new OutlineButton(
                child: Text('Download files'),
                splashColor: Colors.grey,
                onPressed: lecture.getFileName() == ""
                    ? null
                    : () {
                        downloadFile();
                      },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                highlightElevation: 0,
                borderSide: BorderSide(color: Colors.purple[900]))
          ]),
          new OutlineButton(
              child: Text('View Questions'),
              splashColor: Colors.grey,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewQuestionsAsLecturer()));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              highlightElevation: 0,
              borderSide: BorderSide(color: Colors.purple[900]))
        ]));
  }

  Future downloadFile() async {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;

    var title = lecture.getTitle();
    var fileName = lecture.getFileName();
    print('lectures/$title/$fileName');
    var storageRef = storage.ref().child('lectures/$title/$fileName');

    String path = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);

    String fullPath = "$path/lecture.pdf";

    File file = new File(fullPath);
    storageRef.writeToFile(file);
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
