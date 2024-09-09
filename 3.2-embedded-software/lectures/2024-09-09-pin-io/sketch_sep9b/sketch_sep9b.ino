#define PIN 13
#define SPEED 9600

void setup() {
  pinMode(PIN, INPUT);
  Serial.begin(SPEED);
}

void loop() {
  int data = digitalRead(PIN);
  Serial.println(data);
}
