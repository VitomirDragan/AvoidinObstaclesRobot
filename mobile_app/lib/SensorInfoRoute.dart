import 'package:flutter/material.dart';
import 'dart:async';

import 'ControlsInterface.dart';
import 'BluetoothFunctionality.dart';

class SensorInfoRoute extends StatefulWidget{
  SensorInfoRouteState createState() {
    return SensorInfoRouteState();
  }
}

class SensorInfoRouteState extends State<SensorInfoRoute>{

  String _temperature = "---";
  String _humidity = "---";
  String _co = "---";

  Widget build(BuildContext context){
    new Timer(const Duration(seconds:1), (){
      setState(() {
        String aux = BluetoothFunctionality.readMessageFromBluetooth();
        _temperature = aux.substring(0, 3);
        _humidity = aux.substring(3, 6);
        _co = aux.substring(6, 7);
        print("aux " + aux);
      });
    });

    return Scaffold(
      appBar: AppBar(title: Text("Sensors"),),
      body: Container(
        child: Column(
          children: <Widget>[
            // bluetooth device
            Row(
              children: <Widget>[
                // bluetooth device information
                Column(
                  children: <Widget>[
                    Text(
                      "Connected to:",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    Text(
                      ControlsInterface.getBluetoothDeviceName(),
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),

                // reconnect
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: (){
                    BluetoothFunctionality.connect();
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),

            // automatic control
            Container(
              child: GestureDetector(
                child: Text(
                  "Automatic",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: ControlsInterface.getAutomatic() == true ? Colors.blue : Colors.black
                  ),
                ),
                onTap: (){
                  setState(() {
                    ControlsInterface.automaticPress();
                  });
                },
              ),
              padding: EdgeInsets.only(bottom: 100),
            ),

            // sensor information
            Container(
              child: Column(
                children: <Widget>[
                  sensorInterfaceBuilder("Temperature", _temperature),
                  sensorInterfaceBuilder("Humidity", _humidity),
                  Container(
                    child: Text(
                      "CO",
                      style: TextStyle(
                        fontSize: 30,
                        color: _co == "1" ? Colors.black: Colors.red
                      ),
                    ),
                    padding: EdgeInsets.only(top: 80),
                  ),
                ],
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        padding: EdgeInsets.all(20),
        alignment: Alignment.topLeft,
      )
    );
  }


  // sensor interface builder
  Container sensorInterfaceBuilder(String sensorName, String sensorValue){
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            sensorName,
            style: TextStyle(
                fontSize: 30,
            ),
          ),
          Text(
            sensorValue,
            style: TextStyle(
                fontSize: 30,
            ),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
      padding: EdgeInsets.only(top: 10, bottom: 10),
    );
  }

}