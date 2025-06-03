#define SERIAL_SPEED 9600
#define LED_ON 1
#define LED_OFF 0
#define LED_PIN 13

void setup() {
  Serial.begin(SERIAL_SPEED);
  while (!Serial);
}

void loop() {
  Serial.write(LED_ON);
  delay(1000);
  Serial.write(LED_OFF);
  delay(1000);
}
