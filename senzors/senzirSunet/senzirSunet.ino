int soundSensor = A0;
int LED = 3;


void setup() {
  pinMode(soundSensor, INPUT);
  pinMode(LED, OUTPUT);
  Serial.begin(9600);
}

int ok = 1;

void loop() { 
  int statusSensor = digitalRead(soundSensor);
  if(statusSensor == 1)
    ok = -ok;
   Serial.println(ok);
}
