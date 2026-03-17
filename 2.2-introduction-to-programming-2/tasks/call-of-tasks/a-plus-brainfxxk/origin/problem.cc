#include <iostream>
using namespace std;

#define MEM_SIZE 32768
unsigned char mem[MEM_SIZE] = { 0 };
int ptr = 0;

string compute(string src) {
  string result = "";
  unsigned int i, loop_ll;
  size_t len = src.length();

  for (i = 0; i < len; i++) {
    char curr = src[i];

    switch (curr) {
      case '>':
        /* 回答箇所 */
        break;
      case '<':
        /* 回答箇所 */
        break;
      case '+':
        /* 回答箇所 */
        break;
      case '-':
        /* 回答箇所 */
        break;
      case '.':
        /* 回答箇所 */
        break;
      case '[':
        if (mem[ptr] == 0) {
          loop_ll = 1;
          while (loop_ll > 0) {
            i++;
            /* 回答箇所 */
          }
        }
        break;
      case ']':
        if (mem[ptr] != 0) {
          loop_ll = 1;
          while (loop_ll > 0) {
            i--;
            /* 回答箇所 */
          }
        }
        break;
    }
  }
  
  return result;
}

int main() {
  string data;
  string src;

  char ch;
  while (cin.get(ch)) {
    src += ch;
  }

  data = compute(src);

  cout << data << endl;

  return 0;
}
