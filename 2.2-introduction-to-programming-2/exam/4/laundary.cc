#include <iostream>
#include <queue>
#include <stack>
using namespace std;

/**
 * problem.md 2025-12-06
1 / 3
問6（コインランドリー）
コインランドリーでは，洗濯 → 乾燥 → 畳み の 3 段階の作業を⾏う．
코인런더리에 세탁, 건조, 접기 세 단계가 있음
洗濯機は W 台，乾燥機は D 台，畳む作業台は 1 台のみである．
세탁기 W대 건조기 D대 접이 작업대 1대

来店した客は，
매장 고객은
1. 洗濯待ち列に並び，
   세탁기을 기다리는 줄을 선다
2. 洗濯が終わると乾燥待ち列に⼊り，
   세탁이 끝나면 건조 대기열에 들어간다
3. 乾燥が終わると「最後に乾燥が終わった⼈から順に」畳む作業台で仕上げを⾏う．
   건조 긑나면 최후에 건조가 끝난 사람부터 작업대 (간다?)
洗濯機は 空いている順 に，待っている⼈から順に使われる．
세탁기는 비어있는 측?에 기다ㅣ리고 있는 사람부터 사용한다.
乾燥機も同様に，空いたら乾燥を待っている⾐類を，到着順でセットする．
건조기도 동일하게 비게되면 건조기를 기다리고 있는 옷수를 도착순으로 세트한다
⼀⽅，畳みスペースは 最後に到着した⾐類が先に処理される（スタック/LIFO）．
한편 접이 공간은 최후에 도착한 옷수가 먼저 처리된다
全員が「畳み」⼯程まで終えたとき，各客について
전원이 접기를 마치면 각 객에 대해
畳み完了時刻 − 洗濯開始時刻
접기 완료 시간 - 세탁 시작 시간
を求め，その合計を出⼒せよ。
그리고 합계를 출력하여라
（※「洗濯開始時刻」は，その客が実際に洗濯機を使い始めた時刻であり，到着時刻とは限らない。）
세탁 시작 시간은 고객이 실제로 세탁기를 사용 시작한 시간

⼊⼒
N W D
arrival_0 wash_0 dry_0 fold_0
arrival_1 wash_1 dry_1 fold_1
...
arrival_{N-1} wash_{N-1} dry_{N-1} fold_{N-1}

1 ⾏⽬に客数 N（1 ≤ N ≤ 100），洗濯機の台数 W（1 ≤ W ≤ 100），乾燥機の台数 D（1 ≤ D ≤ 100）が与えられる。
첫행에 고객 수 N, 세탁기 W, 건조기 D 주어짐
続く N ⾏には，i 番⽬の客について
다음 N행에서는 i번째 객에 대해

到着時刻 arrival_i（整数 0 以上）， 도착시각
洗濯に必要な時間 wash_i（整数 1 以上）， 세탁필요시간
乾燥に必要な時間 dry_i（整数 1 以上）， 건조필요시간
畳みに必要な時間 fold_i（整数 1 以上） 작업필요시간
が与えられる。

時刻はすべて整数で，単位は任意とする。 시각은 모두 정수, 단위는 임의

処理ルール（シミュレーション仕様）
처리 룰(시뮬레이션 명세)
■ 洗濯機（W 台） 세탁기
到着した客は洗濯待ち⾏列に⼊る。
도착한 고객이 세탁기 대기열에 들어감
problem.md 2025-12-06
2 / 3
洗濯機が空いていて待ち⾏列が空でない場合、
세탁기가 비어있다면 기다린 순으로 들어감
機械番号の⼩さい順に、待ち⾏列の先頭から割り当てられる。
기계번호순서대로 대기열의 맨 앞에서부터 배정
洗濯終了時刻になるとその客は乾燥待ち⾏列へ移動する。
세탁완료 시각이 되면 고객은 건조 대기열로 이동

■ 乾燥機（D 台）
乾燥機も洗濯機と同様に、空いた順・待っている順で客を割り当てる。
건조기는 세탁기와 동일
乾燥終了時刻になると、客は畳み待ちスタックへ積まれる。
건조를 마칠 시각에는 접길ㄹ 기다림

■ 畳みスペース（1 台）
畳みスペースが空いており、スタックに客がいる場合、
접이공간이 비어있고 스택에 고객이 있다면
スタックのトップ（最後に乾燥が終わった客） から畳み⼯程を⾏う。
스택 톱이 진행
畳み終了時刻がその客の全⼯程の終了時刻となる。
접이 완료 시각은 고객의 전 과정 종료 시각

出⼒
全員に対し
전원에 대해
畳み完了時刻 − 洗濯開始時刻
접이 완료 - 세탁 시작
を合計した値を整数で出⼒せよ。
정수로 출력

サンプル
● サンプル1
⼊⼒
3 2 1
0 3 4 2
0 3 4 2
1 3 4 2




세탁기 2대
건조기 1대

0 3 4 2
0 3 4 2
1 3 4 2

시간 0

t   세탁기            세탁기 큐     건조기           건조기 큐       접이
0   1[0, 3) 2[0, 3)
1                   3
2
3   3[3, 6)                     1[3, 7)         2
6                                               2, 3
7                               2[7, 11)        3            1[7, 9)
8
9                                                            -1
10
11                              3[11, 15)                    2[11, 13)
12
13                                                           -1
14
15                                                           3[15, 17)

1: [0, 9)
2: [0, 13)
3: [1, 17)




出⼒
36
● サンプル2
⼊⼒
problem.md 2025-12-06
3 / 3
3 1 2
0 2 1 6
1 2 2 12
1 1 1 4

세탁기 1대
건조기 2대

t   세탁기            세탁기 큐     건조기           건조기 큐       접이
0   1[0, 2)
1                   2, 3
2   2[2, 4)         3           1[2, 3)
3   3[]



出⼒
41
● サンプル3
⼊⼒
3 3 2
0 3 1 2
2 2 1 3
3 1 1 4
出⼒
23

 */

