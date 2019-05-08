import 'package:flutter/material.dart';
import 'BluetoothFunctionality.dart';

class ControlsInterface extends StatefulWidget{
  _ControlsState createState() {
    return _ControlsState();
  }
}

class _ControlsState extends State<ControlsInterface>{

  BluetoothFunctionality _bluetoothDevice = new BluetoothFunctionality();

  bool _up = false;
  bool _down = false;
  bool _left = false;
  bool _right = false;
  bool _automatic = false;


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
                        _bluetoothDevice.getBluetoothDeviceName(),
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

                Container(
                  child: GestureDetector(
                    child: buildArrowIcons(Icons.font_download, _automatic, 60),
                    onTapDown: _automaticPress,
                  ),
                ),

                // controls information
                Container(
                  child: Column(
                    children: <Widget>[
                      Text("Automatic: " + _automatic.toString()),
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
  IconButton buildArrowIcons(IconData icon, bool source, [double size = 80]){
    return IconButton(
      icon: Icon(icon, color: source ? Colors.blue : Colors.blueGrey),
      iconSize: size,
      onPressed: null,
    );
  }


  /// control functions
  // automatic
  void _automaticPress(TapDownDetails t){
    setState(() {
      _automatic = !_automatic;

      if(_automatic){
        _up = _down = _left = _right = false;
      }
    });

    _sendMessage();
  }


  // up
  void _upPress(TapDownDetails t){
    setState(() {
      if(!_automatic) {
        if (_down) {
          _up = _down = false;
        } else {
          _up = true;
        }

        _sendMessage();
      }
    });
  }

  void _upRelease(TapUpDetails t){
    setState(() {
      _up = false;
    });

    if(!_automatic) {
      _sendMessage();
    }
  }


  // down
  void _downPress(TapDownDetails t){
    setState(() {
      if(!_automatic) {
        if (_up) {
          _up = _down = false;
        } else {
          _down = true;
        }

        _sendMessage();
      }
    });
  }

  void _downRelease(TapUpDetails t){
    setState(() {
      _down = false;
    });


    if(!_automatic) {
      _sendMessage();
    }
  }


  // left
  void _leftPress(TapDownDetails t){
    setState(() {
      if(!_automatic) {
        if (_right) {
          _left = _right = false;
        } else {
          _left = true;
        }

        _sendMessage();
      }
    });
  }

  void _leftRelease(TapUpDetails t){
    setState(() {
      _left = false;
    });

    if(!_automatic) {
      _sendMessage();
    }
  }


  // right
  void _rightPress(TapDownDetails t){
    setState(() {
      if(!_automatic) {
        if (_left) {
          _left = _right = false;
        } else {
          _right = true;
        }

        _sendMessage();
      }
    });
  }

  void _rightRelease(TapUpDetails t){
    setState(() {
      _right = false;
    });

    if(!_automatic) {
      _sendMessage();
    }
  }


  /// send message
  void _sendMessage(){
    String aux = _automatic == true ? "1" : "0";

    if(!_automatic) {
      aux += _up == true ? '1' : '0';
      aux += _down == true ? '1' : '0';
      aux += _left == true ? '1' : '0';
      aux += _right == true ? '1' : '0';
    }else{
      aux += "0000";
    }

    _bluetoothDevice.sendMessageViaBluetooth(aux);
  }
}