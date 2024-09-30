#include <Stepper.h>
#define STEPS_PER_REVOLUTION 2048
#define MOTOR_RPM 15

Stepper stepper(STEPS_PER_REVOLUTION, 11, 9, 10, 8);

void setup() {
  stepper.setSpeed(MOTOR_RPM);
}

void loop() {
  stepper.step(1024);
  delay(1000);
  stepper.step(-STEPS_PER_REVOLUTION);
  delay(1000);
}
