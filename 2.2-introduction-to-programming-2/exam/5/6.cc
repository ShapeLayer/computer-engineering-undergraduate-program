/**
 *problem.md 2026-02-01
1 / 6
問題6 ホテル客室割り当てその２（救済あり）

問6は，問5で作成した「ホテルの客室割り当てシミュレーション」に対して，次の2点だけ仕様を追加・変
更する．
문제6은 5에 다음 두 가지 항목의 사양을 추가하고 변경

1. 新規客を受け⼊れられない場合に限り，「予約グレード確保（救済）」を試す
1. 신규 고객을 받을 수 없을 때만 "예약 등급 확보(구제)" 시도

2. その夜に「予約グレード確保（救済）」が1回でも成功した場合，その夜はアップグレードを⼀切⾏わ
ない
2. 그날 밤 단 한 번이라도 "예약 등급(구제)" 확보에 성공하면 그날 밤 업그레이드가 가능

以下，問5と同⼀の部分（部屋構成，⼊⼒形式，会員ルール，通常割り当て，アップグレード優先順位，出⼒形式など）
の説明は省略し，問6で追加・変更される仕様のみを記す．
이하는 문5와 동일한 부분(방배정 입력 형식 회원룰 등)의 설명은 생략
문6에 추가 변경부분만 작성


⽤語
용어
部屋移動
헤야이동

夜 の処理中に，すでに部屋が割り当てられている宿泊中の客を，別の部屋番号へ割り当て直すこと．
밤 처리 중에 이미 방이 배정된 손님을 다른 방 번호로 배정할것
このとき客をホテルから退去させてはならない（宿泊を継続させたまま部屋だけ移す）．
이 순간에 고객을 호텔에서 퇴출시켜서는 안됨 (객실만 이동)

アップグレード状態の客
업그레이드된 고객
その夜において，現在割り当てられているグレードが予約グレードより上位である客．
すなわち currentGrade > reserveGrade を満たす客．
현재 할당된 등급이 그날 밤 예약 등급보다 높은 고객들

予約グレード確保（救済）
예약 그룹 보호 (교정)
新規客が通常割り当てでは受け⼊れ不可となった場合に限り，その新規客の「予約グレード（PまたはE）」
に対して， 宿泊中の客の部屋移動により空室を1室作り，受け⼊れを再試⾏する追加処理を指す．
予約グレードがBの新規客には救済は⾏わない．
신규 고객이 일반 배정에 부적합한 경우 신규 고객의 예약 등급이 예약 등급에 대해
숙박중인 객의 방을 이동해서 1실을 만들어 우케츠케를 재시행할 추가 처리를 의미
예약 등급 B에 대해서는 구제 제공 x

問6で変更される夜ごとの処理
문6에서 변경할 범의 처리
A. 新規客の受け⼊れ判定（Step2）の追加
A. 신규 고객 추가 (두 단계)
問5の通常割り当てで受け⼊れ不可となった新規客について，次を追加で⾏う．
문5에서 일반 등급에서 들어가지 못한 신규겍에 대해 다음과 같이 추가
新規客の予約グレードがB︓救済は⾏わず，受け⼊れ不可のまま
신규객의 예약등급이 B인경우 구제는 제공되지 않음, 불가능
新規客の予約グレードがPまたはE︓その予約グレードに空室を1室作る「救済」を試す
신규객의 예약등급이 P E인 경우 해당 예약 등급에 공실을 만들어 구제를 시도
救済に成功したら，通常割り当て（E→P→Bの順で空室探索）を最初からやり直す
구제에 성공했다면 통상 배정을 다시 시행
やり直した結果で割り当てできれば受け⼊れ成⽴
재작업 결과로 방을 할당할 수 있다면 그대로 시행
救済に失敗したら受け⼊れ不可のまま
구제에 실패한다면 여전히 불가한 그대로

その夜のどこかで救済が1回でも成功した場合，フラグ rescueHappened を true とする．
구제에 성공한 플래그 참으로 변경




B. アップグレード（Step3）の変更
B. 업그레이드 3단계 변화
rescueHappened=false︓問5と同じアップグレード処理を⾏う
문5의 처리와 동일하게
rescueHappened=true︓その夜はアップグレード処理を⼀切⾏わない
그날 밤 업그레이드 처리는 수행하지 않음

救済（予約グレード確保）の具体仕様
구제(예약 등급 확보)
(1) 予約グレードPの新規客に対する救済（Pに空室を1室作る）
(1) 예약 등급P의 신규 고객 구제
⽬的︓Pグレード（201,202,203）のうち1室を空室にすること．
목표: P등급 방 비우기
1. Bグレードに空室が1室も無い場合，救済は必ず失敗
1. B 등급에 한 개의 공석도 없으면 구제는 항상 실패

2. 現在Pに割り当てられている宿泊中の客 を候補として探索する（候補は次の全条件を満たす）
2. 현재 P에 지정된 후보지 중 객을 검색 (후보자는 아래의 모든 기준을 충족함)
はアップグレード状態（currentGrade(u) > reserveGrade(u)）
는 업그레이드 状態?? 
の予約グレードはB（B予約なのにPにいる客のみ）
의 예약 그레이드는 B (B예인데 P인 객에 대해서)
は新規客 new より強い客ではない（status(u) < status(new) は候補にしてはいけない）
는 신규 고객 new보다 강한 객이 아님 (~~~ 조건이어선 안됨)

3. 候補が0⼈なら救済失敗
3. 후보가 0이면 실패

4. 候補が複数なら「押し出し優先順位」が最も⾼い客を1⼈選ぶ
5. 후보가 여럿인 경우 가장 높은 우선순위 한명 선택

5. 選ばれた客 を，Bグレードの空室のうち部屋番号が最⼩の部屋（101→102→103→104→105）へ移動
5. 선택한 객을 B급 객실에서 오름차순에서 찾아지는 곳으로 옮김

6. 移動できたら救済成功（Pに空室が1室できたとみなす）
6. 이동 가능 시 구조 성공

(2) 予約グレードEの新規客に対する救済（Eに空室を1室作る）
(2) E 등급 공석 하나 만들기
⽬的︓Eグレード（301,302）のうち1室を空室にすること．
목적: E등급 1개 방(301,302) 비우기

1. 現在Eに割り当てられている宿泊中の客 を候補として探索する（候補は次の全条件を満たす）
1. 현재 E에 배정된 잠재 게스트를 검색 (후보자는 다음 모든 기준을 충족함):

はアップグレード状態（currentGrade(u) > reserveGrade(u)）
업그레이드 状態... 또나옴 이거 뭐였드라

の予約グレードはEではない（E予約でE滞在はアップグレードではないので候補外）
예약 등급이 E가 아닌 경우(E 등급은 E 예약으로 업그레이드가 아니기 때문에 후보가 아님)

は新規客 new より強い客ではない（status(u) < status(new) は候補にしてはいけない）
는 신규객 new보다 강하지 않은 객이 아님(~~조건의 후보가 되지 ㅇ낳음)

2. 候補が0⼈なら救済失敗
후보가 0명이면 구조가 실패

3. 候補が複数なら「押し出し優先順位」が⾼い順に，1⼈ずつ救済を試す
3. 후보가 여러 명일 경우 "밀기 우선순위" 순서대로 하나씩

4. 候補 がPに宿泊可能でなければ（CanUseGrade(u,P) が false）次候補へ
4. 후보자가 P에 대출할 수 없으면(CanUseGrade(u,P) 거짓), 다음 후보로 이동

5. Pに空室があるなら， をPの空室のうち最⼩番号（201→202→203）へ移動し救済成功
5. P에 공석이 있으면 P의 공석 중 가장 낮은 수(201→202→203)로 옮기면 구조가 성공

6. Pが満室なら，まず(1)の「Pに空室を1室作る救済」を1回だけ試す
6. P가 가득찼다면 P공석 1실 만들기 구제 실행

失敗︓この では救済できないので次候補へ
실패: 다음 후보로 계속
成功︓Pに空室ができたはずなので， をそのP空室（最⼩番号）へ移動し救済成功
성공: P에 공석 필요. 공석이 있다면 구조 성공

7. すべての候補で救済できなければ救済失敗
7. 전부 해내지 못하면 구조 실패

押し出し優先順位（救済で先に動かす客の選び⽅）
우선순위 밀기 (먼저 이동시키는 객 선택 방법)

候補が複数いる場合，次のキーを上から順に⽐較し，先に差が付いた項⽬で順位を決める（「優先」とは
후보가 여러인 경우 키를 위에서부터 순서대로 비교, 차이가 먼 항목에 따라 순서 결정
「先に移動させる」こと）．
(우선순위는 앞으로 나아갈것 << ??)

1. 予約グレードが低い⽅が優先（B → P → E）
1. 예약 등급은 낮은 사람 우선

2. 残り宿泊数（当夜を含む）が少ない⽅が優先
2. 남은 밤이 적은 편 선호
残り宿泊数 = checkout - t + 1

3. 登録年が⼤きい⽅が優先（新しいほど優先）
3. 등록 연도 오래될수록 선호

4. 会員IDが⼤きい⽅が優先
4. 회원ID가 클수록 선호

5. 全体⼊⼒順が⼤きい⽅が優先（後に⼊⼒された⽅が優先）
5. 입력 순서가 빠를수록 선호

u
u
u
u
u
u
u
u
u
u
u
u
u
problem.md 2026-02-01
3 / 6
⼊⼒
⼊⼒は5⽇分で構成される．⽇ について，最初にその⽇に到着する新規客数 が与えられ， 続い
て ⾏の情報が与えられる．
各⾏は次の形式である．
id reserve nights
id は9桁の会員ID（先頭4桁が登録年，5桁⽬が会員ステータス）
reserve は予約グレード（B / P / E）
nights は宿泊数（正の整数）
出⼒
夜 （Dは最⼤のチェックアウト⽇）について，次の形式で出⼒する．
1⾏⽬︓night:t
2⾏⽬︓E⾏（301,302，残り3列は -）
3⾏⽬︓P⾏（201,202,203，残り2列は -）
4⾏⽬︓B⾏（101..105）
その後に空⾏を1⾏出⼒する
空室は 0 として出⼒する．
実装課題
配布される初期コードのうち，次の3関数を完成させ，仕様通りに動作するようにせよ．
RollbackMoves
MakeVacancyE
MakeVacancyP
サンプル
⼊⼒例1
4
201630001 B 3
201940004 B 3
201940002 P 3
201840003 P 3
1
201620005 P 1
0
0
0
d = 1..5 nd
nd
t = 1..D
problem.md 2026-02-01
4 / 6
出⼒例1
night:1
0,0,-,-,-
201630001,201940002,201840003,-,-
201940004,0,0,0,0
night:2
0,0,-,-,-
201620005,201940002,201840003,-,-
201940004,201630001,0,0,0
night:3
0,0,-,-,-
201630001,201940002,201840003,-,-
201940004,0,0,0,0
⼊⼒例2
5
201910001 P 3
201940002 P 3
201940003 E 3
201620006 B 3
201720007 B 3
1
201910008 E 1
0
0
0
出⼒例2
night:1
201910001,201940003,-,-,-
201620006,201720007,201940002,-,-
0,0,0,0,0
night:2
201910008,201940003,-,-,-
201620006,201910001,201940002,-,-
201720007,0,0,0,0
night:3
201910001,201940003,-,-,-
201620006,201720007,201940002,-,-
0,0,0,0,0
problem.md 2026-02-01
5 / 6
⼊⼒例3
3
201940001 P 2
201940002 P 2
201940003 P 2
1
201620004 P 1
0
0
0
出⼒例3
night:1
0,0,-,-,-
201940001,201940002,201940003,-,-
0,0,0,0,0
night:2
0,0,-,-,-
201940001,201940002,201940003,-,-
0,0,0,0,0
⼊⼒例4
5
201900001 E 2
201900002 E 2
201910003 P 5
201940004 P 5
201620005 B 5
1
201940006 B 1
1
201620007 P 1
1
201940008 B 1
1
201940009 B 1
出⼒例4
problem.md 2026-02-01
6 / 6
night:1
201900001,201900002,-,-,-
201910003,201620005,201940004,-,-
0,0,0,0,0
night:2
201900001,201900002,-,-,-
201910003,201620005,201940004,-,-
201940006,0,0,0,0
night:3
0,0,-,-,-
201910003,201620007,201940004,-,-
201620005,0,0,0,0
night:4
201910003,0,-,-,-
201620005,0,201940004,-,-
0,201940008,0,0,0
night:5
201910003,0,-,-,-
201620005,0,201940004,-,-
201940009,0,0,0,0
 */

