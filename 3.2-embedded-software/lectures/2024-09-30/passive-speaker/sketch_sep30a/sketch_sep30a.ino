/*
  Melody

  Plays a melody

  circuit:
  - 8 ohm speaker on digital pin 8

  created 21 Jan 2010
  modified 30 Aug 2011
  by Tom Igoe

  This example code is in the public domain.

  https://www.arduino.cc/en/Tutorial/BuiltInExamples/toneMelody
*/

#include "pitches.h"
#define PIN 8

int score[][2] = {
  // ALiCE score sheet
  { NOTE_A4, 3 }, { NOTE_G4, 3 }, { NOTE_E4, 2 }, { NOTE_E4, 8 },
  { NOTE_A4, 3 }, { NOTE_G4, 3 }, { NOTE_E4, 2 }, { NOTE_B3, 8 },
  { NOTE_A4, 3 }, { NOTE_G4, 3 }, { NOTE_F4, 2 }, { NOTE_E4, 4 }, { NOTE_B3, 4 },
  { NOTE_D4, 6 }, { NOTE_C4, 1 }, { NOTE_B3, 1 }, { NOTE_C4, 8 }
};

int melodyLength = (int)(sizeof(score)/sizeof(score[0]));

void setup() {
  // iterate over the notes of the melody:
  for (int thisNote = 0; thisNote < melodyLength; thisNote++) {

    // to calculate the note duration, take one second divided by the note type.
    //e.g. quarter note = 1000 / 4, eighth note = 1000/8, etc.
    int noteDuration = 1000 / score[thisNote][1];
    tone(PIN, score[thisNote][0], noteDuration);

    // to distinguish the notes, set a minimum time between them.
    // the note's duration + 30% seems to work well:
    int pauseBetweenNotes = noteDuration * 1.30;
    delay(pauseBetweenNotes);
    // stop the tone playing:
    noTone(8);
  }
}

void loop() {
  // no need to repeat the melody.
}
