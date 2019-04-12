// includes
#include "/Users/harriszambo/github/ProiectOC/senzors/senzorDistanta/senzorDistanta.ino"

// distance sensors
// VCC = 5V
#define distanceTriggerPin 10
#define distanceEchoFrontPin A0
#define distanceEchoLeftPin A1
#define distanceEchoRightPin A2
senzorDistanta senzDistFront = senzorDistanta(distanceTriggerPin, distanceEchoFrontPin);
senzorDistanta senzDistLeft = senzorDistanta(distanceTriggerPin, distanceEchoLeftPin);
senzorDistanta senzDistRight = senzorDistanta(distanceTriggerPin, distanceEchoRightPin);

void setup() {
  Serial.begin(9600);
  
  // distance sensors
  pinMode(distanceTriggerPin, OUTPUT);
  pinMode(distanceEchoFrontPin, INPUT);
  pinMode(distanceEchoLeftPin, INPUT);
  pinMode(distanceEchoRightPin, INPUT);
}

void loop() {
  // distance sensors
  senzDistLeft.readDistance();
  senzDistFront.readDistance();
  senzDistRight.readDistance();
  
  Serial.print("Left"); Serial.println(senzDistLeft.getCentimeters());
  Serial.print("Front"); Serial.println(senzDistFront.getCentimeters());
  Serial.print("Right"); Serial.println(senzDistRight.getCentimeters());
}
