#include "bits/stdc++.h"
using namespace std;

int main() {
  ios_base::sync_with_stdio(false);
  cin.tie(nullptr);
  cout.tie(nullptr);

  cout << "整数を入力してください" << endl;
  cout << "(zで終了, cでクリア, sでソート, oで表示):" << endl;

  /**
   * Inputs:
   * z -- exit
   * c -- 홀 짝 리스트 전부 클리어
   * s -- 홀 짝 리스트 각 오름차순 정렬
   * o -- 홀 짝 리스트 표시
   * # -- 입력
   */

  string get;
  cin >> get;

  vector<int> odd, even;
  int __tmp_n;
  for (char each : get) {
    if ('0' <= each && each <= '9') {
      __tmp_n = each - '0';
      if (__tmp_n % 2 == 1) {
        odd.push_back(__tmp_n);
      } else {
        even.push_back(__tmp_n);
      }
    } else {
      switch (each) {
        case 'z':
          return 0;
        case 'c':
          odd.clear();
          even.clear();
          break;
        case 's':
          sort(odd.begin(), odd.end());
          sort(even.begin(), even.end());
          break;
        case 'o':
          cout << "奇数：";
          for (auto each : odd) { cout << each << ' '; }
          cout << endl;
          cout << "偶数：";
          for (auto each : even) { cout << each << ' '; }
          cout << endl;
          break;
      }
    }
  }

  return 0;
}
