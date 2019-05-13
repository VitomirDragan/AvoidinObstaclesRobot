import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
//import 'package:flutter_blue/flutter_blue.dart';

class BluetoothFunctionality{

  static FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;

  // the actual device
  // if this is null, then there is no device
  static BluetoothDevice _device;

  String s = "aaa";

  // constructor
 BluetoothFunctionality(){
   connect();
 }


  static void connect(){
    // future_bluetooth_serial library predefined type of mapped List
    Future<List> _devices = _bluetooth.getBondedDevices();

    _devices.then((element){
      _device = element.first;
      print(_device.name + " is the name");
      _actualConnect();
      return;
    });
  }


  // connects _bluetooth to the bluetooth _device
  static void _actualConnect(){
    print("trying to connect");

    if(_device != null){
      print("_device.connect not null");

      _bluetooth.isConnected.then((isConnected) {
        if(!isConnected){
          _bluetooth.connect(_device);
          print("connected");
        }else{
          print("already connected connected");
        }
      });
    }else{
      print("_device.connect null");
    }
  }


  // send messages via _bluetooth
  void sendMessageViaBluetooth(String message){
    _bluetooth.isConnected.then((isConnected){
      if(isConnected){
        _bluetooth.write(message);
        print("sent " + message);
      }
    });
  }


  // returns bluetooth device name or "none"
  // used to display the name in the interface
  String getBluetoothDeviceName(){
    if(_device == null){
      s = "none";
    }else{
      _bluetooth.isAvailable.then((isConnected) {
        if(isConnected){
          s = _device.name;
        }else{
          s =  "not connected";
        }

        return s;
      });
    }

    //print("s is " + s);
    return s;
  }

}