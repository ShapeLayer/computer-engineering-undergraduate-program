#include "bits/stdc++.h"
using namespace std;

/**
 * map을 사용하여 주어진 환율표를 만들어라
 * 환율과 통화명을 맵에 추가
 * 
 * 두번째로 환율이 높은 통화 출력
 */

#define US "米ドル"
#define EU "ユーロ"
#define UK "英ポンド"
#define SW "スイスフラン"
#define AU "オーストラリアドル"
#define NW "ニュージーランドドル"

bool compare(const pair<string, double> &, const pair<string, double> &);

int main() {
  ios_base::sync_with_stdio(false);
  cin.tie(nullptr);
  cout.tie(nullptr);

  map<string, double> exchanges;

  exchanges.insert(make_pair(US, 149.18));
  exchanges.insert(make_pair(EU, 156.77));
  exchanges.insert(make_pair(UK, 180.21));
  exchanges.insert(make_pair(SW, 164.39));
  exchanges.insert(make_pair(AU, 93.26));
  exchanges.insert(make_pair(NW, 87.17));

  pair<string, double> get;
  cin >> get.second >> get.first;
  exchanges.insert(get);

  vector<pair<string, double>> table_sorted = vector<pair<string, double>>(exchanges.begin(), exchanges.end());

  sort(table_sorted.begin(), table_sorted.end(), compare);

  bool flag = false;
  for (auto each : table_sorted) {
    if (flag) {
      cout << each.first << endl;
      return 0;
    }
    flag = true;
  }

  return 0;
}

bool compare(const pair<string, double> &a, const pair<string, double> &b) {
  if (a.second == b.second) return a.first < b.first;
  return a.second > b.second;
}
