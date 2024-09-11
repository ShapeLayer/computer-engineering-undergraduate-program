
void setup() {
  Serial.begin(9600);
  pinMode(12, INPUT_PULLUP);

}

void loop() {
  int sensorVal = digitalRead(12);
  Serial.println(!sensorVal);
}