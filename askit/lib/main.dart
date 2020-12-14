import 'package:askit/login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //Root of application
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Askit',
      home: new HomePageWidget(),
    );
  }
}

/// Opens an [AlertDialog] showing what the user typed.
class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key}) : super(key: key);
  @override
  _HomePageWidgetState createState() => new _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Welcome to Askit!'),
        backgroundColor: Colors.purple[900],
      ),
      body: new Center(
          child: ElevatedButton(
        child: Text('Log in'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
      )),
    );
  }
}
