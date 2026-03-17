#include <iostream>
using namespace std;

/*
 * problem.md 2025-11-22
1 / 2
問2（旅⾏費⽤の清算）
あなたは，友⼈グループで数⽇間の旅⾏に出かける．
수일간의 그룹 => 여행을 감

1⽇ごとに，代表して誰か1⼈が⽴て替えて⽀払いを⾏うことにした．
하루에 1인이 지불해야 한다
旅⾏が終わったあと，全員が公平に費⽤を負担するために，
여행이 끝나게 되면 전원이 공평하게 이용하는 것 때문에
「誰が誰にいくら⽀払えばよいか」を計算するプログラムを作成せよ．
각인이 지불해야하는가 계산하는 프로그램을 작성해야한다
標準⼊⼒で，各⽇の⽀払総額と，⽴て替えた⼈の番号が与えられる．
표준입력에 매일 지불된 총 금액과 납부한 사람 번호 (식별자?)
プログラムは，全体の合計⾦額・各⼈の収⽀差額，
플고그램은 전체 금액과, 각인의 수입/지출 차액을 기준으로
そして最終的な⽀払指⽰を出⼒せよ．
최종 결제 지침을 출력

⼊⼒される値
1⾏⽬：旅⾏⽇数（days） 여행 날들
2⾏⽬：参加者⼈数（people） 인원
以降，各⽇の⽀払情報（以下をdays回繰り返す）
각일의 결제정보
・⽀払総額（cost）
・⽴て替えた⼈の番号（payer）
期待される出⼒値
以下の形式で出⼒せよ（endlで改⾏）．
総費⽤: ○○円
1⼈あたりの負担額: ○○円
各⼈の収⽀差額:
1⼈⽬: +△△円
2⼈⽬: -□□円
...
⽀払指⽰:
A⼈⽬ → B⼈⽬: ⾦額円
problem.md 2025-11-22
2 / 2
サンプルケース
⼊⼒ 出⼒
3
3
12000 1
18000 2
9000 3
総費⽤: 39000円
1⼈あたりの負担額: 13000円
各⼈の収⽀差額:
1⼈⽬: -1000円
2⼈⽬: +5000円
3⼈⽬: -4000円
⽀払指⽰:
1⼈⽬ → 2⼈⽬: 1000円
3⼈⽬ → 2⼈⽬: 4000円
3
3
10000 1
5000 1
15000 2
総費⽤: 30000円
1⼈あたりの負担額: 10000円
各⼈の収⽀差額:
1⼈⽬: +5000円
2⼈⽬: +5000円
3⼈⽬: -10000円
⽀払指⽰:
3⼈⽬ → 1⼈⽬: 5000円
3⼈⽬ → 2⼈⽬: 5000円
3
3
9000 1
9000 2
9000 3
総費⽤: 27000円
1⼈あたりの負担額: 9000円
各⼈の収⽀差額:
1⼈⽬: 0円
2⼈⽬: 0円
3⼈⽬: 0円
⽀払指⽰:
)*/

int main() {
    int days;
    int people;

    cin >> days;
    cin >> people;

    int payments[10];
    for (int i = 0; i < people; i++) {
        payments[i] = 0;
    }

    int totalAmount = 0;

    for (int d = 0; d < days; d++) {
        int cost;
        int payer;
        cin >> cost;
        cin >> payer;
        payments[payer - 1] += cost;
        totalAmount += cost;
    }

    cout << "総費用: " << totalAmount << "円" << endl;
    
    // 초기코드에 없음:
    // 테스트런 필요
    int avg = totalAmount / people;
    cout << "1人あたりの負担額: " << avg << "円" << endl;
    
    cout << "各人の収支差額:" << endl;

    int diff[10] = { 0 };
    for (int i = 0 ; i < people; i++) {
        diff[i] = payments[i] - avg;
        cout << i + 1 << "人目: ";
        if (diff[i] > 0) {
            cout << "+" << diff[i] << "円" << endl;
        } else {
            cout << diff[i] << "円" << endl;
        }
    }

    cout << "支払指示:" << endl;

#define MIN(a, b) (a > b ? b : a)
#define ABS(n) (n > 0 ? n : -n)

    // 支払う人（マイナス）と受け取る人（プラス）を処理
    for (int debtor = 0; debtor < people; debtor++) {
        for (int creditor = 0; creditor < people; creditor++) {
            if (diff[debtor] >= 0) continue;
            if (diff[creditor] <= 0) continue;

            // -10000엔
            // +5000엔
            int amount = MIN(ABS(diff[debtor]), ABS(diff[creditor]));
            diff[creditor] -= amount;
            diff[debtor] += amount;
            cout << debtor + 1 << "人目 → " << creditor + 1 << "人目: " << amount << "円" << endl;
        }


    }

    return 0;
}
