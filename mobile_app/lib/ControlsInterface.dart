import 'package:flutter/material.dart';

import 'BluetoothFunctionality.dart';
import 'SensorInfoRoute.dart';

enum _messageToSend{
  stop,
  automatic,

  up,
  down,
  left,
  right,

  up_left,
  up_right,
  down_left,
  down_right
}

class ControlsInterface extends StatefulWidget{
  _ControlsState createState() {
    return _ControlsState();
  }

  /// push secondPage
  static void pushSecondPage(){
    _ControlsState.pushSecondPage();
  }


  // get bluetooth device name
  static String getBluetoothDeviceName(){
    return _ControlsState.getBluetoothDeviceName();
  }

  static bool getAutomatic(){
    return _ControlsState.automatic;
  }

  static void automaticPress(){
    _ControlsState._automaticPress();
  }

}

class _ControlsState extends State<ControlsInterface>{

  static BluetoothFunctionality _bluetoothDevice = new BluetoothFunctionality();

  static bool _up = false;
  static bool _down = false;
  static bool _left = false;
  static bool _right = false;
  static bool automatic = false;
  static BuildContext _context;


  /// build function
  Widget build(BuildContext context){
    _context = context;

    return Scaffold(
      appBar: AppBar(
        title: Text("Robot Remote"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.list),
              onPressed: ControlsInterface.pushSecondPage
          ),
        ],
      ),
      body: Container(
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
                        child: buildArrowIcons(Icons.font_download, automatic, 60),
                        onTapDown: automaticPress,
                      ),
                    ),

                    // controls information
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text("Automatic: " + automatic.toString()),
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
  void automaticPress(TapDownDetails t){
    setState(() {
      _automaticPress();
    });
  }

  static void _automaticPress(){
    automatic = !automatic;

    if(automatic){
      _up = _down = _left = _right = false;
    }

    _sendMessage();
  }


  // up
  void _upPress(TapDownDetails t){
    setState(() {
      if(!automatic) {
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

    if(!automatic) {
      _sendMessage();
    }
  }


  // down
  void _downPress(TapDownDetails t){
    setState(() {
      if(!automatic) {
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


    if(!automatic) {
      _sendMessage();
    }
  }


  // left
  void _leftPress(TapDownDetails t){
    setState(() {
      if(!automatic) {
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

    if(!automatic) {
      _sendMessage();
    }
  }


  // right
  void _rightPress(TapDownDetails t){
    setState(() {
      if(!automatic) {
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

    if(!automatic) {
      _sendMessage();
    }
  }


  /// send message
  static void _sendMessage(){
    var aux;

    // automatic
    if(automatic){
      aux = _messageToSend.automatic;
    }

    else{

      // up
      if(_up){
        if(_left){
          aux = _messageToSend.up_left;
        }else if(_right){
          aux = _messageToSend.up_right;
        }else{
          aux = _messageToSend.up;
        }
      }

      // down
      else if(_down){
        if(_left){
          aux = _messageToSend.down_left;
        }else if(_right){
          aux = _messageToSend.down_right;
        }else{
          aux = _messageToSend.down;
        }
      }

      // just left or right
      else if(_left){
        aux = _messageToSend.left;
      }else if(_right){
        aux = _messageToSend.right;
      }

      // stop
      else{
        aux = _messageToSend.stop;
      }

    }

    _bluetoothDevice.sendMessageViaBluetooth(aux.index.toString());
    print("printed: " + aux.toString() + " - " + aux.index.toString());
  }


  /// push secondPage
  static void pushSecondPage(){
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (context) => SensorInfoRoute()),
    );
  }


  // get bluetooth device name
  static String getBluetoothDeviceName(){
    return _bluetoothDevice.getBluetoothDeviceName();
  }

}