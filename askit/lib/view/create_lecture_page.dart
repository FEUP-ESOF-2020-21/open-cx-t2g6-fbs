import 'package:askit/controller/sign_in.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart' as Path;

class CreateLecturePage extends StatefulWidget {
  @override
  _CreateLectureState createState() => _CreateLectureState();
}

String title;
String description;
int capacity;
File _file;

String date = "2020-01-01";

class _CreateLectureState extends State<CreateLecturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new ListView(children: [
        SizedBox(height: 35),
        _titleText("Create Lecture", 45),
        SizedBox(height: 15),
        MyCustomForm(),
      ]),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  FocusNode myFocusNode = new FocusNode();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  bool _uploadedFile = false;
  bool _uploadingFile = false;
  String _uploadedFileURL = "NULL";
  Widget _tmpWidget = new Text("No file chosen: ");
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new TextFormField(
            cursorColor: Colors.purple[900],
            decoration: InputDecoration(
                labelText: 'Enter the title',
                labelStyle: TextStyle(color: Colors.purple[900]),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: Colors.purple[900]))),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              title = value;
              return null;
            },
          ),
          new TextFormField(
            cursorColor: Colors.purple[900],
            decoration: InputDecoration(
                labelText: 'Enter the description',
                labelStyle: TextStyle(color: Colors.purple[900]),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: Colors.purple[900]))),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              description = value;
              return null;
            },
          ),
          new TextFormField(
            cursorColor: Colors.purple[900],
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a valid number';
              }
              capacity = int.parse(value);
              return null;
            },
            decoration: InputDecoration(
                labelText: 'Enter the capacity',
                labelStyle: TextStyle(color: Colors.purple[900]),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: Colors.purple[900]))),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            // Only numbers can be entered
          ),
          new Container(
            child: Text("Choose the date:\n",
                style: TextStyle(color: Colors.purple[900])),
            padding: EdgeInsets.only(top: 20),
          ),
          new Container(
            height: 60,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime(2020, 1, 1),
              onDateTimeChanged: (DateTime newDateTime) {
                date = newDateTime.year.toString() + "-";
                var month = newDateTime.month;
                if (month < 10) date += "0";
                date += month.toString() + "-";

                var day = newDateTime.day;
                if (day < 10) date += "0";
                date += day.toString();
              },
            ),
          ),
          new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            new Padding(
                padding: const EdgeInsets.only(
                    top: 50, left: 30, right: 50, bottom: 10),
                child: new Container(
                    height: 60,
                    child: ElevatedButton(
                        child: Text('Choose File',
                            style: new TextStyle(fontSize: 15)),
                        onPressed: () {
                          chooseFile();
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.purple[900],
                            minimumSize: Size(50, 50),
                            side: BorderSide(width: 3.0, color: Colors.white),
                            shadowColor: Colors.black)))),
            new Padding(
                padding: const EdgeInsets.only(
                    top: 50, left: 30, right: 30, bottom: 10),
                child: new Container(
                    height: 60,
                    child: ElevatedButton(
                        child: Text('Upload File',
                            style: new TextStyle(fontSize: 15)),
                        onPressed: !_uploadedFile ? null : () => uploadFile(),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.purple[900],
                            minimumSize: Size(50, 50),
                            side: BorderSide(width: 3.0, color: Colors.white),
                            shadowColor: Colors.black)))),
          ]),
          Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [_tmpWidget])),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
                child: ElevatedButton(
              child: Text('Submit', style: new TextStyle(fontSize: 15)),
              onPressed: _uploadingFile
                  ? null
                  : () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Creating lecture...')));
                        sendData().then((result) {
                          Navigator.pop(context);
                        });
                        //Process data
                      }
                    },
              style: ElevatedButton.styleFrom(
                  primary: Colors.purple[900],
                  minimumSize: Size(50, 50),
                  side: BorderSide(width: 3.0, color: Colors.white),
                  shadowColor: Colors.black),
            )),
          ),
        ],
      ),
    );
  }

  Future chooseFile() async {
    _file = await FilePicker.getFile();
    setState(() {
      _uploadedFile = true;
      List<String> list = _file.toString().split("/");
      String fileName = list.last;
      _tmpWidget = FittedBox(
          fit: BoxFit.fitWidth, child: new Text("File chosen: " + fileName));
    });
  }

  Future sendData() async {
    var url = "https://web.fe.up.pt/~up201806296/database/addNewLecture.php";

    url = url +
        "?title=" +
        title +
        "&description=" +
        description +
        "&capacity=" +
        capacity.toString() +
        "&date=" +
        date +
        "&email=" +
        email +
        "&fileUrl=" +
        _uploadedFileURL;

    var encoded = Uri.encodeFull(url);

    http.Response response = await http.get(encoded);
  }

  Future uploadFile() async {
    setState(() {
      _uploadingFile = true;
    });
    String fileName = Path.basename(_file.path);

    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    _formKey.currentState.validate();
    var storageRef = storage.ref().child('lectures/$title/$fileName');

    firebase_storage.UploadTask uploadTask = storageRef.putFile(_file);
    uploadTask.whenComplete(() => {
          _uploadedFileURL = fileName,
          setState(() {
            _uploadingFile = false;
          }),
        });
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
