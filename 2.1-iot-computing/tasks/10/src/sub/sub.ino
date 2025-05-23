#define SERIAL_SPEED 9600
#define LED_ON 1
#define LED_OFF 0
#define LED_PIN 13

void setup() {
  Serial.begin(SERIAL_SPEED);
  while (!Serial);
  pinMode(LED_PIN, OUTPUT);
}

void loop() {
  if (!Serial.available()) return;
  byte received = Serial.read();
  Serial.println(received);
  if (received == 1) {
    digitalWrite(LED_PIN, HIGH);
  } else {
    digitalWrite(LED_PIN, LOW);
  }
}
