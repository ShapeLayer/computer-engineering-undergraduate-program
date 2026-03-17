#include "bits/stdc++.h"
using namespace std;

int main() {
  ios_base::sync_with_stdio(false);
  cin.tie(nullptr);
  cout.tie(nullptr);
  
  // input
  // 숙박일수, 여행대금, 교통유무, 발행일의 요일
  int days, credits, transport, starts_at;
  cin >> days >> credits >> transport >> starts_at;

  /**
   * 대금 할인
   * 
   * 할인 금액: 대금의 20%
   * 1엔 미만 절사
   * 교통편 사용: 최대 5000엔/1박, 미사용 3000엔/1박
   */

  bool transport_used = transport;

  int saled = ((double)(credits * 100) * .2) / 100;
  // int saled = (double)credits * .2;
  if (transport_used) saled = min(5000 * days, saled);
  else saled = min(3000 * days, saled);

  /**
   * 지역 쿠폰
   * 
   * 2000엔/1박 (토요일: 1000엔/1박)
   */

  int sat_includes = 0;
  for (int i = starts_at; i < starts_at + days; i++) {
    if (i % 6 == 0) sat_includes++;
  }

  int regional_coupon = 2000 * (days - sat_includes) + 1000 * sat_includes;

  /**
   * 할인 후 (평일/일요일) * 3000 + 토요일 * 2000 이하인 경우 할인액 0엔
   */
  
  if (credits - saled <= (
    3000 * (days - sat_includes /* + (int)(days + starts_at % 6 != 0) + */) + 
    2000 * sat_includes /* + (int)(days + starts_at % 6 == 0) */
  )) {
    saled = 0;
    regional_coupon = 0;
  }

  cout << "宿泊日数：旅行代金：交通(1：付，0：無）：曜日（0:日,1:月,2:火,3:水,4:木,5:金,6:土）：割引後の金額：" << credits - saled << "円" << endl;
  cout << "地域クーポン支給額：" << regional_coupon << "円" << endl;
  
  return 0;
}
