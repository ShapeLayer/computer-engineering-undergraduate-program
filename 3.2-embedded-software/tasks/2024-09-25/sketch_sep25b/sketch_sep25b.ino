#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include "config.hpp"

LiquidCrystal_I2C lcd(ADDR_LCD_A, ADDR_LCD_B, ADDR_LCD_C);

int lcdLoopSkipped = STARTUP_LCD_REFRESH_FLAG;
void setup() {
  #if DEBUG
  Serial.begin(DEBUG_SERIAL_SPEED);
  Serial.println(DEBUG_MSG_DEBUG_IS_ON);
  #endif

  pinMode(PIN_LED, OUTPUT);
  pinMode(PIN_POTM, INPUT);
  analogWrite(PIN_LED, STARTUP_LED);

  lcd.init();
  lcd.backlight();

  lcd.setCursor(LCD_PRINT_LN1_X, LCD_PRINT_LN1_Y);
  lcd.print(LCD_DEFAULT_PRINT_LN1);
  lcd.setCursor(LCD_PRINT_LN2_X, LCD_PRINT_LN2_Y);
  lcd.print(LCD_DEFAULT_PRINT_LN2);
}

void loop() {
  int _set = analogRead(PIN_POTM);
  Serial.println(_set);
  int _led = map(_set, VALUE_SET_LBOUND, VALUE_SET_HBOUND, VALUE_LED_LBOUND, VALUE_LED_HBOUND);
  analogWrite(PIN_LED, _led);

  if (lcdLoopSkipped >= LED_REFRESH_INTERVAL) {
    lcd.clear();
    lcd.setCursor(LCD_PRINT_LN1_X, LCD_PRINT_LN1_Y);
    lcd.print(LCD_PRINT_STATUS_LN1);
    lcd.setCursor(LCD_PRINT_SET_VALUE_POINT_X, LCD_PRINT_SET_VALUE_POINT_Y);
    lcd.print(_set);
    lcd.setCursor(LCD_PRINT_LN2_X, LCD_PRINT_LN2_Y);
    lcd.print(LCD_PRINT_STATUS_LN2);
    lcd.setCursor(LCD_PRINT_LED_VALUE_POINT_X, LCD_PRINT_LED_VALUE_POINT_Y);
    lcd.print(_led);
    lcdLoopSkipped = LED_REFRESH_POSTPROC_RENEW_VALUE;
  }
  
  lcdLoopSkipped++;
}
