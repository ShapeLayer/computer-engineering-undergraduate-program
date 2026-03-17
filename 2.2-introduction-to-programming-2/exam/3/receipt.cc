#include <iostream>
#include <string>
#include <cmath>
using namespace std;

#define MAX_ITEMS 10

/**
 * problem.md 2025-11-22
1 / 2
問1（レシートの発⾏）
あなたは，スーパーマーケットで買い物をする．
슈퍼마켓에서 카이모노
購⼊した商品の情報を⼊⼒し，
입수한 상품 입력됨
次の条件に従ってレシートを出⼒するプログラムを作成しなさい．
이어지는 요구사항에 맞게 영수증 출력하시오
1.最初に，購⼊する商品の数 N（最⼤10個まで）を⼊⼒する．
최초에 구매할 제품 수 최대 10개 입력
2.各商品について以下を⼊⼒する：
각상품에 관해서 입력한다

・商品名（英単語）영단어 제품명
・単価（整数）가격
・数量（整数）수량
3.消費税率は以下の通り：
소비세율은 이하대로
・商品名の⽂字数が5⽂字以上 → 税率10%
제품명 글자수 5자 이상이면 세율 10%
・商品名の⽂字数が4⽂字以下 → 税率8%
글자수 4자 이하이면 세율 8%
4.各商品の⼩計（税込）を求める（＊結果は四捨五⼊せよ）．
각 제품에 대한 세금 포함 결과를 찾는다 결과는 반올림
その後，各商品の⼩計を出⼒する．
그 후 각 곱에 대한 소계 출력
5.全商品の税別合計が5000円以上の場合，税別⾦額の3%割引を適⽤する．
전상품의 세금 제외 금액이 5000엔 이상인 경우, 세금제외금액의 3% 할인
その後，商品ごとに⼩計（税込）を求める（＊結果は四捨五⼊せよ）．
그후 상품에 대해 세금이 포함된 소합 구하라 결과는 사사오입


칠판
전품목의 세별 합계가 5000엔 이상인 경우 세입금액의 3% 할인을 사용한다.



6.割引を考慮した最終合計（税込）を出⼒する（＊結果は四捨五⼊せよ）． 
할인을 고려한 최종 금액 (세입)출력하여라
problem.md 2025-11-22
2 / 2
⼊⼒される値
N
itemName_1 itemPrice_1 itemQuantity_1
...
itemName_N itemPrice_N itemQuantity_N
1⾏⽬に，購⼊する商品の数 N（1〜10） が⼊⼒される．
続くN⾏には，各商品の情報が以下の形式で⼊⼒される︓
・商品名（英単語）
・単価（整数）
・数量（整数）
期待される出⼒値
itemName_1 : subtotalAfterTax_1 yen
...
itemName_N : subtotalAfterTax_N yen
Total : finalAfterTax yen
各商品ごとに，税込の⼩計⾦額を出⼒する．
最後に，全体の合計（税込・割引適⽤後）を出⼒する．
出⼒の各⾏末には " yen" を付ける．
⼩数計算は⾏わず，整数演算（四捨五⼊など）で計算する．
サンプルケース
⼊⼒ 出⼒
3
apple 120 3
milk 150 2
bread 100 1
apple : 396 yen
milk : 324 yen
bread : 110 yen
Total : 830 yen
2
orange 200 5
egg 300 2
orange : 1100 yen
egg : 648 yen
Total : 1748 yen
3
banana 300 10
tea 200 5
coffee 500 4
banana : 3300 yen
tea : 1080 yen
coffee : 2200 yen
Total : 6383 yen

 */
#define i64 long long
// tc x: 오버플로우는 아님

i64 _round(int n) {
    //cout << n << endl;
    return (n % 10 < 5 ? (n / 10) : (n / 10) + 1);
}
i64 _roundlf(double n) {
    return ((i64)(n * 10)) % 10 < 5 ? (i64)n : (i64)n + 1;
}