/**
 * 우아 진짜 길다
 * 이거 뭐에요.........
 */

#include <iostream>
#include <string>
using namespace std;

#define GRADE_B 0
#define GRADE_P 1
#define GRADE_E 2
#define ROOM_COUNT 10

// occ[] 의 배열 (출력 순서)
/*
  occ[] の並び（出力順）：
  0:301 1:302
  2:201 3:202 4:203
  5:101 6:102 7:103 8:104 9:105
*/
const int GRADE_START[3] = { 5, 2, 0 }; // B,P,E
const int GRADE_LEN[3]   = { 5, 3, 2 }; // B,P,E

struct Guest {
    string id;
    int year;
    int status;        // 0..4（小さいほど強い）
    int reserveGrade;  // B=0,P=1,E=2
    int checkin;       // 1..5
    int nights;
    int checkout;      // 最終宿泊夜
    int inputIdx;      // 全体入力順
};

struct MoveLog {
    int _guest_idx;
    int fromRoomIdx;
    int toRoomIdx;
    int fromGrade;
    int toGrade;
};

Guest* gGuests = NULL;

int GradeFromRoomIndex(int roomIdx) {
    if (roomIdx < 2) return GRADE_E;
    if (roomIdx < 5) return GRADE_P;
    return GRADE_B;
}

