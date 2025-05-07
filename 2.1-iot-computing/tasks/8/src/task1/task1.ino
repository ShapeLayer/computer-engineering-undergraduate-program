#define CONFIG_LOOP_DELAY 500

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

#define PIN_BASE 2
#define PIN_SERIES 8

#define OUT_SEG(code) for (int _i = 0; _i < 8; _i++) { digitalWrite(_i + 2, (code & (1 << _i)) >> _i ); }

const int segs[] =  {SEG_0, SEG_1, SEG_2, SEG_3, SEG_4, SEG_5, SEG_6, SEG_7, SEG_8, SEG_9, SEG_A, SEG_B, SEG_C, SEG_D, SEG_E, SEG_F};
const int seg_length = 16;

int i;
void setup() {
  for (i = PIN_BASE; i < PIN_BASE + PIN_SERIES; i++) {
    pinMode(i, OUTPUT);
    digitalWrite(i, LOW);
  }
  Serial.begin(9600);
  while (!Serial);
}

int seg_index = 0;
void loop() {
  OUT_SEG(segs[seg_index]);
  seg_index = (seg_index + 1) % seg_length;
  delay(CONFIG_LOOP_DELAY);
}
