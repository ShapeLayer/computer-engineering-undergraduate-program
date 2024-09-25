#ifndef _CONFIG

#define _CONFIG

#define DEBUG 1
#define DEBUG_SERIAL_SPEED 9600
#define DEBUG_MSG_DEBUG_IS_ON "Debug Mode Enabled"
#define DEBUG_ERR_DHT_RET_NAN "Failed to read temperature data."

#define PIN_DHT 2
#define PIN_LED 3
#define ADDR_LCD_A 0x27
#define ADDR_LCD_B 20
#define ADDR_LCD_C 4

#define DHT_TYPE DHT11
#define DHT_MEASURE_INTERVAL 2000

#define LCD_DEFAULT_PRINT_LN1 "Measuring Temp Now"
#define LCD_DEFAULT_PRINT_LN2 "PLEASE WAIT"
#define LCD_CONTENT_HEADER_TEMP "Temp: "
#define LCD_CONTENT_HEADER_HUMD "Humd: "

#define LCD_PRINT_LN1_X 0
#define LCD_PRINT_LN1_Y 0
#define LCD_PRINT_LN2_X 0
#define LCD_PRINT_LN2_Y 1

#define LCD_PRINT_TEMP_VALUE_POINT_X 6
#define LCD_PRINT_TEMP_VALUE_POINT_Y 0
#define LCD_PRINT_HUMD_VALUE_POINT_X 6
#define LCD_PRINT_HUMD_VALUE_POINT_Y 1

#define LED_HUMD_MIN_REQUIRED 40  // Task requests this value to `75`.
#define LED_HUMD_ON 255
#define LED_HUMD_OFF 0

#define STARTUP_LED LED_HUMD_OFF
#endif