int GradeFromReserveChar(char c) {
    if (c == 'B') return GRADE_B;
    if (c == 'P') return GRADE_P;
    return GRADE_E;
}

int ParseYear(const string& id) {
    int y = 0;
    for (int i = 0; i < 4; i++) y = y * 10 + (id[i] - '0');
    return y;
}

int ParseStatus(const string& id) {
    return id[4] - '0';
}

// 9桁固定なので辞書順が数値順と一致
bool IdLess(const string& a, const string& b) { return a < b; }
bool IdGreater(const string& a, const string& b) { return a > b; }

/* 会員ルール込み：その客が grade に泊まれるか（予約未満禁止＋会員別アップグレード可否） */
bool CanUseGrade(const Guest& g, int grade) {
    if (grade < g.reserveGrade) return false;

    // プラチナ・ゴールド：予約以上ならOK
    if (g.status == 0) return true;
    if (g.status == 1) return true;

    // シルバー
    if (g.status == 2) {
        if (g.reserveGrade == GRADE_B) {
            if (grade == GRADE_B) return true;
            if (grade == GRADE_P) return true;
            return false;
        }
        if (g.reserveGrade == GRADE_P) return (grade == GRADE_P);
        return (grade == GRADE_E);
    }

    // ブロンズ（予約Bのみ年条件でP可）
    if (g.status == 3) {
        if (g.reserveGrade == GRADE_B) {
            if (g.year <= 2017) {
                if (grade == GRADE_B) return true;
                if (grade == GRADE_P) return true;
                return false;
            } else {
                return (grade == GRADE_B);
            }
        }
        if (g.reserveGrade == GRADE_P) return (grade == GRADE_P);
        return (grade == GRADE_E);
    }

    // ノーマル：アップグレードなし（予約グレードのみ）
    return (grade == g.reserveGrade);
}

