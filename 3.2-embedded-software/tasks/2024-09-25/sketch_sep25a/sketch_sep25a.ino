#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include "DHT.h"
#include "config.hpp"

DHT dht(PIN_DHT, DHT_TYPE);
LiquidCrystal_I2C lcd(ADDR_LCD_A, ADDR_LCD_B, ADDR_LCD_C);

void setup() {
  #if DEBUG
  Serial.begin(DEBUG_SERIAL_SPEED);
  Serial.println(DEBUG_MSG_DEBUG_IS_ON);
  #endif

  pinMode(PIN_LED, OUTPUT);
  analogWrite(PIN_LED, STARTUP_LED);

  dht.begin();

  lcd.init();
  lcd.backlight();

  lcd.setCursor(LCD_PRINT_LN1_X, LCD_PRINT_LN1_Y);
  lcd.print(LCD_DEFAULT_PRINT_LN1);
  lcd.setCursor(LCD_PRINT_LN2_X, LCD_PRINT_LN2_Y);
  lcd.print(LCD_DEFAULT_PRINT_LN2);
}

void loop() {
  delay(DHT_MEASURE_INTERVAL);

  float humd = dht.readHumidity(), temp = dht.readTemperature();
  
  if (isnan(humd) || isnan(temp)) {
    #if DEBUG
    Serial.println(DEBUG_ERR_DHT_RET_NAN);
    #endif
    return;
  }

  #if DEBUG
  Serial.print(LCD_CONTENT_HEADER_TEMP);
  Serial.println(temp);
  Serial.print(LCD_CONTENT_HEADER_HUMD);
  Serial.println(humd);
  #endif

  lcd.clear();

  lcd.setCursor(LCD_PRINT_LN1_X, LCD_PRINT_LN1_Y);
  lcd.print(LCD_CONTENT_HEADER_TEMP);
  lcd.setCursor(LCD_PRINT_TEMP_VALUE_POINT_X, LCD_PRINT_TEMP_VALUE_POINT_Y);
  lcd.print(temp);
  lcd.setCursor(LCD_PRINT_LN2_X, LCD_PRINT_LN2_Y);
  lcd.print(LCD_CONTENT_HEADER_HUMD);
  lcd.setCursor(LCD_PRINT_HUMD_VALUE_POINT_X, LCD_PRINT_HUMD_VALUE_POINT_Y);
  lcd.print(humd);

  if (humd > LED_HUMD_MIN_REQUIRED) {
    analogWrite(PIN_LED, LED_HUMD_ON);
  } else {
    analogWrite(PIN_LED, LED_HUMD_OFF);
  }
}
