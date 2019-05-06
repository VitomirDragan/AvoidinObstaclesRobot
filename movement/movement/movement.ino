#include <AFMotor.h>

#include <NewPing.h>

#define TRIG_PINRIGHT A1 
#define ECHO_PINRIGHT A0

#define TRIG_PINFRONT A3
#define ECHO_PINFRONT A2

#define TRIG_PINLEFT A5 
#define ECHO_PINLEFT A4 

#define SOUND_SENSOR 13

#define MAX_DISTANCE 400 //distanta maxima pe care o poate citi senzotul de distanta

#define DECISION_DISTANCE 30 //distanta la care se ia o decizie

int distance = 100;

AF_DCMotor motorLeft(2);
AF_DCMotor motorRight(3);

NewPing senzorRight(TRIG_PINRIGHT, ECHO_PINRIGHT, MAX_DISTANCE); 
NewPing senzorFront(TRIG_PINFRONT, ECHO_PINFRONT, MAX_DISTANCE); 
NewPing senzorLeft(TRIG_PINLEFT, ECHO_PINLEFT, MAX_DISTANCE); 

void setup() {
   Serial.begin(9600);
}

int dLeft, dFront, dRight;

void loop() {
  dRight = senzorRight.ping_cm();
  dFront = senzorFront.ping_cm();
  dLeft = senzorLeft.ping_cm();

  motorLeft.run(FORWARD);
  motorRight.run(FORWARD);
  motorRight.setSpeed(255);  
  motorLeft.setSpeed(255);

  if((dLeft<=5 && dLeft>0)|| (dFront<=5 && dFront>0) || (dRight<=5 && dRight>0))
   {                                            //merge cu spatele
            motorLeft.run(BACKWARD);
            motorRight.run(BACKWARD);
     }
  else
    if(dRight<=DECISION_DISTANCE && dRight>0)   //obstacol in dreapta
      motorLeft.setSpeed(0);                    //se opreste motorul stang
    else
       if(dFront<=DECISION_DISTANCE && dFront>0) //obstacol in fata
    {                                            //Motorul din stanga se opreste, iar cel din dreapta merge cu spatele
            motorLeft.run(BACKWARD);
            motorRight.run(FORWARD);
     }
       else
            if(dLeft<=DECISION_DISTANCE && dLeft>0) // obstacol in stanga
                motorRight.setSpeed(0);             // se opreste motorul drept
}
