#include <iostream>
#include <vector>
#include <algorithm>
#include <string>
using namespace std;

/**
 * problem.md 2025-12-06
1 / 3
問5（寿司レーンイベント処理）

あなたは回転寿司チェーンの開発担当者である．
컨베이어 벨트 스시 체인 개발을 담당
店内の寿司レーン上を流れる⽫の情報を扱うプログラムを作成せよ．
스시 레인을 지나가는 접시 정보를 처리하는 프로그램
レーンには N 枚の⽫があり，各⽫には次の 3 つの属性がある︓
N개의 접시가 있고, 각 요리에는 세 가지 능력치
寿司の種類（⽂字列）
초밥(줄기)의 종류
鮮度（時間経過で減少する整数）
신선도(시간이 지남에 따라 감소하는 정수)
⼈気度（固定の整数）
인기도 고정
⽫は左から右に並んでおり，さらに 1 回だけ与えられるイベントを処理したい．
접시는 좌에서 우로, 이벤트 한번만 주어짐
イベントは全部で 3 種類あり，⼊⼒される eventType によって分岐する．
세가지 유형 이벤트 이벤트 타입에 따라 분기

■ イベント①︓鮮度の低い⽫の除去
이벤트 1 신선도 낮은 접시 제거
まず，全⽫の鮮度を⼀律に D 減少させる（freshness -= D）。
모든 요리 신선도 D로 균등 감소
その後，鮮度 ≤ 0 の⽫をすべてレーンから取り除く。
그 후 신선도 0이하인 수 레인에서 제거
最後に，残った⽫の寿司の種類を左から順に出⼒する。
그 후 남은 접시를 좌>우로 스시 종류 출력
出⼒形式︓
출력 형식
Updated Lane: 寿司1 寿司2 ...
업데이트 레인: 1 2

■ イベント②︓区間 [L, R] の再並び替え
섹션 재정렬 [L, R]

区間 [L, R]（0-indexed）の⽫のみ、⼈気度が⾼い順に並び替える。
[L, R](0-인덱스) 섹션의 번호판만 인기 순서대로 정렬
区間外の順序は変えてはならない。
섹션 밖의 순서는 변경해서는 안 됩니다
⼈気度が同じ場合の順序は指定しない。
인기가 같은 순서는 미정의
出⼒形式︓
출력 형식
Sorted Lane: 寿司1 寿司2 ...

■ イベント③︓⼈気度の⾼い⽫の抽出（⾼級ネタ連続列）
 인기 있는 플레이트 추출(고급 재료가 연속적으로 줄지어짐)
レーン上で⼈気度 ≥ P の⽫だけを抽出し、それらが形成する 連続区間ごとに 1 グループとして保存する。
레인에서 ≥ P의 인기도를 가진 접시만 추출하여 각 연속 구간별로 한 그룹으로 저장
グループは左から 1,2,3,... と ID が付く。
그룹은 왼쪽에서 1, 2, 3,... 아이디
出⼒形式︓
출력 형식
Saved Group ID X: 寿司1 寿司2 ...
⼈気度 ≥ P の⽫が 0 件の場合，出⼒は何も⾏わない。
≥ P의 인기 요리가 0이면 아무런 결과도 나오지 않음

■ ⼊⼒形式
N
type_1 freshness_1 popularity_1
type_2 freshness_2 popularity_2
...
type_N freshness_N popularity_N
eventType
（イベント1の場合） D
（イベント2の場合） L R
（イベント3の場合） P
■ 出⼒形式
イベント①︓Updated Lane: ...
イベント②︓Sorted Lane: ...
イベント③︓Saved Group ID X: ...（複数⾏の可能性あり）
■ サンプルケース
● サンプル1（イベント①）
⼊⼒
10
tai 10 7
ebi 8 6
anago 6 3
maguro 4 9
salmon 2 8
hamachi 1 5
kappa 5 1
squid 9 4
egg 8 2
uni 3 7
1
4
出⼒
problem.md 2025-12-06
3 / 3
Updated Lane: tai ebi anago kappa squid egg
● サンプル2（イベント②）
⼊⼒
5
ebi 5 8
salmon 9 7
salmon 8 4
ebi 4 6
maguro 7 10
2
1 3
出⼒
Sorted Lane: ebi salmon ebi salmon maguro
● サンプル3（イベント③）
⼊⼒
7
maguro 5 4
otoro 8 9
ebi 7 8
kappa 4 2
uni 3 9
uni 4 9
squid 8 3
3
8
出⼒
Saved Group ID 1: otoro ebi
Saved Group ID 2: uni uni
 */
