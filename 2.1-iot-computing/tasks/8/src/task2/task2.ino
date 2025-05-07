#define LAST_CHANGED_SLICING 4000000000
#define DEBOUNCE_DELAY 5

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

#define PIN_PUSH_BTN 10
#define PIN_SEG_BASE 2
#define PIN_SEG_SERIES 8

#define OUT_SEG(code) for (int _i = 0; _i < 8; _i++) { digitalWrite(_i + 2, (code & (1 << _i)) >> _i ); }

// const int segs[] =  {SEG_0, SEG_1, SEG_2, SEG_3, SEG_4, SEG_5, SEG_6, SEG_7, SEG_8, SEG_9, SEG_A, SEG_B, SEG_C, SEG_D, SEG_E, SEG_F};
const int seg_length = 16;

typedef struct {
  unsigned long last_changed;
  bool pressed;
} key_state_t;

int get_pin_segement(int);
key_state_t *new_key_state();
void update_last_changed(key_state_t *, unsigned long);
bool is_in_debounce_period(key_state_t *, unsigned long);


int i;
int button_pushed = 0;
key_state_t *key_state;
void setup() {
  for (i = PIN_SEG_BASE; i < PIN_SEG_BASE + PIN_SEG_SERIES; i++) {
    pinMode(i, OUTPUT);
    digitalWrite(i, LOW);
  }
  pinMode(PIN_PUSH_BTN, INPUT_PULLUP);
  Serial.begin(9600);
  while (!Serial);
  key_state = new_key_state();
  update_last_changed(key_state, micros());
  OUT_SEG(get_pin_segement(button_pushed % seg_length));
}

void loop() {
  unsigned long now = micros();
  bool is_pressed = !digitalRead(PIN_PUSH_BTN);

  if (is_in_debounce_period(key_state, now)) {
    update_last_changed(key_state, now);
    return;
  }

  if (key_state->pressed != is_pressed)  {
    key_state->pressed = is_pressed;
    update_last_changed(key_state, now);
    if (is_pressed) {
      button_pushed++;
      Serial.print("Button pushed: ");
      Serial.println(button_pushed);
      
      OUT_SEG(get_pin_segement(button_pushed % seg_length));
      Serial.print("Segment: ");
      Serial.println(button_pushed % seg_length);
    }
  }
}


int get_pin_segement(int pin) {
  switch (pin) {
    case 0: return SEG_0;
    case 1: return SEG_1;
    case 2: return SEG_2;
    case 3: return SEG_3;
    case 4: return SEG_4;
    case 5: return SEG_5;
    case 6: return SEG_6;
    case 7: return SEG_7;
    case 8: return SEG_8;
    case 9: return SEG_9;
    case 10: return SEG_A;
    case 11: return SEG_B;
    case 12: return SEG_C;
    case 13: return SEG_D;
    case 14: return SEG_E;
    case 15: return SEG_F;
    default: return 0;
  }
}

key_state_t *new_key_state() {
  key_state_t *key = (key_state_t *)malloc(sizeof(key_state_t));
  key->last_changed = 0;
  key->pressed = false;
  return key;
}

void update_last_changed(key_state_t *state, unsigned long value) {
  state->last_changed = value % LAST_CHANGED_SLICING;
  return;
}

bool is_in_debounce_period(key_state_t *state, unsigned long now) {
  unsigned long diff;
  if (state->last_changed <= now) {
    diff = now - state->last_changed;
  } else {
    diff = LAST_CHANGED_SLICING + now - state->last_changed;
  }
  return (now - state->last_changed) < DEBOUNCE_DELAY;
}

