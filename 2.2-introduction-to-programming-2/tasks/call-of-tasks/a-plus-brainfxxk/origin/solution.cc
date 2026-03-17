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
        ptr = (ptr + 1) % MEM_SIZE;
        break;
      case '<':
        ptr = (ptr - 1 + MEM_SIZE) % MEM_SIZE;
        break;
      case '+':
        mem[ptr]++;
        break;
      case '-':
        mem[ptr]--;
        break;
      case '.':
        result += (char)mem[ptr];
        break;
      case '[':
        if (mem[ptr] == 0) {
          loop_ll = 1;
          while (loop_ll > 0) {
            i++;
            if (src[i] == '[') loop_ll++;
            else if (src[i] == ']') loop_ll--;
          }
        }
        break;
      case ']':
        if (mem[ptr] != 0) {
          loop_ll = 1;
          while (loop_ll > 0) {
            i--;
            if (src[i] == '[') loop_ll--;
            else if (src[i] == ']') loop_ll++;
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