/* 好みグレード（高い順）を作る．ただし rescue は使わない通常割当用 */
void BuildPrefGradesDesc(const Guest& g, int pref[3], int& cnt) {
    cnt = 0;
    for (int grade = GRADE_E; grade >= GRADE_B; grade--) {
        if (CanUseGrade(g, grade)) {
            pref[cnt] = grade;
            cnt++;
        }
    }
}

int FindFreeRoomIndex(int occ[ROOM_COUNT], int grade) {
    int start = GRADE_START[grade];
    int len = GRADE_LEN[grade];
    for (int i = 0; i < len; i++) {
        int idx = start + i;
        if (occ[idx] == -1) return idx;
    }
    return -1;
}

void PlaceGuest(int occ[ROOM_COUNT], int roomIdxOf[], int gradeOf[], int _guest_idx, int roomIdx) {
    occ[roomIdx] = _guest_idx;
    roomIdxOf[_guest_idx] = roomIdx;
    gradeOf[_guest_idx] = GradeFromRoomIndex(roomIdx);
}

void ApplyMove(int occ[ROOM_COUNT], int roomIdxOf[], int gradeOf[],
    int _guest_idx, int toRoomIdx, MoveLog& log) {
    int fromRoomIdx = roomIdxOf[_guest_idx];
    int fromGrade = gradeOf[_guest_idx];
    int toGrade = GradeFromRoomIndex(toRoomIdx);

    log._guest_idx = _guest_idx;
    log.fromRoomIdx = fromRoomIdx;
    log.toRoomIdx = toRoomIdx;
    log.fromGrade = fromGrade;
    log.toGrade = toGrade;

    occ[fromRoomIdx] = -1;
    occ[toRoomIdx] = _guest_idx;

    roomIdxOf[_guest_idx] = toRoomIdx;
    gradeOf[_guest_idx] = toGrade;
}

