#define LED1 9
#define LED2 10
#define LED3 11

void setup() {
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(LED3, OUTPUT);
}

int a = 0, b = 85, c = 170;
void loop() {
  analogWrite(LED1, a);
  analogWrite(LED2, b);
  analogWrite(LED3, c);
  delay(5);
  a = (a + 1) % 256;
  b = (b + 1) % 256;
  c = (c + 1) % 256;
}
