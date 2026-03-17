#include "bits/stdc++.h"
using namespace std;

bool precede(string, string);

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

  sort(cache.begin(), cache.end(), precede);

  for (size_t i = 0; i < cache.size(); i++) {
    cout << cache[i] << endl;
  }

  return 0;
}

bool precede(string str1, string str2) {
  size_t len1 = str1.length();
  size_t len2 = str2.length();
  size_t minlen = min(len1, len2);

  return len1 != len2 ? len1 < len2 : str1 < str2;
}