/*** 問6追加箇所 ***/

bool PushCandidateEarlier(int a, int b, int nightT);
void BubbleSortCandidates(int cand[], int n, int nightT);
bool MakeVacancyP(int occ[ROOM_COUNT], int roomIdxOf[], int gradeOf[],
    int newIdx, int nightT, MoveLog logs[], int& logCount);
bool BetterForUpgrade(int a, int b, int nightT);

void RollbackMoves(int occ[ROOM_COUNT], int roomIdxOf[], int gradeOf[],
    MoveLog logs[], int logCount) {
    for (int i = logCount - 1; i >= 0; i--) {
        MoveLog& log = logs[i];
        occ[log.toRoomIdx] = -1;
        occ[log.fromRoomIdx] = log._guest_idx;
        roomIdxOf[log._guest_idx] = log.fromRoomIdx;
        gradeOf[log._guest_idx] = log.fromGrade;
    }
}

/* Eに空きを作る：Eにいるアップグレード客をPへ．P満室ならPを空けてから */
bool MakeVacancyE(int occ[ROOM_COUNT], int roomIdxOf[], int gradeOf[],
    int newIdx, int nightT, MoveLog logs[], int& logCount) {

    logCount = 0;

    // 1. E에 있는 업그레이드 객 찾기
    int _candidates[ROOM_COUNT];
    int _cand_cnt = 0;
    
    for (int i = 0; i < ROOM_COUNT; i++) {
        int _guest_idx = occ[i];
        if (_guest_idx == -1) continue;   // 공석

        int grade = GradeFromRoomIndex(i);

        if (grade <= gGuests[_guest_idx].reserveGrade) continue; // 업그레이드 아님
        if (gGuests[_guest_idx].reserveGrade == GRADE_E) continue; // E예약 E숙박은 업그레이드 아님
        if (BetterForUpgrade(_guest_idx, newIdx, nightT)) continue; // 신규객보다 강함
        
        _candidates[_cand_cnt] = _guest_idx;
        _cand_cnt++;
    }

    // 실패시 P > B 쪽에서 시도했을 때 나타나는지 확인 필요
    if (_cand_cnt == 0) return false;

    BubbleSortCandidates(_candidates, _cand_cnt, nightT);
    for (int i = 0; i < _cand_cnt; i++) {
        int u = _candidates[i];

        int _free = FindFreeRoomIndex(occ, GRADE_P);
        if (_free != -1) {
            ApplyMove(occ, roomIdxOf, gradeOf, u, _free, logs[logCount]);
            logCount++;
            return true;
        }

        // P가 만실인 경우 P에 공석 만들기 시도
        MoveLog pLogs[ROOM_COUNT];
        int pLogCount = 0;
        bool ok = MakeVacancyP(occ, roomIdxOf, gradeOf, newIdx, nightT, pLogs, pLogCount);
        if (ok) {
            // P에 공석 만들기 성공 시도
            _free = FindFreeRoomIndex(occ, GRADE_P);
            if (_free != -1) {
                // P에 공석 있음
                // 이동 적용
                for (int j = 0; j < pLogCount; j++) {
                    logs[logCount] = pLogs[j];
                    logCount++;
                }
                ApplyMove(occ, roomIdxOf, gradeOf, u, _free, logs[logCount]);
                logCount++;
                return true;
            } else {
                // P에 공석 없음 (이동 롤백)
                RollbackMoves(occ, roomIdxOf, gradeOf, pLogs, pLogCount);
            }
        }
    }
    
    return false;
}

