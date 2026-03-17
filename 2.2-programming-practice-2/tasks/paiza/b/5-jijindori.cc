#include <iostream>
#include <vector>
using namespace std;

int main() {
  int N, Q;
  cin >> N >> Q;

  vector<int> jins(N + 1, 0);
  
  string user;
  int target;
  while (Q--) {
    cin >> user >> target;
    if (jins[target] != 0) {
      continue;
    }
    jins[target] = (user == "A" ? 1 : 2);
  }

  int a = 0, b = 0;
  while (N--) {
    int curr = jins[N + 1];
    if (curr == 1) {
      a++;
    } else if (curr == 2) {
      b++;
    }
  }

  if (a > b) {
    cout << "A" << endl;
  } else if (a < b) {
    cout << "B" << endl;
  } else {
    cout << "Draw" << endl;
  }
  return 0;
}