// 입력 시간순? 모르겠네

#define MAXN 100
#define MAXM 100
#define INF 2147483647

#include <algorithm>

struct Customer {
    int arrival;
    int wash_time;
    int dry_time;
    int fold_time;
};

bool cmp(Customer a, Customer b) {
    return a.arrival < b.arrival;
}

int N, W, D;
Customer customers[MAXN];

// free_time: 비는 시각
int washer_free_time[MAXM];
int washer_current_customer[MAXM];
int dryer_free_time[MAXM];
int dryer_current_customer[MAXM];

queue<int> washer_queue;
queue<int> dryer_queue;
stack<int> fold_stack;

int fold_free_time = 0;
int fold_current_customer = -1;

int finish_time_of_customer[MAXN];
int wash_start_time[MAXN];

int current_time = 0;

void assign_washers() {
    /*回答記入箇所①*/
    for (int i = 0; i < W; i++) {
        if (washer_free_time[i] > current_time) continue;
        if (washer_current_customer[i] != -1) {
            dryer_queue.push(washer_current_customer[i]);
            washer_current_customer[i] = -1;
        }
        if (!washer_queue.empty()) {
            auto customer_id = washer_queue.front();
            washer_current_customer[i] = customer_id;
            washer_free_time[i] = current_time + customers[customer_id].wash_time;
            washer_queue.pop();
            wash_start_time[customer_id] = current_time;
        }
    }
}

void assign_dryers() {
    /*回答記入箇所②*/
    for (int i = 0; i < D; i++) {
        if (dryer_free_time[i] > current_time) continue;
        if (dryer_current_customer[i] != -1) {
            fold_stack.push(dryer_current_customer[i]);
            dryer_current_customer[i] = -1;
        }
        if (!dryer_queue.empty()) {
            auto customer_id = dryer_queue.front();
            dryer_current_customer[i] = customer_id;
            dryer_free_time[i] = current_time + customers[customer_id].dry_time;
            dryer_queue.pop();
        }
    }
}

int finished_count = 0;
void assign_folder() {
    /*回答記入箇所③*/
    if (fold_free_time > current_time) return;
    if (fold_current_customer != -1) {
        finish_time_of_customer[fold_current_customer] = current_time;
        fold_current_customer = -1;
        finished_count++;
    }
    if (!fold_stack.empty()) {
        auto customer_id = fold_stack.top();
        fold_current_customer = customer_id;
        fold_free_time = current_time + customers[customer_id].fold_time;
        fold_stack.pop();
    }
}

int main() {

    cin >> N >> W >> D;

    for (int i = 0; i < N; i++) {
        cin >> customers[i].arrival
            >> customers[i].wash_time
            >> customers[i].dry_time
            >> customers[i].fold_time;
    }

    // sort(customers, customers+N, cmp);

    for (int i = 0; i < W; i++) {
        washer_free_time[i] = 0;
        washer_current_customer[i] = -1;
    }
    for (int i = 0; i < D; i++) {
        dryer_free_time[i] = 0;
        dryer_current_customer[i] = -1;
    }

    for (int i = 0; i < N; i++) {
        finish_time_of_customer[i] = -1;
        wash_start_time[i] = -1;
    }

    // int finished_count = 0;
    int next_arrival_idx = 0;

    if (N > 0) current_time = customers[0].arrival;

    while (finished_count < N) {
        /*回答記入箇所④*/
        
        while (next_arrival_idx < N && customers[next_arrival_idx].arrival <= current_time) {
            washer_queue.push(next_arrival_idx);
            next_arrival_idx++;
        }

        assign_washers();
        assign_dryers();
        assign_folder();
        

        current_time++;

        // cout << "current time: " << current_time << ' '
        //     << fold_free_time << ' ' << "(" << fold_current_customer << ") " << finished_count << endl;
    }

    // --- 合計（畳み終了 - 洗濯開始） ---
    int total = 0;
    for (int i = 0; i < N; i++) {
        total += finish_time_of_customer[i] - wash_start_time[i];
    }
    cout << total << endl;

    return 0;
}
