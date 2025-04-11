#define PIN_PUSH_BTN 4
#define PIN_LED 13

void setup() {
  pinMode(PIN_PUSH_BTN, INPUT_PULLUP);
  pinMode(PIN_LED, OUTPUT);
}

bool isPushBtnPushed;
void loop() {
  isPushBtnPushed = !digitalRead(PIN_PUSH_BTN);
  if (isPushBtnPushed) {
    digitalWrite(PIN_LED, HIGH);
  } else {
    digitalWrite(PIN_LED, LOW);
  }
}
