class senzorDistanta{
private:
  int triggerPin;
  int echoPin;
  int distance;
public:
  senzorDistanta(int trig, int echo){
    triggerPin = trig;
    echoPin = echo;
  }

  void readDistance();
  int getCentimeters();
};

void senzorDistanta::readDistance(){
  digitalWrite(triggerPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(triggerPin,LOW);

  distance = pulseIn(echoPin, HIGH);
}

int senzorDistanta::getCentimeters(){
  return distance/2/29.1;
}
