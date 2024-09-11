#define PIN_LED 9
#define LED_DEFAULT 128
#define LED_STEP 32

int ledLight = LED_DEFAULT;

void setup() {
  pinMode(PIN_LED, OUTPUT);
}

void loop() {
  ledLight = (ledLight + LED_STEP) % 256;
  analogWrite(PIN_LED, ledLight);
  delay(1000);
}
