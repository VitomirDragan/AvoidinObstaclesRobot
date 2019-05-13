#include <SoftwareSerial.h>
#define TXpin 10
#define RXpin 11

SoftwareSerial mySerial(TXpin, RXpin);

class BluetoothFunctionality{
private:
  int readedValue;
  enum _messageToSend{
    bl_stop,
    bl_automatic,
  
    bl_up,
    bl_down,
    bl_left,
    bl_right,
  
    bl_up_left,
    bl_up_right,
    bl_down_left,
    bl_down_right
  };

public:
  bool automatic, up, down, left, right;
  
  BluetoothFunctionality(){
    mySerial.begin(9600);
  }

  void readFromBluetoothDevice(){
    if(mySerial.available()){
      automatic = up = down = left = right = false;
      
      readedValue = mySerial.read() - '0';
      mySerial.read();

      // stop and automatic
      if(readedValue == bl_stop){
        ;
      }else if(readedValue == bl_automatic){
        automatic = true;
      }
  
      // simple commands
      else if(readedValue == bl_up){
        up = true;
      }else if(readedValue == bl_down){
        down = true;
      }else if(readedValue == bl_left){
        left = true;
      }else if(readedValue == bl_right){
        right = true;
      }
      
      // combined commands
      else if(readedValue == bl_up_left){
        up = left = true;
      }else if(readedValue == bl_up_right){
        up = right = true;
      }else if(readedValue == bl_down_left){
        down = left = true;
      }else if(readedValue == bl_down_right){
        down = right = true;
      }
    }
  }
};
