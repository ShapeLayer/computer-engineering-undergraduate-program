#include "testlib.h"

int main(int argc, char* argv[]) {
  registerValidation(argc, argv);
  int A = inf.readInt(0, 50, "A");
  inf.readSpace();
  int B = inf.readInt(0, 50, "B");
  inf.readEoln();
  int w = inf.readInt(1, 20, "w");
  inf.readSpace();
  int h = inf.readInt(1, 20, "h");
  inf.readEoln();
  inf.readEof();
  return 0;
}
