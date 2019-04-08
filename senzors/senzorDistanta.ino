const int senzDist_triggerPin = 9, senzDist_echoPin = 10;
int distance;

void readDistance(){
  digitalWrite(triggerPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(triggerPin,LOW);

  distance = pulseIn(echoPin, HIGH);
}

int getCentimeters(){
  return distance/2/29.1;;
}
