#include <Servo.h>

#define PUSH_BUTTON_PIN 3
#define PUSH_BUTTON_INPUT_MODE INPUT_PULLUP
#define PUSH_BUTTON_IS_PRESSED(x) (x == LOW)
#define SERVO_PIN 4
#define SERVO_MIN_ANGLE 0
#define SERVO_MAX_ANGLE 180
#define LOOP_DELAY 0

Servo servo;
int servoAngle = SERVO_MIN_ANGLE;

void setup() {
  Serial.begin(9600);
  while (!Serial);
  servo.attach(SERVO_PIN);
  pinMode(PUSH_BUTTON_PIN, PUSH_BUTTON_INPUT_MODE);
}

void loop() {
  if (PUSH_BUTTON_IS_PRESSED(digitalRead(PUSH_BUTTON_PIN))) {
    servoAngle++;
  } else {
    servoAngle--;
  }
  servoAngle = constrain(servoAngle, SERVO_MIN_ANGLE, SERVO_MAX_ANGLE);
  Serial.println(servoAngle);
  servo.write(servoAngle);
  delay(LOOP_DELAY);
}
