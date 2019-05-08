// includes
#include "/Users/harriszambo/github/ProiectOC/senzors/senzorDistanta/senzorDistanta.ino"
#include <AFMotor.h>


// distance sensors
// VCC = 5V
#define distanceTriggerPin 10
#define distanceEchoFrontPin A0
#define distanceEchoLeftPin A1
#define distanceEchoRightPin A2
senzorDistanta senzDistFront = senzorDistanta(distanceTriggerPin, distanceEchoFrontPin);
senzorDistanta senzDistLeft = senzorDistanta(distanceTriggerPin, distanceEchoLeftPin);
senzorDistanta senzDistRight = senzorDistanta(distanceTriggerPin, distanceEchoRightPin);


//MOTORS
#define PORTLEFT 1
#define PORTRIGHT 2

AF_DCMotor motorLeft(PORTLEFT);
AF_DCMotor motorRight(PORTRIGHT);


void setup() {
  Serial.begin(9600);
  
  // distance sensors
  pinMode(distanceTriggerPin, OUTPUT);
  pinMode(distanceEchoFrontPin, INPUT);
  pinMode(distanceEchoLeftPin, INPUT);
  pinMode(distanceEchoRightPin, INPUT);
  motorLeft.setSpeed(255);
  motorRight.setSpeed(255);
}

void loop() {
  // distance sensors
  //senzDistLeft.readDistance();
  senzDistFront.readDistance();
  //senzDistRight.readDistance();
  
  Serial.print("Left  "); Serial.println(senzDistLeft.getCentimeters());
  Serial.print("Front "); Serial.println(senzDistFront.getCentimeters());
  Serial.print("Right "); Serial.println(senzDistRight.getCentimeters());
  Serial.println();

  motorLeft.run(FORWARD);
  motorRight.run(FORWARD);
  
  if(senzDistFront.getCentimeters()<20)
  {
    motorLeft.setSpeed(0);
  }
  else
  {
    motorLeft.setSpeed(1000);
  }
}
