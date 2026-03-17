#include "testlib.h"
using namespace std;

int main(int argc, char* argv[]) {
  registerGen(argc, argv, 1);

  string faculties[] = {
    "education",
    "science_and_engineering",
    "economics",
    "agriculture",
    "art_and_regional_design"
  };
  int N = atoi(argv[1]);
  cout << N << endl;
  for (int i = 0; i < N; i++) {
    cout << faculties[rnd.next(0, 4)] << " " << rnd.next(1, 1000) << " " << rnd.next(0, 100) << endl;
  }

  return 0;
}
