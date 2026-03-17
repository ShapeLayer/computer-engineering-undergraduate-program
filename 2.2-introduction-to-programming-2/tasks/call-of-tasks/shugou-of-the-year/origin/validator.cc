#include "testlib.h"
using namespace std;

int main(int argc, char* argv[]) {
  registerValidation(argc, argv);
  int N;
  int V, P;
  string S;
  
  N = inf.readInt(1, 1000000, "N");
  inf.readEoln();

  for (int i = 0; i < N; i++) {
    S = inf.readToken("[a-z_]{1,25}", "S");
    inf.readSpace();
    V = inf.readInt(1, 1000, "V");
    inf.readSpace();
    P = inf.readInt(0, 100, "P");
    inf.readEoln();

    if (!(
      S == "education" ||
      S == "science_and_engineering" ||
      S == "economics" ||
      S == "agriculture" ||
      S == "art_and_regional_design"
    )) {
      __testlib_fail("invalid faculty name");
    }
  }

  inf.readEof();
  return 0;
}
