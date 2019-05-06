class senzorDistanta{
private:
  int triggerPin;
  int echoPin;
  int distance;
public:
  senzorDistanta(int trig, int echo)
  {
    triggerPin = trig;
    echoPin = echo;
  }

  int readDistance();
};

int senzorDistanta::readDistance(){
  digitalWrite(triggerPin, LOW);
  delayMicroseconds(2);
  digitalWrite(triggerPin,HIGH);
  delayMicroseconds(10);
  digitalWrite(triggerPin, LOW);

  distance = pulseIn(echoPin, HIGH);
  return distance*0.034/2;
}
