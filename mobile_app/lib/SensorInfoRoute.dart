import 'package:flutter/material.dart';

import 'ControlsInterface.dart';
import 'BluetoothFunctionality.dart';

class SensorInfoRoute extends StatefulWidget{
  SensorInfoRouteState createState() {
    return SensorInfoRouteState();
  }
}

class SensorInfoRouteState extends State<SensorInfoRoute>{
  Widget build(BuildContext context){
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
              padding: EdgeInsets.only(bottom: 200),
            ),

            // sensor information
            Container(
              child: Column(
                children: <Widget>[
                  sensorInterfaceBuilder("CO", 11),
                  sensorInterfaceBuilder("Light", 123),
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
  Container sensorInterfaceBuilder(String sensorName, int sensorValue){
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
            sensorValue.toString(),
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