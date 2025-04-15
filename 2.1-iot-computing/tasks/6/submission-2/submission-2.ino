#define SPEAKER 3

#define C5  523
#define C5S 554
#define D5  587
#define D5S 622
#define E5  659
#define F5  698
#define F5S 740
#define G5  784
#define G5S 831
#define A5  880
#define A5S 932
#define B5  988
#define C6  1047
#define C6S 1109
#define D6  1175
#define D6S 1245
#define E6  1319
#define F6  1397
#define F6S 1480
#define G6  1568
#define G6S 1661
#define A6  1760
#define A6S 1865
#define B6  1976

#define DELAY_OFFSET 1.1
#define NOTONE_OFFSET 3

#define PLAY(note, dt) { tone(SPEAKER, note, dt); delay(dt * DELAY_OFFSET); noTone(NOTONE_OFFSET); }
#define PLAY500(note) PLAY(note, 500)

typedef struct note {
  int note;
  int duration;
} note;

note score[] = {
  {E5, 2},
  {G5, 2},
  {A5, 2},
  {B5, 2},
  {E5, 1},
  {A5, 2},
  {E5, 1},
  {G5, 4},
  {E5, 4},
  {D5, 2},
  {E5, 3},
  {B5, 1},
  {B5, 2},
};
const int scaler = 125;

int i;
void setup() {
  for (i = 0; i < 13; i++) {
    note now = score[i];
    PLAY(now.note, now.duration);
  }
}

void loop() {
}
