#include "bits/stdc++.h"
using namespace std;

int main() {
  int n = 10;
  vector<int> vec;
  while(n--) {
    vec.push_back(n);
  }

  vector<int>::iterator it;
  for (it = vec.begin(); it != vec.end(); it++) {
    cout << *it << endl;
  }
}
