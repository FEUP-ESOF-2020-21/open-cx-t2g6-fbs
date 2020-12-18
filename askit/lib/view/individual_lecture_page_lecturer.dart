import 'package:askit/model/lecture.dart';
import 'package:askit/view/view_questions_lecturer.dart';
import 'package:flutter/material.dart';
import 'package:askit/view/home_page.dart';
import 'dart:core';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:ext_storage/ext_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as Path;

File _file;

class ViewSpecificUserLecturePageAsLecturer extends StatefulWidget {
  @override
  _ViewSpecificUserLectureStateAsLecturer createState() =>
      _ViewSpecificUserLectureStateAsLecturer();
}

class _ViewSpecificUserLectureStateAsLecturer
    extends State<ViewSpecificUserLecturePageAsLecturer> {
  Lecture lecture;

  final globalKey = GlobalKey<ScaffoldState>();
  _ViewSpecificUserLectureStateAsLecturer() {
    this.lecture = selectedLecture;
  }

  //TODO ADD RADIO BUTTONS TO CHANGE STATUS
  @override
  Widget build(BuildContext context) {
    Color _color = lecture.getFileName() != "" ? Colors.purple[900] : null;
    return Scaffold(
        key: globalKey,
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
                  "Role: Lecturer")),
          SizedBox(height: 35),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: new Text("File uploaded: " +
                (lecture.getFileName() == ""
                    ? "No file uploaded"
                    : lecture.getFileName())),
          ),
          SizedBox(height: 35),
          new Row(children: [
            new Padding(
                padding: EdgeInsets.only(left: 60, right: 20),
                child: OutlineButton(
                    child: Text('Replace file',
                        style: TextStyle(color: Colors.purple[900])),
                    splashColor: Colors.grey,
                    onPressed: () {
                      chooseFile();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    highlightElevation: 0,
                    borderSide: BorderSide(color: Colors.purple[900]))),
            new OutlineButton(
                child: Text('Download files', style: TextStyle(color: _color)),
                splashColor: Colors.grey,
                onPressed: lecture.getFileName() == ""
                    ? null
                    : () {
                        final snackBar =
                            SnackBar(content: Text('Downloading file...'));
                        globalKey.currentState.showSnackBar(snackBar);
                        downloadFile();
                      },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                highlightElevation: 0,
                borderSide: BorderSide(color: Colors.purple[900]))
          ]),
          new OutlineButton(
              child: Text('View Questions',
                  style: TextStyle(color: Colors.purple[900])),
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
    var storageRef = storage.ref().child('lectures/$title/$fileName');

    String path = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);

    String fullPath = "$path/lecture.pdf";

    File file = new File(fullPath);
    storageRef.writeToFile(file);
  }

  Future chooseFile() async {
    _file = await FilePicker.getFile();
    if (_file != null) {
      uploadFile();
    }
  }

  Future uploadFile() async {
    String fileName = Path.basename(_file.path);
    String title = this.lecture.getTitle();
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    var storageRef = storage.ref().child('lectures/$title/$fileName');

    firebase_storage.UploadTask uploadTask = storageRef.putFile(_file);
    uploadTask.whenComplete(() => {
          setState(() {
            lecture.setFileName(fileName);
            editLectureFile();
          }),
        });
  }

  Future editLectureFile() async {
    var url = "https://web.fe.up.pt/~up201806296/database/editLectureFile.php";

    url = url +
        "?lectureId=" +
        lecture.getId().toString() +
        "&fileUrl=" +
        lecture.getFileName();

    var encoded = Uri.encodeFull(url);
    await http.get(encoded);
  }
}

Future updateStatus(int newStatus) async {
  var url = "https://web.fe.up.pt/~up201806296/database/editLectureStatus.php";

  url = url +
      "?status=" +
      newStatus.toString() +
      "&lectureId=" +
      selectedLecture.getId().toString();

  var encoded = Uri.encodeFull(url);

  http.get(encoded);
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