//------------------------------------------
// 寿司データ構造
//------------------------------------------
struct Sushi {
    string type;        // 種類
    int freshness = -1; // 鮮度
    int popularity = -1; // 人気度
};


//------------------------------------------
// 出力ヘルパー関数
//------------------------------------------
void printLane(const vector<Sushi>& sushis, const string& prefix = "") {
    if (!prefix.empty()) {
        cout << prefix;
    }
    for (size_t i = 0; i < sushis.size(); ++i) {
        cout << sushis[i].type;
        if (i < sushis.size() - 1) {
            cout << " ";
        }
    }
    cout << endl;
}


bool cmp(Sushi a, Sushi b) {
    return a.popularity >= b.popularity;
}


int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);

    int N;
    cin >> N;

    // レーン上の寿司
    vector<Sushi> lane(N);

    for (int i = 0; i < N; i++) {
        cin >> lane[i].type >> lane[i].freshness >> lane[i].popularity;
    }

    // 抽出済みおすすめ皿
    vector<vector<Sushi>> saved;

    int eventType;
    cin >> eventType;

    //------------------------------------------
    // イベント1：鮮度の低い皿の除去
    //------------------------------------------
    if (eventType == 1) {

        int decreaseAmount;
        cin >> decreaseAmount;

        /* 回答記入箇所① */
        vector<Sushi> _new;
        for (auto each : lane)
        {
            if (each.freshness - decreaseAmount > 0) {
                _new.push_back(each);
            }
        }
        lane = _new;

        // 廃棄後の寿司レーンの状態
        printLane(lane, "Updated Lane: ");
    }

    //------------------------------------------
    // イベント2：区間 [L, R] の再並び替え
    //------------------------------------------
    else if (eventType == 2) {

        int L, R;
        cin >> L >> R;
        
        /* 回答記入箇所② */
        vector<Sushi> _new;
        vector<Sushi> _cached;
        bool is_range_started = false;
        sort(lane.begin() + L, lane.begin() + R + 1, cmp);

        // ソート後の寿司レーンの状態
        printLane(lane, "Sorted Lane: ");
    }

    //------------------------------------------
    // イベント3：人気度 >= P の皿を連続区間ごとに抽出
    //------------------------------------------
    else if (eventType == 3) {

        int P;
        cin >> P;

        int i = 0;
        bool cache_generated = false;
        while (i < (int)lane.size()) {

            /* 回答記入箇所③ */
            auto each = lane[i];
            if (each.popularity < P) {
                // if (!cache_generated) continue;
                if (cache_generated) {
                    cout << "Saved Group ID " << saved.size() << ": ";
                    printLane(saved.back());
                }
                cache_generated = false;
                i++;
                continue;
            }
            if (!cache_generated) {
                vector<Sushi> cache;
                saved.push_back(cache);
                cache_generated = true;
            }
            saved[saved.size() - 1].push_back(each);
            

            // 抽出された保存グループ
            // ここでは saved に push_back された直近のグループを出力する想定
            // cout << "Saved Group ID " << saved.size() << ": ";
            // printLane(saved.back());
            /**
             * 추출된 저장 그룹
                이 경우 가장 최근에 저장된 그룹을 출력한다고 가정push_back
                
             */
            i++;
        }
        if (cache_generated) {
            cout << "Saved Group ID " << saved.size() << ": ";
            printLane(saved.back());
        }
    }

    return 0;
}
