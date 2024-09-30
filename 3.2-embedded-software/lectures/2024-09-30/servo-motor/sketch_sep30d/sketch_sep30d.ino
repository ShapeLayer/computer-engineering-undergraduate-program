#include <Servo.h>
#define PIN 5

Servo servo;

void setup() {
  servo.attach(PIN);
}

void loop() {
  servo.write(random(0, 181));
  delay(500);
}
