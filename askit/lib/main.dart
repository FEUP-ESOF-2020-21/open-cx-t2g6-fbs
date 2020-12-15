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
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/question_mark.jfif"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
        body: new Center(
          child: new Column(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          children: [
            new Center(
              child: 
                Stack(
                  children: [
                    Text("ASKIT",
                      style: TextStyle(
                        fontSize: 50,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 6
                          ..color = Colors.purple[900]
                        ),
                      ),
                    Text("ASKIT",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
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
              ) ,
            SizedBox(height: 45),
            new ElevatedButton(
              child: Text('Log In', style: new TextStyle(fontSize: 25)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              style: ElevatedButton.styleFrom(primary: Colors.purple[900], minimumSize: Size(120, 70), side: BorderSide(width: 3.0, color: Colors.white), shadowColor: Colors.black)
            )
          ],
        ),
          ),
        ),
      ),
    );
  }
}
