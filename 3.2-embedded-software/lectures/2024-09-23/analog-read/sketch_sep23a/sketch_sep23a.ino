#define PIN A0
#define SPEED 9600

void setup() {
  pinMode(PIN, INPUT);
  Serial.begin(SPEED);
}

void loop() {
  int data = analogRead(PIN);
  Serial.println(data);
}