/* Pに空きを作る：Pにいるアップグレード客（reserve=B）をBへ落とす */
bool MakeVacancyP(int occ[ROOM_COUNT], int roomIdxOf[], int gradeOf[],
    int newIdx, int nightT, MoveLog logs[], int& logCount) {

    logCount = 0;

    // 1. P에 있는 업그레이드 객 찾기
    int _candidates[ROOM_COUNT];
    int _cand_cnt = 0;

    for (int i = 0; i < ROOM_COUNT; i++) {
        int _guest_idx = occ[i];
        if (_guest_idx == -1) continue;   // 공석

        int grade = GradeFromRoomIndex(i);

        if (grade <= gGuests[_guest_idx].reserveGrade) continue; // 업그레이드 아님
        if (gGuests[_guest_idx].reserveGrade != GRADE_B) continue; // 예약 B인 사람만
        if (BetterForUpgrade(_guest_idx, newIdx, nightT)) continue; // 신규객보다 강함
        
        _candidates[_cand_cnt] = _guest_idx;
        _cand_cnt++;
    }

    if (_cand_cnt == 0) return false;

    BubbleSortCandidates(_candidates, _cand_cnt, nightT);
    
    for (int i = 0; i < _cand_cnt; i++) {
        int u = _candidates[i];

        int _free = FindFreeRoomIndex(occ, GRADE_B);
        if (_free != -1) {
            ApplyMove(occ, roomIdxOf, gradeOf, u, _free, logs[logCount]);
            logCount++;
            return true;
        }
    }

    return false;
}

/*** 問6追加箇所ここまで ***/

/* 7.4 更新版：押し出し候補の優先
   7.4 화신판: 눌러빼는~노우선
   予約低い(B->P->E), 残泊少ない, 登録年大きい, 会員番号大きい */
bool PushCandidateEarlier(int a, int b, int nightT) {
    if (gGuests[a].reserveGrade != gGuests[b].reserveGrade) {
        return gGuests[a].reserveGrade < gGuests[b].reserveGrade;
    }

    int remainA = gGuests[a].checkout - nightT + 1;
    int remainB = gGuests[b].checkout - nightT + 1;
    if (remainA != remainB) {
        return remainA < remainB;
    }

    if (gGuests[a].year != gGuests[b].year) {
        return gGuests[a].year > gGuests[b].year;
    }

    if (gGuests[a].id != gGuests[b].id) {
        return IdGreater(gGuests[a].id, gGuests[b].id);
    }

    return gGuests[a].inputIdx > gGuests[b].inputIdx;
}

void BubbleSortCandidates(int cand[], int n, int nightT) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j + 1 < n - i; j++) {
            if (!PushCandidateEarlier(cand[j], cand[j + 1], nightT)) {
                int tmp = cand[j];
                cand[j] = cand[j + 1];
                cand[j + 1] = tmp;
            }
        }
    }
}

