#include "bits/stdc++.h"
using namespace std;

inline bool contains(
  const vector<string> *,
  const string &,
  size_t,
  size_t
);

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

  do {
    cin >> get;
    if (get != "$$") {
      if (contains(&cache, get, 0, cache.size())) {
        cout << "存在する" << endl;
      } else {
        cout << "存在しない" << endl;
      }
    }
  } while (get != "$$");

  return 0;
}

inline bool contains(
  const vector<string> *vec,
  const string &target,
  size_t begin,
  size_t end
) {
  if (begin >= end) {
    return false;
  }

  size_t mid = (begin + end) / 2;

  if (vec->at(mid) == target) {
    return true;
  } else if (vec->at(mid) < target) {
    return contains(vec, target, mid + 1, end);
  } else {
    return contains(vec, target, begin, mid);
  }
}
