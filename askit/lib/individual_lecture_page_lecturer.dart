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
    return Scaffold(
        appBar: PreferredSize(
            // Change this argument to customize the height of the app bar
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(title: Text('HOME', style: TextStyle(fontSize: 30)))),
        body: new Column(children: [
          new Container(
              child: Text('SELECTED LECTURE', style: TextStyle(fontSize: 20)),
              padding: EdgeInsets.only(top: 80.0, bottom: 20)),
          new ListTile(
              title: Text(lecture.printIdAndTitle() +
                  "\n" +
                  lecture.printTheRest() +
                  "\n" +
                  "Role: Lecturer")),
          new Text("File uploaded: " +
              (lecture.getFileName() == ""
                  ? "No file uploaded"
                  : lecture.getFileName())),
          //TODO Add option in same row to upload new file and let user know whether a file is already uploaded or not
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
                    borderSide: BorderSide(color: Colors.grey))),
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
                borderSide: BorderSide(color: Colors.grey))
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
              borderSide: BorderSide(color: Colors.grey))
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
