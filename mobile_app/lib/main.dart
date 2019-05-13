import 'package:flutter/material.dart';
import 'ControlsInterface.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("started app");

    return MaterialApp(
      title: 'Robot Remote',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ControlsInterface(),
    );
  }

  /*void _pushInfo(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(   // Add 20 lines from here...
        builder: (BuildContext context) {
          ControlsInterface();

          final Iterable<ListTile> tiles = _saved.map(
                (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          )
              .toList();
        },
      )
    );
  }*/

}