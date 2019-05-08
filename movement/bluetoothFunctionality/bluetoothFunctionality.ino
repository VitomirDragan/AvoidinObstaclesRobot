#include <SoftwareSerial.h>
#define TXpin 10

SoftwareSerial mySerial(TXpin, -1);

class BluetoothFunctionality{
public:
  bool automatic, up, down, left, right;
  
  BluetoothFunctionality(){
    mySerial.begin(9600);
  }

  void readFromBluetoothDevice(){
    if(mySerial.available()) {
      delay(50);
      
      automatic = mySerial.read()-'0';
      up = mySerial.read()-'0';
      down = mySerial.read()-'0';
      left = mySerial.read()-'0';
      right = mySerial.read()-'0';
      mySerial.read();
    }
  }
};
