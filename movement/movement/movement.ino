#include <AFMotor.h>
#include <NewPing.h>
#define TRIG_PINRIGHT A1 
#define ECHO_PINRIGHT A0
#define TRIG_PINFRONT A3
#define ECHO_PINFRONT A2
#define TRIG_PINLEFT A5 
#define ECHO_PINLEFT A4 
#define MAX_DISTANCE 400 //distanta maxima pe care o poate citi senzotul de distanta
#define DECISION_DISTANCE 20 //distanta la care se ia o decizie
#define DELAY_TIME 100
#define SPEED_FORWARD 255
#define SPEED_BACKWARD 180



NewPing senzorRight(TRIG_PINRIGHT, ECHO_PINRIGHT, MAX_DISTANCE); 
NewPing senzorFront(TRIG_PINFRONT, ECHO_PINFRONT, MAX_DISTANCE); 
NewPing senzorLeft(TRIG_PINLEFT, ECHO_PINLEFT, MAX_DISTANCE); 

AF_DCMotor motorLeft(2);
AF_DCMotor motorRight(3);




class Movement{
  public:
    int dRight;
    int dFront;
    int dLeft;
    
    void citesteDistanta()
    {
        dRight = senzorRight.ping_cm();
        dFront = senzorFront.ping_cm();
        dLeft = senzorLeft.ping_cm();
    }

    void ocolesteObstacol()
    {
         motorLeft.run(FORWARD);
         motorRight.run(FORWARD);
         motorRight.setSpeed(SPEED_FORWARD);  
         motorLeft.setSpeed(SPEED_FORWARD);
         int DELAY = 0;

        if((dLeft<=10 && dLeft>0) || (dFront<=10 && dFront>0) || (dRight<=10 && dRight>0))
        {  
          while(dFront<=15 && dFront>0)
          { 
            motorLeft.run(BACKWARD);
            motorRight.run(BACKWARD);
            motorRight.setSpeed(SPEED_BACKWARD);  
            motorLeft.setSpeed(SPEED_BACKWARD);
            citesteDistanta();
            DELAY = 300;
          }         
            motorLeft.run(BACKWARD);
            motorRight.run(FORWARD);
            motorRight.setSpeed(SPEED_FORWARD);  
            motorLeft.setSpeed(SPEED_FORWARD);
            delay(DELAY);
        }
        else
              if(dRight<=DECISION_DISTANCE && dRight>0)   //obstacol in dreapta
                  motorLeft.setSpeed(0);                    //se opreste motorul stang
               else
                     if(dFront<=DECISION_DISTANCE && dFront>0) //obstacol in fata
                     {        
                        if(dLeft>dRight)
                        {
                            motorRight.setSpeed(SPEED_FORWARD);  
                            motorLeft.setSpeed(0);
                        }
                        else
                        {
                            motorRight.setSpeed(0);  
                            motorLeft.setSpeed(SPEED_FORWARD);
                        }                          
                      }
                      else
                            if(dLeft<=DECISION_DISTANCE && dLeft>0) // obstacol in stanga
                                  motorRight.setSpeed(0);             // se opreste motorul drept
    }
    
};
