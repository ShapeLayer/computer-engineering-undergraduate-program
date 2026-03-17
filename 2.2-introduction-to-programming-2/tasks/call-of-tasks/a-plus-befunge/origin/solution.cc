#include "bits/stdc++.h"
using namespace std;

#define MAX_N 1000

bool is_prime[MAX_N + 1];
void init_is_prime() {
  for (int i = 0; i < MAX_N + 1; i++) {
    is_prime[i] = true;
  }
  is_prime[0] = false;
  is_prime[1] = false;
  for (int i = 2; i < MAX_N + 1; i++) {
    if (is_prime[i]) {
      for (int j = i; j < MAX_N; j += i) {
        is_prime[j] = false;
      }
    }
  }
}

inline int gcd(int a, int b) {
  if (a == 0) return b;
  return gcd(b % a, a);
}

bool get_min_divs(int n, vector<int> *buf, int min_len, int now_depth) {
  if (n == 1) {
    if (now_depth < min_len) {
      min_len = now_depth;
      buf->clear();
      return true;
    }
    return false;
  }

  bool is_updated = false;
  if (n > 10) {
    if (!is_prime[n]) {
      // product
      for (int i = 2; i < 10; i++) {
        if (n % i == 0) {
          if (get_min_divs(n / i, buf, min_len, now_depth + 1)) {
            buf->push_back(i);
            is_updated = true;
          }
        }
      }
    } else {
      // sum
      for (int i = 1; i < n; i++) {
        int _a = i;
        int _b = n - i;
        
      }
    }
  } else {
    /**
     * the case that n < 10 and is_prime[n] = true
     * cannot reach this block:
     * 
     * 1. divisor is already inserted into buf 
     *  - for loop in range [2, 10)
     *  - if can divide, divisor has been inserted
     * 2. divided
     *. - 
     */
    buf->push_back(n);
  }
  return is_updated;
}

int main() {
  int A, B;
  cin >> A >> B;

  int _gcd = gcd(A, B);
  int _a_remains = A / _gcd;
  int _b_remains = B / _gcd;

  vector<int> buf;
  get_min_divs(_a_remains, &buf, (int)1e10, 0);
  for (auto each : buf) {
    cout << each << ' ';
  }
  cout << endl;

  return 0;
}
