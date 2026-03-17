/**
 * problem.md 2026-02-01
1 / 4


1 / 4
문제 1: 역에서 줄 서기

홈 대기 줄에
보통 여기 줄지어 있어.
탑승은 가장 먼저 줄 선 사람부터 진행됩니다.
전승 차장(임시 차선)
이동 k가 발생하면, 집 대기 줄 끝에서 최대 k명을 제거하고 이동 줄에 추가하세요.
네, 그래요.
제거된 사람들은 집 대기 순서대로 추가됩니다.
예시: 홈 큐가 [메이, 켄, 유이]이고 k = 2라면, 전송 라인에 추가되는 순서는 켄입니다
→ 유이.
환승 줄에서 탑승할 때는 끝에 추가된 사람이 순서대로 탑승해야 합니다.
전이는 한 번 이상 발생할 수 있습니다. 전송 라인의 내용물이 사라지지 않고, 추가 인원들이 그 위에 쌓여 있습니다.
행사
행사에는 네 가지 유형이 있습니다:
이름 입력
이름은 매표문을 통과해 승강장 대기 줄 끝에 줄을 서게 됩니다.
전송 K
승강장 대기 줄에서 환승 줄까지 10명으로 이동하세요.
대기 인원이 k보다 적으면 현장에 있는 모든 사람을 이동시키세요.
이동할 사람들 그룹은 "마지막 쪽에서 가장 많은 인원"이지만, 이동 라인에 추가될 때는 원래 순서가 유지됩니다.
이사회
한 명은 더 이상 배에 있지 않습니다. 라이더들의 우선순위는 다음과 같습니다.
1. 환승선에 사람이 있으면 마지막으로 이동한 사람이 기차에 탑승합니다.
problem.md 2026-02-01
2 / 4
2. 그렇지 않으면 플랫폼 대기 줄 맨 앞에 있는 사람이 탑승합니다.
3. 둘 다 비어 있으면 아무것도 하지 마세요.
누구
"다음에 탈 사람"을 출력하세요.
이동 라인에 사람이 있으면 마지막으로 이동한 사람의 이름이 출력됩니다.
그렇지 않으면 집 대기 줄 맨 위 이름을 출력하세요.
둘 다 비어 있으면 EMPTY를 출력합니다.
입력
첫 번째 행에는 정수 N(사건 수)이 주어집니다.
다음 N행은 한 번에 하나의 이벤트로 주어집니다.
1 <= N <= 200000
이름은 1에서 20까지의 문자열로, 대문자, 소문자, 숫자만으로 구성되어 있습니다.
TRANSFER k의 k는 0입니다 < = k < = 200000입니다.
출력
각 WHO 이벤트마다 지정된 문자열의 한 줄을 출력합니다.
샘플
입력 예시 1
9
메이 입장
켄 등장
유이 등장
이송 2
누구
이사회
누구
이사회
누구
예제 출력 1
유이
켄
메이
problem.md 2026-02-01 3 / 4 입력 예시 2
10
누구
아키 등장
누구
트랜스퍼 5
누구
이사회
누구
이사회
누구
누구
나가세요
힘
예시
2
비어 있어
아키
아키
비어 있어
비어 있어
비어 있어
들어오세요
힘
예시
3
15
하나 등장
타로 등장
소라 등장
전송 0
누구
이적 1
누구
이사회
누구
이송 2
누구
이사회
누구
이사회
누구
나가세요
힘
예시
3
problem.md 2026-02-01
4 / 4
하나는
소라
하나는
타로
하나는
비어 있어
입력 예시 4
12
A 인사
B 진입
C 등장
이송 3
이사회
D 등장
누구
이송 2
누구
이사회
누구
누구
출력 예제 4
B
D
A
A


問題1: 駅の待機列
駅には次の 2 つの待機場所がある。
역에 두 곳의 대기 장소가 있음

ホーム待機列︓先に並んだ⼈から順に乗⾞する。
홈승차줄 : 줄을 서서 가장 먼저 차례로 승차

乗り換え導線（臨時レーン）︓TRANSFER k が発⽣すると，ホーム待機列の最後尾から最⼤ k ⼈を取
り除き，その⼈たちを待機列にいたときの並び順のまま乗り換え導線に追加する
노리카에 : transfer k 발생 시 홈의 대기열의 최후미에서부터 최대 k인 가져오기
그 사람들을 대기열에서 제거하고 순서대로 트랜스퍼에 추가

乗り換え導線からの乗⾞は最後に追加された⼈から順（後⼊れ先出し）で⾏う。

그들을 제거하고 대기 줄에 있던 순서대로 이관 줄에 추가
전차 탑승은 마지막으로 추가된 사람 순서대로 진행됩 후입선출

イベント列を上から順に処理し，WHO が現れるたびに 「次に乗⾞する⼈」 を出⼒せよ。
이벤트 열을 위에서 순서대로 처리, WHO가 나올 때마다 다음출력

ルール
ホーム待機列
通常はここに並ぶ。
乗⾞は 先頭（最も早く並んだ⼈） から⾏われる。
乗り換え導線（臨時レーン）
TRANSFER k が発⽣すると，ホーム待機列の最後尾から最⼤ k ⼈を取り除き，乗り換え導線へ追加す
る。
取り除かれた⼈たちは，ホーム待機列にいたときの並び順を保ったまま追加される。
例︓ホーム待機列が [Mei, Ken, Yui] で k = 2 のとき，乗り換え導線へ追加される順は Ken
→ Yui。
乗り換え導線から乗⾞するときは，最後に追加された⼈から順に乗⾞する。
TRANSFER は複数回発⽣し得る。乗り換え導線の内容は消えず，追加された⼈が上に積み重なる。
イベント
イベントは次の 4 種類である。
ENTER name
name が改札を通り，ホーム待機列の最後尾に並ぶ。
TRANSFER k
ホーム待機列の最後尾から最⼤ k ⼈を，乗り換え導線へ移す。
待機列の⼈数が k 未満なら，いる全員を移す。
移す⼈の集合は「最後尾側の最⼤ k ⼈」だが，乗り換え導線へ追加するときは元の並び順を保つ。
BOARD
1 ⼈が乗⾞していなくなる。乗⾞する⼈の優先順位は次の通り。
1. 乗り換え導線に⼈がいれば，その中で 最後に移された⼈ が乗⾞する。
problem.md 2026-02-01
2 / 4
2. そうでなければ，ホーム待機列の 先頭 の⼈が乗⾞する。
3. どちらも空なら何もしない。
WHO
「次に乗⾞する⼈」を出⼒する。
乗り換え導線に⼈がいれば，その中で最後に移された⼈の名前を出⼒する。
そうでなければ，ホーム待機列の先頭の名前を出⼒する。
どちらも空なら EMPTY を出⼒する。
⼊⼒
1 ⾏⽬に整数 N（イベント数）が与えられる。
続く N ⾏にイベントが 1 つずつ与えられる。
1 <= N <= 200000
name は英⼤⽂字・英⼩⽂字・数字のみからなる⻑さ 1 以上 20 以下の⽂字列
TRANSFER k の k は 0 <= k <= 200000
出⼒
各 WHO イベントごとに，指定の⽂字列を 1 ⾏出⼒せよ。
サンプル
⼊⼒例 1
9
ENTER Mei
ENTER Ken
ENTER Yui
TRANSFER 2
WHO
BOARD
WHO
BOARD
WHO
出⼒例 1
Yui
Ken
Mei
problem.md 2026-02-01 3 / 4 ⼊⼒例 2
10
WHO
ENTER Aki
WHO
TRANSFER 5
WHO
BOARD
WHO
BOARD
WHO
WHO
出
⼒
例
2
EMPTY
Aki
Aki
EMPTY
EMPTY
EMPTY
⼊
⼒
例
3
15
ENTER Hana
ENTER Taro
ENTER Sora
TRANSFER 0
WHO
TRANSFER 1
WHO
BOARD
WHO
TRANSFER 2
WHO
BOARD
WHO
BOARD
WHO
出
⼒
例
3
problem.md 2026-02-01
4 / 4
Hana
Sora
Hana
Taro
Hana
EMPTY
⼊⼒例 4
12
ENTER A
ENTER B
ENTER C
TRANSFER 3
BOARD
ENTER D
WHO
TRANSFER 2
WHO
BOARD
WHO
WHO
出⼒例 4
B
D
A
A

A B C //
      // A B C
      // A B
D     // A B
      // A B D
 */

