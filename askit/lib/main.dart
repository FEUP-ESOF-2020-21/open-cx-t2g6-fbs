// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'question.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Welcome to Askit!'),
        backgroundColor: Colors.black54,
      ),
      body: new Center(
          child: ElevatedButton(
            child: Text('Log in'),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Question()),
              );
            },
          )
      ),
    );
  }
}