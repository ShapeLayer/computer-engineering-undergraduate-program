#define DEBUG true

#define SERIAL_SPEED 9600
#define FAIL debug("System Failed."); while(1);

void onInitDebugSerial();
void debug(String);

void setup() {
  #if DEBUG
  onInitDebugSerial();
  #endif
}

String uuid;
void loop() {
  uuid = generateUUID();
  #if DEBUG
  Serial.println(uuid);
  #endif
}

void onInitDebugSerial() {
  #if DEBUG
  Serial.begin(SERIAL_SPEED);
  while (!Serial);
  #endif
}

void debug(String message) {
  #if DEBUG
  Serial.print("Debug: ");
  Serial.println(message);
  #endif
}

int gen;
String generateUUID() {
  int i;
  String _new = "";
  for (i = 0; i < 32; i++) {
    if (i == 8 || i == 12 || i == 16 || i == 20) {
      _new.concat("-");
    }

    gen = (int)random(0, 16);
    if (gen < 10) {
      _new.concat((char)(48 + gen));
    } else {
      _new.concat((char)(97 + gen - 10));
    }
  }
  return _new;
}