// 신규객 들어옴
// 먼저 통사 배정을 우선 수행 (구제 없음)
// 무리라면 예약 그레이드의 구제 
/* 新規受入れ：まず通常割当（救済なし）．無理なら「予約グレードの救済」だけ試す． */
bool TryAcceptNew(int occ[ROOM_COUNT], int roomIdxOf[], int gradeOf[],
    int newIdx, int nightT, bool& rescueHappened) {
    int pref[3];
    int prefCount = 0;
    BuildPrefGradesDesc(gGuests[newIdx], pref, prefCount);

    for (int i = 0; i < prefCount; i++) {
        int g = pref[i];
        int freeRoom = FindFreeRoomIndex(occ, g);
        if (freeRoom != -1) {
            PlaceGuest(occ, roomIdxOf, gradeOf, newIdx, freeRoom);
            return true;
        }
    }

    int reserveG = gGuests[newIdx].reserveGrade;
    if (reserveG == GRADE_B) return false;

    MoveLog logs[2];
    int logCount = 0;
    bool ok = false;

    if (reserveG == GRADE_P) ok = MakeVacancyP(occ, roomIdxOf, gradeOf, newIdx, nightT, logs, logCount);
    if (reserveG == GRADE_E) ok = MakeVacancyE(occ, roomIdxOf, gradeOf, newIdx, nightT, logs, logCount);

    if (!ok) return false;

    for (int i = 0; i < prefCount; i++) {
        int g = pref[i];
        int freeRoom = FindFreeRoomIndex(occ, g);
        if (freeRoom != -1) {
            PlaceGuest(occ, roomIdxOf, gradeOf, newIdx, freeRoom);
            rescueHappened = true;
            return true;
        }
    }

    RollbackMoves(occ, roomIdxOf, gradeOf, logs, logCount);
    return false;
}

bool BetterForUpgrade(int a, int b, int nightT) {
    if (gGuests[a].status != gGuests[b].status) return gGuests[a].status < gGuests[b].status;

    int remainA = gGuests[a].checkout - nightT + 1;
    int remainB = gGuests[b].checkout - nightT + 1;
    if (remainA != remainB) return remainA < remainB;

    if (gGuests[a].year != gGuests[b].year) return gGuests[a].year < gGuests[b].year;

    if (gGuests[a].id != gGuests[b].id) return IdLess(gGuests[a].id, gGuests[b].id);

    return gGuests[a].inputIdx < gGuests[b].inputIdx;
}

void UpgradePass(int occ[ROOM_COUNT], int roomIdxOf[], int gradeOf[],
    int active[], int activeCount, int nightT) {
    while (true) {
        int freeE = FindFreeRoomIndex(occ, GRADE_E);
        if (freeE == -1) break;

        int best = -1;
        for (int i = 0; i < activeCount; i++) {
            int u = active[i];
            if (gradeOf[u] == -1) continue;

            if (gGuests[u].checkin > nightT) continue;
            if (gGuests[u].checkout < nightT) continue;

            if (gradeOf[u] == GRADE_E) continue;
            if (!CanUseGrade(gGuests[u], GRADE_E)) continue;

            if (best == -1) best = u;
            else if (BetterForUpgrade(u, best, nightT)) best = u;
        }

        if (best == -1) break;

        MoveLog dummy;
        ApplyMove(occ, roomIdxOf, gradeOf, best, freeE, dummy);
    }

    while (true) {
        int freeP = FindFreeRoomIndex(occ, GRADE_P);
        if (freeP == -1) break;

        int best = -1;
        for (int i = 0; i < activeCount; i++) {
            int u = active[i];
            if (gradeOf[u] == -1) continue;

            if (gGuests[u].checkin > nightT) continue;
            if (gGuests[u].checkout < nightT) continue;

            if (gradeOf[u] != GRADE_B) continue;
            if (!CanUseGrade(gGuests[u], GRADE_P)) continue;

            if (best == -1) best = u;
            else if (BetterForUpgrade(u, best, nightT)) best = u;
        }

        if (best == -1) break;

        MoveLog dummy;
        ApplyMove(occ, roomIdxOf, gradeOf, best, freeP, dummy);
    }
}

void PrintNight(int occ[ROOM_COUNT], int nightT) {
    cout << "night:" << nightT << endl;

    for (int c = 0; c < 5; c++) {
        if (c > 0) cout << ",";
        if (c < 2) {
            int u = occ[c];
            if (u == -1) cout << 0;
            else cout << gGuests[u].id;
        } else {
            cout << "-";
        }
    }
    cout << endl;

    for (int c = 0; c < 5; c++) {
        if (c > 0) cout << ",";
        if (c < 3) {
            int u = occ[2 + c];
            if (u == -1) cout << 0;
            else cout << gGuests[u].id;
        } else {
            cout << "-";
        }
    }
    cout << endl;

    for (int c = 0; c < 5; c++) {
        if (c > 0) cout << ",";
        int u = occ[5 + c];
        if (u == -1) cout << 0;
        else cout << gGuests[u].id;
    }
    cout << endl;

    cout << endl;
}

