import 'package:flutter/material.dart';
import 'ControlsInterface.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Robot Remote',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Robot Remote"),),
        body: ControlsInterface(),
      )
    );
  }
}