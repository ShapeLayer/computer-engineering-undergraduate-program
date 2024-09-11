#define PIN_LED 9
#define PIN_SW_UP 13
#define PIN_SW_DN 12
#define LIGHT_DEFAULT 128
#define LIGHT_DIFF_UP 1
#define LIGHT_DIFF_DN 1
#define LIGHT_MIN 1
#define LIGHT_MAX 255
#define SERIAL_SPEED 9600

int ledLight = LIGHT_DEFAULT;

void setup() {
  pinMode(PIN_LED, OUTPUT);
  pinMode(PIN_SW_UP, INPUT);
  pinMode(PIN_SW_DN, INPUT_PULLUP);
  Serial.begin(SERIAL_SPEED);
  Serial.println("Init done.");
}

void loop() {
  int isUpSwPressed = digitalRead(PIN_SW_UP);
  if (isUpSwPressed) ledLight++;
  int isDnSwPressed = !digitalRead(PIN_SW_DN);
  if (isDnSwPressed) ledLight--;

  if (ledLight < LIGHT_MIN) ledLight = LIGHT_MIN;
  if (ledLight > LIGHT_MAX) ledLight = LIGHT_MAX;

  Serial.println("isUpSwPressed: " + String(isUpSwPressed) + ", isDnSwPressed: " + String(isDnSwPressed) + ", ledLight: " + String(ledLight));
  
  analogWrite(PIN_LED, ledLight);
}
