

import 'package:askit/login_page.dart';
import 'package:askit/sign_in.dart';
import 'package:flutter/material.dart';


class Question extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: new ExampleWidget(),
    );
  }
}

/// Opens an [AlertDialog] showing what the user typed.
class ExampleWidget extends StatefulWidget {
  ExampleWidget({Key key}) : super(key: key);
  @override
  _ExampleWidgetState createState() => new _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Welcome to Askit!'),
        backgroundColor: Colors.black54,
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new TextField(
            minLines : 4,
            maxLines : 6,
            controller: _controller,
            decoration: new InputDecoration(
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0)
              ),
              hintText: 'Ask a question',
            ),
          ),
          new RaisedButton(
            onPressed: () {
              showDialog(
                context: context,
                child: new AlertDialog(
                  title: new Text('What you typed'),
                  content: new Text(_controller.text),
                ),
              );
              /*
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
              */
            },
            child: new Text('DONE'),
          ),
          RaisedButton(
            onPressed: () {
              signOutGoogle();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
            },
            color: Colors.deepPurple,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Sign Out',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40)),
          )
        ],
      ),
    );
  }
}