import 'dart:io';
import 'package:askit/lecture.dart';
import 'package:askit/view_questions_attendee.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:askit/home_page.dart';
import 'dart:core';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class ViewSpecificUserLecturePageAsAttendee extends StatefulWidget {
  @override
  _ViewSpecificUserLectureStateAsAttendee createState() =>
      _ViewSpecificUserLectureStateAsAttendee();
}

class _ViewSpecificUserLectureStateAsAttendee
    extends State<ViewSpecificUserLecturePageAsAttendee> {
  Lecture lecture;

  _ViewSpecificUserLectureStateAsAttendee() {
    this.lecture = selectedLecture;
  }
  @override
  Widget build(BuildContext context) {
    Color _color = lecture.getFileName() != "" ? Colors.purple[900] : null;
    return Scaffold(
        body: new Column(children: [
      SizedBox(height: 35),
      Padding(
          padding: EdgeInsets.only(right: 10, left: 10),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: _titleText(lecture.getTitle(), 40),
          )),
      SizedBox(height: 35),
      new ListTile(
          title: Text(lecture.printIdAndTitle() +
              "\n" +
              lecture.printTheRest() +
              "\n" +
              "Role: Attendee")),
      SizedBox(height: 35),
      new Text("File uploaded: " +
          (lecture.getFileName() == ""
              ? "No file uploaded"
              : lecture.getFileName())),
      SizedBox(height: 35),
      new OutlineButton(
          child: Text('Download files', style: TextStyle(color: _color)),
          splashColor: Color.fromARGB(255, 190, 180, 255),
          onPressed: lecture.getFileName() == ""
              ? null
              : () {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Downloading file...')));
                  downloadFile();
                },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          highlightElevation: 0,
          borderSide: BorderSide(color: Colors.purple[900])),
      new OutlineButton(
          child: Text('View Questions',
              style: TextStyle(color: Colors.purple[900])),
          splashColor: Color.fromARGB(255, 190, 180, 255),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewQuestionsAsAttendee()));
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
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

    final directory = await DownloadsPathProvider.downloadsDirectory;
    final path = '${directory.path}/lecture.pdf';

    String url = await storageRef.getDownloadURL();
    var data = await http.get(url);
    var bytes = data.bodyBytes;

    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    File file = new File(path);
    file.writeAsBytes(bytes);
  }
}

Widget _titleText(String text, double size) {
  return Center(
      child: Stack(
    children: [
      Text(
        text,
        style: TextStyle(
            fontSize: size,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 6
              ..color = Colors.purple[900]),
      ),
      Text(
        text,
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
  ));
}
