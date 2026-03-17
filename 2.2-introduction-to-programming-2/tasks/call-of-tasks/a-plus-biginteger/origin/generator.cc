#include "testlib.h"
using namespace std;

#define _0 48
#define _1 49
#define _9 57

int main(int argc, char* argv[]) {
  registerGen(argc, argv, 1);
  int L_A = opt<int>(1);
  int L_B = opt<int>(2);
  bool S_A = opt<bool>(3);
  bool S_B = opt<bool>(4);

  string A = S_A ? "-" : "";
  A += (char)rnd.next(_1, _9);
  for (int i = 1; i < L_A; i++) {
    A += (char)rnd.next(_0, _9);
  }
  string B = S_B ? "-" : "";
  B += (char)rnd.next(_1, _9);
  for (int i = 1; i < L_B; i++) {
    B += (char)rnd.next(_0, _9);
  }
  cout << A << ' ' << B << endl;

  return 0;
}
