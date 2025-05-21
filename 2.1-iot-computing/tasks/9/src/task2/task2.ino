#include <Stepper.h>

#define STEPS_PER_REVOLUTION 2048
#define DELAY_PER_STEP 500

Stepper stepper(STEPS_PER_REVOLUTION, 8, 10, 9, 11);

void setup() {
  stepper.setSpeed(14);
}

void loop() {
  stepper.step(STEPS_PER_REVOLUTION);
  delay(DELAY_PER_STEP);
  stepper.step(-STEPS_PER_REVOLUTION);
  delay(DELAY_PER_STEP);
}