int main() {
    // 조건 1 시작
    // 최초에 구매할 제품 수 최대 10개 입력
    string itemNames[MAX_ITEMS];
    int itemPrices[MAX_ITEMS];
    int itemQuantities[MAX_ITEMS];

    int numberOfItems;
    cin >> numberOfItems;

    if (numberOfItems < 1 || numberOfItems > MAX_ITEMS) {
        cout << "Invalid number of items." << endl;
        return 0;
    }


    // 조건 1 끝
    // 조건 2 시작
    // 각 상품에 관해 입력
    // 入力
    for (int i = 0; i < numberOfItems; i++) {
        cin >> itemNames[i] >> itemPrices[i] >> itemQuantities[i];
    }
    // 조건 2 끝

    // 조건 3 소비세율
    int taxPercents[MAX_ITEMS];
    int subtotalBeforeTax[MAX_ITEMS];
    int subtotalAfterTax[MAX_ITEMS];

    int totalBeforeTax = 0;
    int totalAfterTax = 0;

    for (int i = 0; i < numberOfItems; i++) {
        // 조건 3 - 제품명 글자수에 따라 세율 변화
        taxPercents[i] = itemNames[i].size() < 5 ? 8 : 10;
        subtotalBeforeTax[i] = itemPrices[i] * itemQuantities[i];
        
    // 조건 3 끝
    // 조건 4
    // 각 제품에 대한 세금 포함 결과 구하기
    // 결과는 사사오입
        // tc 7 13 ac
        // subtotalAfterTax[i] = _round(((i64)subtotalBeforeTax[i] * (100 + taxPercents[i])) / 10);
        // tc5 ??
        subtotalAfterTax[i] = round((((double)subtotalBeforeTax[i]) * (100 + taxPercents[i])) / 100);

        totalBeforeTax += subtotalBeforeTax[i];
        totalAfterTax += subtotalAfterTax[i];
    }
    
    // 그 후 각 곱에 대한 소계 출력
    for (int i = 0; i < numberOfItems; i++)
        cout << itemNames[i] << " : " << subtotalAfterTax[i] << " yen" << endl;
    // 조건 4 끝

    int finalAfterTax = totalAfterTax;

    // if (totalBeforeTax >= 5000)
    // tc5 wa:
    //     finalAfterTax = round((double)totalAfterTax * 0.97);
    // tc5 wa:
    //    finalAfterTax = totalAfterTax - round((double)totalAfterTax * 0.03);

    // tc5 wa:
    // i64 _finalAfterTax = totalAfterTax * 97;
    // _finalAfterTax /= 10;
    // if (totalBeforeTax >= 5000) {
    //     if (_finalAfterTax % 10 < 5) {
    //     finalAfterTax = _finalAfterTax / 10;
    //     } else {
    //         finalAfterTax = _finalAfterTax / 10 + 1;
    //     }
    // }

    // i64 _finalAfterTax = totalAfterTax * 97;
    // if (totalBeforeTax >= 5000) {
    //     if (_finalAfterTax % 100 < 50) {
    //     finalAfterTax = _finalAfterTax / 100;
    //     } else {
    //         finalAfterTax = _finalAfterTax / 100 + 1;
    //     }
    // }


    /**
     * ABOUT TESTCASE #2 (run-5):
     * 
     * in:
     * ```
     * 4
     * apple 120 10
     * tv 30000 1
     * milk 90 3
     * banana 50 20
     * ```
     * 
     * judge:
     * ```
     * apple : 1320 yen
     * tv : 32400 yen
     * milk : 292 yen
     * banana : 1100 yen
     * Total : 34058 yen
     * ```
     * 
     * actual:
     * ```
     * apple : 1320 yen
     * tv : 32400 yen
     * milk : 292 yen
     * banana : 1100 yen
     * Total : 34059 yen
     * ```
     * 
     * Conclusion:
     * totalAfterTax (before discount) = 35112
     * 35112 * .97 = 34058.64
     * 35112 * .03 = 1053.36
     * 
     * if calculating expression is
     * finalAfterTax = totalAfterTax - round(totalAfterTax * 0.03);
     * then,
     * finalAfterTax = 35112 - 1053 = 34059 (wrong)
     * 
     * if calculating expression is
     * finalAfterTax = round(totalAfterTax * 0.97);
     * then,
     * finalAfterTax = 34059 (wrong)
     */
    
    i64 _finalAfterTaxOffset = totalAfterTax * 3;
    if (_finalAfterTaxOffset % 100 < 50) {
        _finalAfterTaxOffset = _finalAfterTaxOffset / 100;
    } else {
        _finalAfterTaxOffset = _finalAfterTaxOffset / 100 + 1;
    }
    if (totalBeforeTax >= 5000) {
        finalAfterTax = totalAfterTax - _finalAfterTaxOffset;
    }

    goto pass_legacy;

    // 조건 5
    // 세별 금액 5000엔 이상인 경우 세금포함 3% 할인
    finalAfterTax = totalAfterTax;
    // tc12 : 이상이 맞음
    if (totalBeforeTax >= 5000) {
        // finalAfterTax -= (finalAfterTax * 3) / 100;
        // finalAfterTax = finalAfterTax * 97 / 100;
        /* 이건 아님:
        3
        banana 300 10
        tea 200 5
        coffee 500 4
        banana : 3300 yen
        tea : 1080 yen
        coffee : 2200 yen
        Total : 6382 yen << 이게 틀렸음
        */ 
        // 은 무슨 이거 사사오입임
        // tc wa
        // finalAfterTax = _round(((i64)totalBeforeTax * 97) / 10) - totalBeforeTax + finalAfterTax;


        // finalAfterTax = totalAfterTax - _roundlf((double)totalAfterTax * 0.03);
        finalAfterTax = _roundlf((double)totalAfterTax * 0.97);
        
        // tc6 wa:
        // totalTaxIncluded - round(totalTaxIncluded * 0.03)
        // i64 _powered = (totalAfterTax * 100);
        // _powered *= 0.03;
        // if ((_powered / 10) % 10 < 5) {
        //     finalAfterTax = totalAfterTax - _powered / 100;
        // } else {
        //     finalAfterTax = totalAfterTax - _powered / 100 + 1;
        // }

        i64 _powered = (totalAfterTax * 3);
        

        // round(totalTaxIncluded * 0.97)
        // i64 _powered = (totalAfterTax * 100);
        // _powered *=  0.97;
        // if ((_powered / 10) % 10 < 5) {
        //     finalAfterTax = _powered / 100;
        // } else {
        //     finalAfterTax = _powered / 100 + 1;
        // }

        // finalAfterTax = _round(((i64)finalAfterTax * 97) / 10);
        // tc6 ac
    }
    // 조건 5 끝

pass_legacy:

    // 조건 6
    // 할인 고려한 최종 금액 출력
    cout << "Total : " << finalAfterTax << " yen" << endl;
    // 조건 6 끝

    return 0;
}

// 진짜 머임..
