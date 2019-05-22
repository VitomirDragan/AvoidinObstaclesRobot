// includes
#include "/Users/harriszambo/github/ProiectOC/movement/movement/movement.ino"
#include "/Users/harriszambo/github/ProiectOC/movement/bluetoothFunctionality/bluetoothFunctionality.ino"
#include <AFMotor.h>
#include <dht.h>

#define DHT11_PIN 13
dht DHT;

// movement
Movement movement;
#define SPEED_HIGH 255
#define SPEED_LOW 150
#define GAZ 9

// bluetooth
BluetoothFunctionality bluetooth;

void setup() {
  pinMode(GAZ, INPUT);
  
  AF_DCMotor motorLeft(2);
  AF_DCMotor motorRight(3);
  Serial.begin(9600);
}

void loop() {
  DHT.read11(DHT11_PIN);
  if(DHT.temperature >= 0 && DHT.humidity >= 0){
    bluetooth.sendToBluetoothDevide(DHT.temperature, DHT.humidity, digitalRead(GAZ));
  }
  
  bluetooth.readFromBluetoothDevice();

  if(bluetooth.automatic){
    movement.citesteDistanta();
    movement.ocolesteObstacol();
  }else{
    if(bluetooth.up)
    {

        if(bluetooth.left)
       {
         motorLeft.run(FORWARD);
         motorRight.run(FORWARD);

         motorRight.setSpeed(SPEED_HIGH);  
         motorLeft.setSpeed(SPEED_LOW);

        }
        else
             if(bluetooth.right)
             {
                 motorLeft.run(FORWARD);
                 motorRight.run(FORWARD);
    
                 motorRight.setSpeed(100);
                 motorLeft.setSpeed(SPEED_HIGH);

             }
             else
                {
                    motorLeft.run(FORWARD);
                    motorRight.run(FORWARD);

                    motorRight.setSpeed(SPEED_HIGH);  
                    motorLeft.setSpeed(SPEED_HIGH);
                }
    }
    else
         if(bluetooth.down)
    {
       if(bluetooth.left)
     {
        motorLeft.run(BACKWARD);
        motorRight.run(BACKWARD);
  
        motorRight.setSpeed(SPEED_HIGH);  
        motorLeft.setSpeed(SPEED_LOW);

    }
      else
            if(bluetooth.down && bluetooth.right)
            {
                motorLeft.run(BACKWARD);
                motorRight.run(BACKWARD);
       
                motorRight.setSpeed(100);  
                motorLeft.setSpeed(SPEED_HIGH);
            }
            else
                {
                    motorLeft.run(BACKWARD);
                    motorRight.run(BACKWARD);

                    motorRight.setSpeed(SPEED_HIGH);  
                    motorLeft.setSpeed(SPEED_HIGH);
                }
    }
    else
    if(bluetooth.left)
    {
      motorLeft.run(FORWARD);
      motorRight.run(FORWARD);
  
      motorRight.setSpeed(SPEED_HIGH);  
     motorLeft.setSpeed(0);
    }
    else
    if(bluetooth.right)
    {
      motorLeft.run(FORWARD);
      motorRight.run(FORWARD);

      motorRight.setSpeed(0);  
      motorLeft.setSpeed(SPEED_HIGH);
    }
     else
        {
            motorRight.setSpeed(0);  
            motorLeft.setSpeed(0);
         }
  }
}
