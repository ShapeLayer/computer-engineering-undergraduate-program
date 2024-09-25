#include <Wire.h> 
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27, 20, 4);

void setup()
{
  lcd.init();
  lcd.backlight();
}

const String hello = "Hello, World! ";
const int start = 1;
const int ln = hello.length();

void loop()
{
  for (int y = 0; y < 2; y++) {
    lcd.setCursor(1, y);
    for (int i = start; i < ln; i++) {
      lcd.print(hello[i]);
    }
    for (int i = 0; i < start - 0; i++) {
      lcd.print(hello[i]);
    }
  }
  start = (start + 1) % ln;
  delay(50);
}
