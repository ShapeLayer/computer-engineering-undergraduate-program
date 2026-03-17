#include "bits/stdc++.h"
using namespace std;

int main() {
  ios::sync_with_stdio(false);
  cin.tie(nullptr);
  cout.tie(nullptr);

  string get;
  vector<string> cache;

  do {
    cin >> get;
    if (get != "$$") {
      cache.push_back(get);
    }
  } while (get != "$$");

  sort(cache.begin(), cache.end());

  for (size_t i = 0; i < cache.size(); i++) {
    cout << cache[i] << endl;
  }

  return 0;
}
