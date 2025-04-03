#define DEBUG true
#define SERIAL_SPEED 9600
// 과제 조건: for문 사용
#define FAIL debug("System Failed."); for(;true;);

enum dayname {
  sunday = 0,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday
};

void onInitDebugSerial();
void onLoopInitDebugSerial();
void debug(String);
int generateDayCode();
String dayCodeToString(dayname);

// 과제 조건: setup() 사용
void setup() {
  #if DEBUG
  onInitDebugSerial();
  #endif
}

String computed;
// 과제 조건: loop() 사용
void loop() {
  // Invokes System Failed:
  // dayCodeToString(-1);

  computed = dayCodeToString(generateDayCode());
  #if DEBUG
  Serial.println(computed);
  #endif
}

void onInitDebugSerial() {
  Serial.begin(SERIAL_SPEED);
  // 과제 조건: while문 사용
  while (!Serial);
}

void debug(String message) {
  #if DEBUG
  Serial.print("Debug: ");
  Serial.println(message);
  #endif
}

int generateDayCode() {
  return random(7);
}

String dayCodeToString(dayname daycode) {
  // 과제 조건: if-else문 사용
  if (!(0 <= (int)daycode && (int)daycode < 7)) {
    FAIL;
  } else {
    // 과제 조건: switch문 사용
    switch (daycode) {
      case sunday:
      return "Sunday";
      case monday:
      return "Monday";
      case tuesday:
      return "Tuesday";
      case wednesday:
      return "Wednesday";
      case thursday:
      return "Thursday";
      case friday:
      return "Friday";
      case saturday:
      return "Saturday";
    }
  }
}
