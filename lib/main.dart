import 'package:flutter/material.dart';
import 'homePage.dart';
import 'addNote.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer timer = Timer(Duration(seconds: 0), () => {});
  @override
  void initState() {
    timer = new Timer(Duration(seconds: 5), () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomePage())));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(children: [
                    Image.network('https://i.pinimg.com/originals/68/f2/0b/68f20b0e1f80bb14274292f39df80bbc.jpg', width: 170, height: 350),
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                        width: 230,
                        height: 50,
                        child: RaisedButton(
                            padding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                            color: Color(0xff1321E0),
                            child: Text('Get Started', style: TextStyle(color: Colors.white)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () {
                              timer.cancel();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomePage()),
                              );
                            }))
                  ])))),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
