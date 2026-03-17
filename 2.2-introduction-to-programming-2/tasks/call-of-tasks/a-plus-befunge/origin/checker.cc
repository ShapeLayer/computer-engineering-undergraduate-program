#include <iostream>
#include <vector>

// #define MODE_INTERPRET_ONLY
#define MODE_TESTLIB

#ifdef MODE_TESTLIB
#include "testlib.h"
#endif

using namespace std;

vector<string> precompute(string src) {
  /**
   * Precompute befunge code into a 2D grid
   */

  vector<string> grid;
  string line;

  size_t max_width = 0;
  size_t curr_width = 0;
  for (char ch : src) {
    curr_width++;
    if (ch == '\n') {
      max_width = max(max_width, curr_width);
      grid.push_back(line);
      line.clear();
      curr_width = 0;
    } else {
      line += ch;
    }
  }
  if (!line.empty()) {
    grid.push_back(line);
  }
  for (string &row : grid) {
    while (row.length() < max_width) {
      row += ' ';
    }
  }
  return grid;
}

string compute(vector<string> src) {
  /**
   * Compute befunge code
   */

  int width = src[0].size();
  int height = src.size();

  // handle
  int x = 0, y = 0;
  int dir_x = 1, dir_y = 0;
  string output;

  // memory
  vector<int> stack;
  int a, b;
  bool string_mode = false;

  while (true) {
    char curr = src[y][x];

    cout << y << ' ' << x << ' ' << curr << endl;
    
    if (string_mode) {
      if (curr == '"') {
        string_mode = false;
      } else {
        stack.push_back(static_cast<int>(curr));
      }
      x += dir_x;
      y += dir_y;
      if (y < 0) y = height - 1;
      if (y >= height) y = 0;
      if (x < 0) x = width - 1;
      if (x >= width) x = 0;
      continue;
    }

    switch (curr) {
      case '0':
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9':
        stack.push_back(curr - '0');
        break;
      case '+':
      case '-':
      case '*':
      case '/':
      case '%':
        if (!stack.empty()) {
          b = stack.back();
          stack.pop_back();
        } else {
          b = 0;
        }
        if (!stack.empty()) {
          a = stack.back();
          stack.pop_back();
        } else {
          a = 0;
        }
        if (curr == '+') stack.push_back(a + b);
        else if (curr == '-') stack.push_back(a - b);
        else if (curr == '*') stack.push_back(a * b);
        else if (curr == '/') {
          if (b == 0) stack.push_back(0);
          else stack.push_back(a / b);
        } else if (curr == '%') {
          if (b == 0) stack.push_back(0);
          else stack.push_back(a % b);
        }
        break;
      case '!':
        if (!stack.empty()) {
          int val = stack.back();
          stack.pop_back();
          stack.push_back(val == 0 ? 1 : 0);
        } else {
          stack.push_back(1);
        }
        break;
      case '`':
        if (!stack.empty()) {
          b = stack.back();
          stack.pop_back();
        } else {
          b = 0;
        }
        if (!stack.empty()) {
          a = stack.back();
          stack.pop_back();
        } else {
          a = 0;
        }
        stack.push_back(a > b ? 1 : 0);
        break;
      case '>':
        dir_x = 1; dir_y = 0;
        break;
      case '<':
        dir_x = -1; dir_y = 0;
        break;
      case '^':
        dir_x = 0; dir_y = -1;
        break;
      case 'v':
        dir_x = 0; dir_y = 1;
        break;
      case '?':
        {
          int r = rand() % 4;
          if (r == 0)      { dir_x = 1; dir_y = 0; }
          else if (r == 1) { dir_x = -1; dir_y = 0; }
          else if (r == 2) { dir_x = 0; dir_y = 1; }
          else if (r == 3) { dir_x = 0; dir_y = -1; }
        }
        break;
      case '_':
        if (!stack.empty()) {
          int val = stack.back();
          stack.pop_back();
          if (val == 0) {
            dir_x = 1; dir_y = 0;
          } else {
            dir_x = -1; dir_y = 0;
          }
        } else {
          dir_x = 1; dir_y = 0;
        }
        break;
      case '|':
        if (!stack.empty()) {
          int val = stack.back();
          stack.pop_back();
          if (val == 0) {
            dir_x = 0; dir_y = 1;
          } else {
            dir_x = 0; dir_y = -1;
          }
        } else {
          dir_x = 0; dir_y = 1;
        }
        break;
      case '"':
        string_mode = true;
        break;
      case ':':
        if (!stack.empty()) {
          stack.push_back(stack.back());
        } else {
          stack.push_back(0);
        }
        break;
      case '\\':
        if (stack.size() >= 2) {
          a = stack.back();
          stack.pop_back();
          b = stack.back();
          stack.pop_back();
          
          stack.push_back(a);
          stack.push_back(b);
        } else if (stack.size() == 1) {
          a = stack.back();
          stack.pop_back();
          
          stack.push_back(0);
          stack.push_back(a);
        } else {
          stack.push_back(0);
          stack.push_back(0);
        }
        break;
      case '$':
        if (!stack.empty()) {
          stack.pop_back();
        }
        break;
      case '.':
        if (!stack.empty()) {
          int val = stack.back();
          stack.pop_back();
          output += to_string(val);
        }
        break;
      case ',':
        if (!stack.empty()) {
          char val = static_cast<char>(stack.back());
          stack.pop_back();
          output += val;
        } else {
          output += static_cast<char>(0);
        }
        break;
      case '#':
        x += dir_x;
        y += dir_y;
        break;
      case 'g':
        if (!stack.empty()) {
          int val_y = stack.back();
          stack.pop_back();
          if (!stack.empty()) {
            int val_x = stack.back();
            stack.pop_back();
            if (val_y >= 0 && val_y < height &&
                val_x >= 0 && val_x < width) {
              stack.push_back(static_cast<int>(src[val_y][val_x]));
            } else {
              stack.push_back(0);
            }
          } else {
            stack.push_back(0);
          }
        } else {
          stack.push_back(0);
        }
        break;
      case 'p':
        if (stack.size() >= 3) {
          int val_y = stack.back();
          stack.pop_back();
          int val_x = stack.back();
          stack.pop_back();
          int val_v = stack.back();
          stack.pop_back();
          if (val_y >= 0 && val_y < height &&
              val_x >= 0 && val_x < width) {
            src[val_y][val_x] = static_cast<char>(val_v);
          }
        }
        break;
      case '@':
        return output;
    }

    x += dir_x;
    y += dir_y;

    if (y < 0) y = height - 1;
    if (y >= height) y = 0;
    if (x < 0) x = width - 1;
    if (x >= width) x = 0;
  }
}

inline int __main_interpret(int argc, char *argv[]) {
  string src;
  char ch;
  while (cin.get(ch)) {
    src += ch;
  }
  vector<string> grid = precompute(src);
  string output = compute(grid);
  cout << output;
}

inline int __main_testlib(int argc, char *argv[]) {
#ifdef MODE_TESTLIB
#include "testlib.h"
  registerTestlibCmd(argc, argv);

  string src;
  while (!inf.eof()) {
    src += inf.readChar();
  }
  
  vector<string> grid = precompute(src);
  string output = compute(grid);
  string ans_output;
  while (!ans.eof()) {
    ans_output += ans.readChar();
  }

  if (output == ans_output) {
    quit(_ok, "Outputs match");
  } else {
    quit(_wa, "Outputs do not match");
  }
  return 0;
#endif
}

int main(int argc, char *argv[]) {
#ifdef MODE_INTERPRET_ONLY
  return __main_interpret(argc, argv);
#endif
#ifdef MODE_TESTLIB
  return __main_testlib(argc, argv);
#else
  return 0;
#endif
}
