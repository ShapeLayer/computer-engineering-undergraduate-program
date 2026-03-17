#include <iostream>
#include <string>
using namespace std;

int main() {

  int days;               //宿泊日数
  int fee;                //割引前の旅行代金
  bool transportation;    //交通の有無
  int youbi;              //旅行開始日の曜日（0:日,1:月,2:火,3:水,4:木,5:金,6:土）

  int discounted_fee;     //割引後の旅行代金
  int coupon = 0;         //地域クーポン支給額

  int discount_limit = 0; //割引後の旅行代金の下限

  cout << "宿泊日数：";
  cin >> days;
  cout << "旅行代金：";
  cin >> fee;
  cout << "交通(1：付，0：無）：";
  cin >> transportation;
  cout << "曜日（0:日,1:月,2:火,3:水,4:木,5:金,6:土）：";
  cin >> youbi;
  /************** これより上は変更禁止 **************/
  
  // 旅行代金の割引額
  int discounting_fee = (((double)fee * 100) * .2) / 100;

  // 交通付きの場合
  // 割引は1泊につき最大5000円
  if (transportation) { discounting_fee = min(5000 * days, discounting_fee); }

  // 交通無しの場合
  // 割引は1泊につき最大3000円
  else { discounting_fee = min(3000 * days, discounting_fee); }
  discounted_fee = fee - discounting_fee;


  // 地域クーポンの支給額
  // 土曜日の場合，クーポンの支給額は1000円
  // 土曜日以外の場合，クーポンの支給額は2000円
  int sat_includes = 0;
  for (int i = youbi; i < youbi + days; i++) {
    if (i % 6 == 0) sat_includes++;
  }

  coupon = 2000 * (days - sat_includes) + 1000 * sat_includes;

  // 旅行代金の下限の計算
  // 土曜日の場合，下限は2000円
  // 土曜日以外の場合，下限は3000円
  discount_limit = 2000 * (days - sat_includes) + 1000 * sat_includes + (int)(days + youbi % 6 == 0);

  // 割引後の旅行代金が下限を下回ったら割引なし＆クーポンなし
  if (discounted_fee < discount_limit) {
    discounted_fee = fee;
    coupon = 0;
  }


  /************** これより下は変更禁止 **************/
  // 結果を出力
  cout << "割引後の金額：" << discounted_fee << "円" << endl;
  cout << "地域クーポン支給額：" << coupon << "円" << endl;

  return 0;
}


/**
 * problem.md 2025-10-29
1 / 1
문제1(전국여행지원)
일본 관광에 대한 수요를 환기시키기 위해 전국 여행 지원 캠페인이 진행되고 있다.
구체적으로는 다음 규칙에 따라 여행비를 할인하고 지역 쿠폰을 지급한다.
숙박일수/여행대금/교통유무/출발일요일을 입력하면
할인된 여행비와 지급되는 지역 쿠폰의 금액을 표준으로 출력하는 프로그램을 만드세요.
유입 능력례
⼊⼒ 출력
2
55000
0
2
숙박일수 ︓ 여행대금 ︓ 교통(1︓부, 0︓무) ︓ 요일(0:일, 1:월, 2:⽕, 3:⽔, 4:⽊, 5:금, 6:⼟) ︓ 할인 후
금액 ︓ 49000엔
지역쿠폰지급액 ︓ 4000엔
2
4500
0
2
숙박일수 ︓ 여행대금 ︓ 교통(1︓부, 0︓무) ︓ 요일(0:일, 1:월, 2:⽕, 3:⽔, 4:⽊, 5:금, 6:⼟) ︓ 할인 후
금액 ︓ 4500엔
지역쿠폰지급액 ︓ 0엔
【규칙】
할인 금액은 원래 여행 대금의 20퍼센트로 한다.
할인액 중 1엔 미만은 절사된다(할인되지 않는다).
교통편을 이용한 여행의 경우, 1박당 할인액이 5000엔을 넘으면 1박당 할인액이 5000엔이 될 것이다.
무교통 여행의 경우, 1박당 할인액이 3000엔을 넘으면 1박당 할인액이 3000엔이 된다.
부여되는 지역 쿠폰의 금액은
평일과 일요일에 숙박할 경우, 1박당 2000엔어치
⼟요일에 숙박하는 경우, 하룻밤 숙박료는 1000엔의 가치가 있다.
단, 할인 후의 여행대금이 '평일과 일요일의 일수×3000엔 + ⼟요일 일수×2000엔'을 밑돌았을 경우
캠페인의 대상에서 제외되며, 할인액은 0엔, 지급되는 지역 쿠폰은 0엔으로 한다.
 */