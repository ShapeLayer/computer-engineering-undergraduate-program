#include <iostream>
#define TECHNIC_ROLLING "LLLRB"
#define TECHNIC_UPPER "DDRRA"
#define TECHNIC_RUSH "AAAAA"
using namespace std;

enum cmd_type { ROLLING, UPPER, RUSH, NONE };

int main() {
  string ctrl;
  cin >> ctrl;

  int cmd_ptr = 0;
  int cmd_detected_at;
  cmd_type curr_cmd = NONE;
  for (int i = 0; i < ctrl.size(); i++) {
    char c = ctrl[i];
    
    if (curr_cmd == NONE) {
      if (c == TECHNIC_ROLLING[0]) {
        curr_cmd = ROLLING;
        cmd_detected_at = i;
        cmd_ptr++;
      } else if (c == TECHNIC_UPPER[0]) {
        curr_cmd = UPPER;
        cmd_detected_at = i;
        cmd_ptr++;
      } else if (c == TECHNIC_RUSH[0]) {
        curr_cmd = RUSH;
        cmd_detected_at = i;
        cmd_ptr++;
      }
    } else {
      if (
        (curr_cmd == ROLLING && c == TECHNIC_ROLLING[cmd_ptr]) ||
        (curr_cmd == UPPER && c == TECHNIC_UPPER[cmd_ptr]) ||
        (curr_cmd == RUSH && c == TECHNIC_RUSH[cmd_ptr])
      ) {
          cmd_ptr++;
          if (cmd_ptr == 5) {
            switch (curr_cmd) {
              case ROLLING:
                cout << "rolling" << endl;
                break;
              case UPPER:
                cout << "upper" << endl;
                break;
              case RUSH:
                cout << "rush" << endl;
                break;
              default:
                break;
            }
            curr_cmd = NONE;
            cmd_ptr = 0;
          }
        } else {
          curr_cmd = NONE;
          cmd_ptr = 0;
          i = cmd_detected_at;
        }
    }
  }
  return 0;
}