#include <iostream>
#include <string>
#include <stack>   // スタックを利用すること
#include <queue>   // キューを利用すること
#include <deque>

using namespace std;

int main() {
    int N;
    cin >> N;

    // キューを定義 entryQ;
    // スタックを定義 transferSt;
    // 必要に応じて適宜定義
    deque<string> home;
    stack<string> trns;
    stack<string> moving;

    for (int i = 0; i < N; i++) {
        string cmd;
        cin >> cmd;

        if (cmd == "ENTER") {
            string name;
            cin >> name;
            home.push_back(name);
            // cout << trns.size() << ' ' << home.size() << endl;
        }
        else if (cmd == "TRANSFER") {
            int n;
            cin >> n;
            while (n--) {
                if (!home.empty()) {
                    moving.push(home.back());
                    home.pop_back();
                }
            }
            while (!moving.empty()) {
                trns.push(moving.top());
                moving.pop();
                // cout << trns.size() << ' ' << home.size() << endl;
            }
        }
        else if (cmd == "BOARD") {
            if (!trns.empty()) {
                trns.pop();
                // cout << trns.size() << ' ' << home.size() << endl;
                continue;
            }
            if (!home.empty()) {
                home.pop_front();
                // cout << trns.size() << ' ' << home.size() << endl;
                continue;
            }
        }
        else if (cmd == "WHO") {
            if (!trns.empty()) {
                cout << trns.top() << endl;
                // cout << trns.size() << ' ' << home.size() << endl;
                continue;
            }
            if (!home.empty()) {
                // cout << home.top() << endl;
                cout << home.front() << endl;
                // cout << trns.size() << ' ' << home.size() << endl;
                continue;
            }
            cout << "EMPTY" << endl;
        }
    }
    return 0;
}
