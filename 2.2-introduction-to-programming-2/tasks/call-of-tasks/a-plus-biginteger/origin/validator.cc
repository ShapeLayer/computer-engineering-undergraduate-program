#include "testlib.h"
using namespace std;

inline bool is_dash_only(const string &s) {
  if (s[0] != '-') return false;
  return s.size() == 1;
}

inline bool contains_leading_zero(const string &s) {
  if (s[0] == '-') {
    return s.size() > 2 && s[1] == '0';
  } else {
    return s.size() > 1 && s[0] == '0';
  }
}

int main(int argc, char* argv[]) {
  registerValidation(argc, argv);
  string A, B;
  
  A = inf.readToken("-?[0-9]{1,200}", "A");
  if (is_dash_only(A)) {
    __testlib_fail("A is dash only");
  }
  if (contains_leading_zero(A)) {
    __testlib_fail("A contains leading zero");
  }
  inf.readSpace();
  B = inf.readToken("-?[0-9]{1,200}", "B");
  if (is_dash_only(B)) {
    __testlib_fail("B is dash only");
  }
  if (contains_leading_zero(B)) {
    __testlib_fail("B contains leading zero");
  }
  inf.readEoln();
  inf.readEof();
  return 0;
}
