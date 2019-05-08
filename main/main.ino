// includes
#include "/Users/harriszambo/github/ProiectOC/movement/movement/movement.ino"
#include "/Users/harriszambo/github/ProiectOC/movement/bluetoothFunctionality/bluetoothFunctionality.ino"
#include <AFMotor.h>
// movement
Movement movement;
#define SPEED_HIGH 255
#define SPEED_LOW 150

// bluetooth
BluetoothFunctionality bluetooth;

void setup() {
  AF_DCMotor motorLeft(2);
  AF_DCMotor motorRight(3);
  Serial.begin(9600);
}

void loop() {
  bluetooth.readFromBluetoothDevice();

  if(bluetooth.automatic){
    movement.citesteDistanta();
    movement.ocolesteObstacol();
  }else{
    if(bluetooth.up)
    {

        motorLeft.run(FORWARD);
        motorRight.run(FORWARD);

        motorRight.setSpeed(SPEED_HIGH);  
        motorLeft.setSpeed(SPEED_HIGH);
    }
    
    if(bluetooth.down)
    {
        motorLeft.run(BACKWARD);
        motorRight.run(BACKWARD);

        motorRight.setSpeed(SPEED_HIGH);  
        motorLeft.setSpeed(SPEED_HIGH);
    }
    
    if(bluetooth.left)
    {
      motorLeft.run(FORWARD);
      motorRight.run(FORWARD);
  
      motorRight.setSpeed(SPEED_HIGH);  
     motorLeft.setSpeed(0);
    }
    
    if(bluetooth.right)
    {
      motorLeft.run(FORWARD);
      motorRight.run(FORWARD);

      motorRight.setSpeed(0);  
      motorLeft.setSpeed(SPEED_HIGH);
    }
    
    if(bluetooth.up && bluetooth.left)
    {
      motorLeft.run(FORWARD);
      motorRight.run(FORWARD);

      motorRight.setSpeed(SPEED_HIGH);  
      motorLeft.setSpeed(SPEED_LOW);
      Serial.println("fata-stanga");
    }
    
    if(bluetooth.up && bluetooth.right)
    {
      motorLeft.run(FORWARD);
      motorRight.run(FORWARD);
    
      motorRight.setSpeed(100);
      motorLeft.setSpeed(SPEED_HIGH);
      Serial.println("fata-dreapta");
    }
    
     if(bluetooth.down && bluetooth.left)
     {
        motorLeft.run(BACKWARD);
        motorRight.run(BACKWARD);
  
        motorRight.setSpeed(SPEED_HIGH);  
        motorLeft.setSpeed(SPEED_LOW);
        Serial.println("spate-stanga");
    }
    
    if(bluetooth.down && bluetooth.right)
     {
       motorLeft.run(BACKWARD);
       motorRight.run(BACKWARD);
       

       motorRight.setSpeed(100);  
       motorLeft.setSpeed(SPEED_HIGH);
       Serial.println("spate-dreapta");
     }
     
      if(!bluetooth.down && !bluetooth.right && !bluetooth.up && !bluetooth.left)
      {
        motorRight.setSpeed(0);  
        motorLeft.setSpeed(0);
      }
  }
}
