import 'package:askit/choose_lecture_page.dart';
import 'package:askit/sign_in.dart';
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
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.purple[900]),
        home: Scaffold(
          appBar: PreferredSize(
              // Change this argument to customize the height of the app bar
              preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                  title:
                      Text('CREATE LECTURE', style: TextStyle(fontSize: 30)))),
          body: new ListView(children: [
            MyCustomForm(),
          ]),
        ));
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
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
            decoration: InputDecoration(labelText: 'Enter the title'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              title = value;
              return null;
            },
          ),
          new TextFormField(
            decoration: InputDecoration(labelText: 'Enter the description'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              description = value;
              return null;
            },
          ),
          new TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a valid number';
              }
              capacity = int.parse(value);
              return null;
            },
            decoration: new InputDecoration(labelText: "Enter the capacity"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            // Only numbers can be entered
          ),
          new Container(
            child: Text("Choose the date:\n"),
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
          new Row(children: [
            new Padding(
                padding: const EdgeInsets.only(
                    top: 50, left: 50, right: 50, bottom: 10),
                child: new Container(
                  height: 60,
                  child: ElevatedButton(
                    child: Text('Choose File'),
                    onPressed: chooseFile,
                  ),
                )),
            new Padding(
                padding: const EdgeInsets.only(top: 50),
                child: new Container(
                  height: 60,
                  child: ElevatedButton(
                    child: Text('Upload File'),
                    onPressed: !_uploadedFile ? null : () => uploadFile(),
                  ),
                ))
          ]),
          Padding(
              padding: const EdgeInsets.only(left: 50, top: 10),
              child: new Row(children: [_tmpWidget])),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
                child: ElevatedButton(
              onPressed: _uploadingFile
                  ? null
                  : () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        print(title);
                        print(description);
                        print(capacity);
                        print(date);
                        // If the form is valid, display a Snackbar.
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
                        sendData();
                        //Process data
                      }
                    },
              child: Text('Submit'),
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
      _tmpWidget = new Text("File chosen: " + fileName);
      print(_uploadedFile);
    });
  }

  Future sendData() async {
    print("Function was called!\n");
    print("File url:" + _uploadedFileURL);
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

    print(encoded + "\n");

    http.Response response = await http.get(encoded);
    print(response.body.toString);
  }

  Future uploadFile() async {
    setState(() {
      _uploadingFile = true;
    });
    print("Upload button pressed!");
    print(_uploadingFile);
    String fileName = Path.basename(_file.path);

    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    var storageRef = storage.ref().child('lectures/$title/$fileName');

    firebase_storage.UploadTask uploadTask = storageRef.putFile(_file);
    uploadTask.whenComplete(() => {
        _uploadedFileURL = fileName
      });
  }
}