int main() {
    int dayCount[6];
    int* dayGuests[6];

    for (int d = 1; d <= 5; d++) {
        dayCount[d] = 0;
        dayGuests[d] = NULL;
    }

    Guest* guests = NULL;
    int guestCount = 0;
    int capacity = 0;

    int D = 0;
    int globalInputIdx = 0;

    for (int d = 1; d <= 5; d++) {
        int nd;
        cin >> nd;
        dayCount[d] = nd;
        dayGuests[d] = new int[nd];

        for (int j = 0; j < nd; j++) {
            string id;
            char reserveChar;
            int nights;
            cin >> id >> reserveChar >> nights;

            if (guestCount + 1 > capacity) {
                int newCap = capacity;
                if (newCap == 0) newCap = 64;
                while (newCap < guestCount + 1) newCap *= 2;

                Guest* newArr = new Guest[newCap];
                for (int k = 0; k < guestCount; k++) newArr[k] = guests[k];
                if (guests != NULL) delete[] guests;
                guests = newArr;
                capacity = newCap;
            }

            guests[guestCount].id = id;
            guests[guestCount].year = ParseYear(id);
            guests[guestCount].status = ParseStatus(id);
            guests[guestCount].reserveGrade = GradeFromReserveChar(reserveChar);
            guests[guestCount].checkin = d;
            guests[guestCount].nights = nights;
            guests[guestCount].checkout = d + nights - 1;
            guests[guestCount].inputIdx = globalInputIdx;

            dayGuests[d][j] = guestCount;
            if (guests[guestCount].checkout > D) D = guests[guestCount].checkout;

            guestCount++;
            globalInputIdx++;
        }
    }

    gGuests = guests;

    // 고객을 수락했는지 여부
    bool* accepted = new bool[guestCount];
    // 각 게스트에 대해 룸 인덱스
    int* roomIdxOf = new int[guestCount];
    // 각 게스트에 대해 등급 정보
    int* gradeOf = new int[guestCount];

    for (int i = 0; i < guestCount; i++) {
        accepted[i] = false;
        roomIdxOf[i] = -1;
        gradeOf[i] = -1;
    }

    // 활성 고객 목록
    int* active = new int[guestCount];
    int activeCount = 0;

    for (int t = 1; t <= D; t++) {
        int occ[ROOM_COUNT];
        for (int i = 0; i < ROOM_COUNT; i++) occ[i] = -1;

        bool rescueHappened = false;

        for (int i = 0; i < activeCount; i++) {
            int gi = active[i];
            int r = roomIdxOf[gi];
            if (r >= 0) occ[r] = gi;
        }

        if (t <= 5) {
            int nd = dayCount[t];
            for (int status = 0; status <= 4; status++) {
                for (int j = 0; j < nd; j++) {
                    int newIdx = dayGuests[t][j];
                    if (gGuests[newIdx].status != status) continue;

                    bool ok = TryAcceptNew(occ, roomIdxOf, gradeOf, newIdx, t, rescueHappened);
                    if (ok) {
                        accepted[newIdx] = true;
                        active[activeCount] = newIdx;
                        activeCount++;
                    } else {
                        accepted[newIdx] = false;
                        roomIdxOf[newIdx] = -1;
                        gradeOf[newIdx] = -1;
                    }
                }
            }
        }

        if (!rescueHappened) {
            UpgradePass(occ, roomIdxOf, gradeOf, active, activeCount, t);
        }

        PrintNight(occ, t);

        int i = 0;
        while (i < activeCount) {
            int gi = active[i];
            if (gGuests[gi].checkout == t) {
                roomIdxOf[gi] = -1;
                gradeOf[gi] = -1;
                active[i] = active[activeCount - 1];
                activeCount--;
            } else {
                i++;
            }
        }
    }

    return 0;
}
