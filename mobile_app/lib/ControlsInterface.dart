import 'package:flutter/material.dart';

class ControlsInterface extends StatefulWidget{
  _ControlsState createState() {
    return _ControlsState();
  }
}

class _ControlsState extends State<ControlsInterface>{

  String _connectedDevice = "none";
  bool _up = false;
  bool _down = false;
  bool _left = false;
  bool _right = false;

  /// build function
  Widget build(BuildContext context){
    return Container(
        child: Column(
          children: <Widget>[
            Row(

              // system information
              children: <Widget>[

                // connected device information
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Connected to:",
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                      Text(
                        _connectedDevice,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  //padding: EdgeInsets.only(top: 20),
                ),

                // controls information
                Container(
                  child: Column(
                    children: <Widget>[
                      Text("Up: " + _up.toString()),
                      Text("Down: " + _down.toString()),
                      Text("Left: " + _left.toString()),
                      Text("Right: " + _right.toString()),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            
            // actual controls section
            Container(
              child: Row(
                children: <Widget>[
                  // up down keys
                  Column(
                    children: <Widget>[
                      GestureDetector(
                        child: buildArrowIcons(Icons.arrow_drop_up, _up),
                        onTapDown: _upPress,
                        onTapUp: _upRelease,
                      ),
                      GestureDetector(
                        child: buildArrowIcons(Icons.arrow_drop_down, _down),
                        onTapDown: _downPress,
                        onTapUp: _downRelease,
                      ),
                    ],
                  ),

                  // left right keys
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        child: buildArrowIcons(Icons.arrow_left, _left),
                        onTapDown: _leftPress,
                        onTapUp: _leftRelease,
                      ),
                      GestureDetector(
                        child: buildArrowIcons(Icons.arrow_right, _right),
                        onTapDown: _rightPress,
                        onTapUp: _rightRelease,
                      ),
                    ],
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              padding: EdgeInsets.only(left: 5, right: 5),
            ),
            Container()
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween
        )
    );
  }


  /// icon builder function
  IconButton buildArrowIcons(IconData icon, bool source){
    return IconButton(
      icon: Icon(icon, color: source ? Colors.blue : Colors.blueGrey),
      iconSize: 100,
    );
  }


  /// control functions
  // up
  void _upPress(TapDownDetails t){
    setState(() {
      if(_down){
        _up = _down = false;
      }else{
        _up = true;
      }
    });
  }

  void _upRelease(TapUpDetails t){
    setState(() {
      _up = false;
    });
  }


  // down
  void _downPress(TapDownDetails t){
    setState(() {
      if(_up){
        _up = _down = false;
      }else{
        _down = true;
      }
    });
  }

  void _downRelease(TapUpDetails t){
    setState(() {
      _down = false;
    });
  }


  // left
  void _leftPress(TapDownDetails t){
    setState(() {
      if(_right){
        _left = _right = false;
      }else{
        _left = true;
      }
    });
  }

  void _leftRelease(TapUpDetails t){
    setState(() {
      _left = false;
    });
  }


  // right
  void _rightPress(TapDownDetails t){
    setState(() {
      if(_left){
        _left = _right = false;
      }else{
        _right = true;
      }
    });
  }

  void _rightRelease(TapUpDetails t){
    setState(() {
      _right = false;
    });
  }
}