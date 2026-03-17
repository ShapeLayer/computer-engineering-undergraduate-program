#include "bits/stdc++.h"
#include "testlib.h"
using namespace std;
#define LEN 10'000

int main(int argc, char* argv[]) {
  registerValidation(argc, argv);

  int curr_len = 0;

  char curr;
  do {
    if (curr_len > LEN) {
      __testlib_fail("Input must be less then LEN.");
    }
    curr = inf.readChar();
    if ((int) curr < 0) break;
    curr_len++;
  } while (true);

  inf.readEof();

  return 0;
}
