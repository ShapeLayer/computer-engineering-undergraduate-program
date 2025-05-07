#define SEG_0 0xfc
#define SEG_1 0x60
#define SEG_2 0xda
#define SEG_3 0xf2
#define SEG_4 0x66
#define SEG_5 0xb6
#define SEG_6 0xbe
#define SEG_7 0xe4
#define SEG_8 0xfe
#define SEG_9 0xf6
#define SEG_A 0xee
#define SEG_B 0x3e
#define SEG_C 0x9c
#define SEG_D 0x7a
#define SEG_E 0x9e
#define SEG_F 0x8e

#define OUT_SEG(code) for (int _i = 0; _i < 8; _i++) { digitalWrite(_i + 2, (code & (1 << _i)) >> _i ); }

int i;
void setup() {
  for (i = 2; i < 10; i++) {
    pinMode(i, OUTPUT);
    digitalWrite(i, LOW);
  }
  delay(2000);
  Serial.begin(9600);
  digitalWrite(2, HIGH);
  while (!Serial);
  for (int _i = 0; _i < 8; _i++) { digitalWrite(_i + 2, (SEG_0 & (1 << _i)) >> _i); Serial.print((_i + 2) * (SEG_0 & (1 << _i)) >> _i); delay(1000); }
}

void loop() {
  // OUT_SEG(SEG_0);
  // delay(200);
}
