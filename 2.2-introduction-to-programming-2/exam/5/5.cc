/**
 * problem.md 2026-02-01
1 / 6
問題5 ホテル客室割り当て

あなたはホテルの客室割り当てシミュレーションを作成する。
호텔 객실 배정 시뮬레이션을 작성
ホテルには 10 室あり、客室はグレード別に次の通りである。
호텔은 10개의 객실을 보유
Eグレード（Executive）︓301, 302（2室）
Pグレード（Premium）︓201, 202, 203（3室）
Bグレード（Basic）︓101, 102, 103, 104, 105（5室）


以降、「その夜の割り当て」とは、その夜に各客がどの部屋で宿泊するかを決めることを指す。
また、「アップグレード」とは、すでに宿泊中の客を、空いている上位グレードの部屋へ割り当て直すこと
を指す。

여기서 '그날 밤 할당'은 각 손님이 그날 밤 머무를 방을 결정
또한 '업그레이드'란 이미 객실에 머무르고 있는 손님이 더 높은 등급의 객실로 재배정

（客をホテルから追い出したり、他の客のために部屋を空けさせたりはしない。）
손님을 호텔에서 내쫓거나 다른 손님을 위해 방을 제공하지 않음

⼊⼒される各客の情報
입력되는 고객 정보
各客には次の情報が与えられる。

会員ID︓9桁の数字⽂字列（例︓201710003）
회원아이디 9열 문자열
先頭4桁︓登録年（例︓2017）
선두4열은 등록년
5桁⽬︓会員ステータス（0〜4、⼩さいほど強い）
5열째는 회원 스테이터스 작을수록 강함
予約グレード︓B / P / E
예약 그룹:
宿泊⽇数︓nights（1以上）
체류기간 1박 이상

客は⼊⼒された⽇（Day）にチェックインし、nights 泊する。
투숙객은 입력된 날에 체크인하고 nights박 머뭄

チェックイン⽇を d とすると、宿泊する夜は d 〜 d+nights-1（両端を含む）である。
체크인 날짜가 d라면 체류 박하는 밤은 d ~ d + nights - 1

シミュレーションの処理⼿順（各夜 t ごと）
시뮬레이션 처리 각야 t

最⼤宿泊最終夜 D（全客の checkout = checkin + nights - 1 の最⼤値）まで、夜 t = 1..D を順に処理
する。
체류 최대일 D (체크아웃 = 체크인 + nights - 1)

Step1︓継続宿泊客を「同じ部屋のまま」配置する
연속해서 머문다면 그대로 배정
前夜までに受け⼊れられており、かつ夜 t に宿泊している客（チェックアウトしていない客）を、前夜終了
時点で割り当てられていた部屋と同じ部屋に配置する。

Step2︓その⽇の新規客（Day = t の客）を受け⼊れ判定し、割り当てる
그 날에 새로운 손님이 들어온다면 나눠서 처리
夜 t が 1〜5 のとき、その⽇にチェックインする新規客がいる。新規客は次の順で処理する。
밤 t가 1~5라면 그 날의 체크인한 신규객이 있다는 것 
신규객은 이하와 같이 처리

1. 会員ステータスが⼩さい順（0 → 4）
회원 스테이터스가 작은순

2. 同ステータス内は⼊⼒順（その⽇の⼊⼒順）
동일 스테이터스내에서는 입력순

各新規客について次を⾏う。
각 신규객에 대해서 

まず、その客が宿泊可能なグレード集合を会員ルールで判定する。
먼저 그 객의 숙박수를 그레이드 집합을 회원 룰에 맞게 결정

宿泊可能なグレードのうち、E → P → B の順に空室があるか調べる。
숙박가능한 그레이드 안에서 e -> p -> b
空室があれば、そのグレード内で最も番号が⼩さい空室に割り当てる。
그룹 안에서 가장 낮은 번호의 공석 배정

どの宿泊可能グレードにも空室がなければ、その客は割り当てなし（受け⼊れなし）とする。
어던 그레이드에도 공석 없으면 배정 취소

Step3︓アップグレード（空室がある上位グレードを埋める移動）
업그레이드: 공석 잇는 상위 등급을 채우기 위해

新規客の割り当てが終わったら次を⾏う。
신규 객 할당이 완료되면 다음 수행
1. Eグレードに空室がある限り繰り返す
1. e 등급 공석 있는 한 반복
Eに宿泊可能で、かつ現在E以外（BまたはP）に割り当てられている宿泊中の客から、 「アップ
グレード優先順位」が最も⾼い1⼈を選び、その客を空いているEの部屋へ移動する。
e에 머물 수 있지만 머물지 못하는 손님에 대해 업그레이드우선 권리가 제일 높은 1인을 선택
그 객을 빈 방의 e방으로 옮기기

空いているE部屋が複数ある場合は、番号が⼩さい⽅（301→302）から埋める。
상황이 계속된다면 방번호 증가순으로 채우기

2. 次に、Pグレードに空室がある限り繰り返す
P그룹에 공실이 있다면 반복
Pに宿泊可能で、かつ現在Bに割り当てられている宿泊中の客から、 「アップグレード優先順
位」が最も⾼い1⼈を選び、その客を空いているPの部屋へ移動する。
P에 머물 수 있고 현재 B에 배정된 손님들 중에서는 업그레이드 우선권리
제일 높은 1인을 선택해 그 객의 비어있는 P 방을 이동

空いているP部屋が複数ある場合は、番号が⼩さい⽅（201→202→203）から埋める。
방 할당은 증가순

アップグレード優先順位（より優先される客）
업그레이드 우선순위
다음 키들을 위에서 이어지는 순으로 비교하여 앞서 결정되는 사람에 대해서 결정
次のキーを上から順に⽐較し、先に決まった差で順位を決める。
1. 会員ステータスが⼩さい⽅が優先（0が最優先）
낮은 회원 스테이터스
2. 残り宿泊数（当夜を含む）が少ない⽅が優先
남은 숙박수가 적은 편
残り宿泊数 = checkout - t + 1
3. 登録年が⼩さい⽅が優先（古いほど優先）
등록 연도가 더 빠를수록
4. 会員IDが⼩さい⽅が優先（9桁固定なので⽂字列⽐較でよい）
회원 아이디가 더 낮을수록
5. 全体⼊⼒順が⼩さい⽅が優先（先に⼊⼒された⽅）
먼저 입력된 순

会員ルール︓その客が宿泊可能なグレード
회원 규정: 숙박객이 머물 수 있는 등급

共通ルールとして、予約グレードより下位のグレードには宿泊できない（例︓予約PならBは不可）。
통상룰로는 예약 그룹보다 낮은 그룹에는 머물 수 없다
P라면 B에 못감

その上で、会員ステータスごとの宿泊可否は次の通り。
각 회원의 스테이터스에 의해 숙박 가능여부는 이어서

status = 0, 1（プラチナ・ゴールド） 플레 골드
予約以上ならすべて宿泊可（B予約ならB/P/E、P予約ならP/E、E予約ならE）
모든 예약 가능 (B/PE -> B, P/E -> P, E -> E)

status = 2（シルバー） 실버
予約B︓B と P は可、E は不可 B P 가능 E불가능
予約P︓P のみ可（E不可） P 가능
予約E︓E のみ可        E 가능

status = 3（ブロンズ） 브론즈
予約B︓
登録年 year <= 2017 のとき︓B と P は可、E は不可
<= 17년 : B P 가능 E 불가
登録年 year >= 2018 のとき︓B のみ可
>= 18년 : B 가능
予約P︓P のみ可 P 가능
予約E︓E のみ可 E 가능

status = 4（ノーマル） 노말
アップグレード不可。予約グレードのみ可（予約B→Bのみ、予約P→Pのみ、予約E→Eのみ）
업그레이드 불가 예약 그레이드만 가능

問5で⾏うこと
提⽰される初期コードのうち、次の2関数（回答記⼊箇所①〜②）を完成させ、上記仕様通りに動作するよう
にせよ。
CanUseGrade
BuildPrefGradesDesc
⼊⼒形式
Day 1 から Day 5 まで、次をこの順で与える。
その⽇にチェックインする新規客の⼈数 nd
続く nd ⾏で、id reserveGrade nights
nd1
id reserveGrade nights
...
（nd1 ⾏）
nd2
id reserveGrade nights
...
（nd2 ⾏）
...
nd5
id reserveGrade nights
...
（nd5 ⾏）
reserveGrade は B / P / E のいずれかである。
出⼒形式
夜 t = 1..D について、次の 5 ⾏を出⼒する（最後の 1 ⾏は空⾏）。
1. night:t
2. E ⾏（301,302 の2室を出⼒し、残り3列は -）
3. P ⾏（201,202,203 の3室を出⼒し、残り2列は -）
4. B ⾏（101〜105 の5室を出⼒）
5. 空⾏
problem.md 2026-02-01
4 / 6
各⾏はカンマ区切りで出⼒する。空室は 0 として出⼒する。
サンプル
⼊⼒1
6
201500001 B 3
201620002 B 3
201730003 B 1
201830004 B 3
201840005 P 3
201940006 B 3
2
201820007 B 1
201940008 E 1
0
0
0
出⼒1
night:1
201500001,0,-,-,-
201620002,201730003,201840005,-,-
201830004,201940006,0,0,0
night:2
201500001,201940008,-,-,-
201620002,201820007,201840005,-,-
201830004,201940006,0,0,0
night:3
201500001,0,-,-,-
201620002,0,201840005,-,-
201830004,201940006,0,0,0
⼊⼒2
7
201600002 B 3
201710003 P 3
201620004 B 2
201730005 B 2
201930006 B 2
201840007 B 2
201840008 P 1
1
201710009 B 1
0
0
0
出⼒2
night:1
201600002,201710003,-,-,-
201620004,201730005,201840008,-,-
201930006,201840007,0,0,0
night:2
201600002,201710003,-,-,-
201620004,201730005,201710009,-,-
201930006,201840007,0,0,0
night:3
201600002,201710003,-,-,-
0,0,0,-,-
0,0,0,0,0
⼊⼒3
3
201600001 B 5
201720002 B 3
201830003 P 2
2
201910004 B 4
201840005 B 2
3
201730006 B 3
201920007 E 1
201610008 P 3
2
201640009 B 2
201520010 B 2
2
201810011 P 1
201740012 B 1
出⼒3
problem.md 2026-02-01
6 / 6
night:1
201600001,0,-,-,-
201720002,201830003,0,-,-
0,0,0,0,0
night:2
201600001,201910004,-,-,-
201720002,201830003,0,-,-
201840005,0,0,0,0
night:3
201600001,201910004,-,-,-
201720002,201610008,201730006,-,-
201840005,0,0,0,0
night:4
201600001,201910004,-,-,-
201520010,201610008,201730006,-,-
201640009,0,0,0,0
night:5
201600001,201910004,-,-,-
201520010,201610008,201730006,-,-
201640009,201740012,0,0,0
⼊⼒4
3
201700001 B 2
201800002 B 1
201940003 P 2
0
0
0
0
出⼒4
（data/sample/4.ans を参照）
 */

#include <iostream>
#include <string>
using namespace std;

#define GRADE_B 0
#define GRADE_P 1
#define GRADE_E 2
#define ROOM_COUNT 10

/*
  occ[] の並び（出力順）：
  0:301 1:302
  2:201 3:202 4:203
  5:101 6:102 7:103 8:104 9:105
*/
const int GRADE_START[3] = { 5, 2, 0 }; // B,P,E
const int GRADE_LEN[3] = { 5, 3, 2 }; // B,P,E

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
    for (int i = 0; i < 4; i++) {
        y = y * 10 + (id[i] - '0');
    }
    return y;
}

int ParseStatus(const string& id) {
    return id[4] - '0';
}

// 9桁固定なので辞書順が数値順と一致
bool IdLess(const string& a, const string& b) {
    return a < b;
}
bool IdGreater(const string& a, const string& b) {
    return a > b;
}

/*
  [回答記入箇所①]
  会員ルール込み：その客が grade に泊まれるか
  （予約未満禁止＋会員別アップグレード可否）
*/
bool CanUseGrade(const Guest& g, int grade) {
    // TODO: 会員ルール込みで、その客が grade に泊まれるかを返す
    // TODO: 회원 규칙 포함, 그 손님이 grade에 머물 수 있는지 반환
    
    switch (g.status) {
    case 0: // platinum
    case 1: // gold
        return (grade >= g.reserveGrade);
    case 2: // silver
        if (g.reserveGrade == GRADE_B) {
            return (grade == GRADE_B || grade == GRADE_P);
        }
        else if (g.reserveGrade == GRADE_P) {
            return (grade == GRADE_P);
        }
        else { // e
            return (grade == GRADE_E);
        }
    case 3: // bronze
        if (g.reserveGrade == GRADE_B) {
            if (g.year <= 2017) {
                return (grade == GRADE_B || grade == GRADE_P);
            }
            else {
                return (grade == GRADE_B);
            }
        }
        else if (g.reserveGrade == GRADE_P) {
            return (grade == GRADE_P);
        }
        else { // e
            return (grade == GRADE_E);
        }
    case 4: // normal   
        if (g.reserveGrade == GRADE_B) {
            return (grade == GRADE_B);
        }
        else if (g.reserveGrade == GRADE_P) {
            return (grade == GRADE_P);
        }
        else { // e
            return (grade == GRADE_E);
        }
    }

    return (grade == g.reserveGrade);
}

/*
  [回答記入箇所②]
  E -> P -> B の順で、泊まれるグレードだけ pref に詰める
*/
void BuildPrefGradesDesc(const Guest& g, int pref[3], int& cnt) {
    // TODO: E->P->B の順で、泊まれるグレードだけ pref に詰める
    // TODO: E->P->B 순서로, 머물 수 있는 등급만 pref에 채우기
    // pref: 선호 내지는 가용한 등급
    cnt = 0;
    for (int grade = GRADE_E; grade >= GRADE_B; grade--) {
        if (CanUseGrade(g, grade)) {
            pref[cnt++] = grade;
        }
    }
}

/* 以下は変更しないこと（出力も含む） */

int FindFreeRoomIndex(int occ[ROOM_COUNT], int grade) {
    int start = GRADE_START[grade];
    int len = GRADE_LEN[grade];
    for (int i = 0; i < len; i++) {
        int idx = start + i;
        if (occ[idx] == -1) return idx;
    }
    return -1;
}

void PlaceGuest(int occ[ROOM_COUNT], int roomIdxOf[], int gradeOf[], int guestIdx, int roomIdx) {
    occ[roomIdx] = guestIdx;
    roomIdxOf[guestIdx] = roomIdx;
    gradeOf[guestIdx] = GradeFromRoomIndex(roomIdx);
}

void ApplyMove(int occ[ROOM_COUNT], int roomIdxOf[], int gradeOf[], int guestIdx, int toRoomIdx) {
    int fromRoomIdx = roomIdxOf[guestIdx];
    occ[fromRoomIdx] = -1;
    occ[toRoomIdx] = guestIdx;
    roomIdxOf[guestIdx] = toRoomIdx;
    gradeOf[guestIdx] = GradeFromRoomIndex(toRoomIdx);
}

bool TryAcceptNew(int occ[ROOM_COUNT], int roomIdxOf[], int gradeOf[], int newIdx) {
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
    // Eへ上げる
    while (true) {
        int freeE = FindFreeRoomIndex(occ, GRADE_E);
        if (freeE == -1) break;

        int best = -1;
        for (int i = 0; i < activeCount; i++) {
            int u = active[i];
            if (gradeOf[u] == -1) continue;

            if (gradeOf[u] == GRADE_E) continue;
            if (!CanUseGrade(gGuests[u], GRADE_E)) continue;

            if (best == -1) best = u;
            else {
                if (BetterForUpgrade(u, best, nightT)) best = u;
            }
        }

        if (best == -1) break;

        ApplyMove(occ, roomIdxOf, gradeOf, best, freeE);
    }

    // Pへ上げる（B->P）
    while (true) {
        int freeP = FindFreeRoomIndex(occ, GRADE_P);
        if (freeP == -1) break;

        int best = -1;
        for (int i = 0; i < activeCount; i++) {
            int u = active[i];
            if (gradeOf[u] != GRADE_B) continue;
            if (!CanUseGrade(gGuests[u], GRADE_P)) continue;

            if (best == -1) best = u;
            else {
                if (BetterForUpgrade(u, best, nightT)) best = u;
            }
        }

        if (best == -1) break;

        ApplyMove(occ, roomIdxOf, gradeOf, best, freeP);
    }
}

void PrintNight(int occ[ROOM_COUNT], int nightT) {
    cout << "night:" << nightT << endl;

    // E行：301,302,-,-,-
    for (int c = 0; c < 5; c++) {
        if (c > 0) cout << ",";
        if (c < 2) {
            int u = occ[c];
            if (u == -1) cout << 0;
            else cout << gGuests[u].id;
        }
        else {
            cout << "-";
        }
    }
    cout << endl;

    // P行：201,202,203,-,-
    for (int c = 0; c < 5; c++) {
        if (c > 0) cout << ",";
        if (c < 3) {
            int u = occ[2 + c];
            if (u == -1) cout << 0;
            else cout << gGuests[u].id;
        }
        else {
            cout << "-";
        }
    }
    cout << endl;

    // B行：101..105
    for (int c = 0; c < 5; c++) {
        if (c > 0) cout << ",";
        int u = occ[5 + c];
        if (u == -1) cout << 0;
        else cout << gGuests[u].id;
    }
    cout << endl;

    cout << endl; // 夜ブロック後の空行
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

    // 入力
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
                delete[] guests;
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

    bool* accepted = new bool[guestCount];
    int* roomIdxOf = new int[guestCount];
    int* gradeOf = new int[guestCount];

    for (int i = 0; i < guestCount; i++) {
        accepted[i] = false;
        roomIdxOf[i] = -1;
        gradeOf[i] = -1;
    }

    int* active = new int[guestCount];
    int activeCount = 0;

    // 夜ごと処理
    for (int t = 1; t <= D; t++) {
        int occ[ROOM_COUNT];
        for (int i = 0; i < ROOM_COUNT; i++) occ[i] = -1;

        // Step1: 継続客を同室維持で据え置き
        for (int i = 0; i < activeCount; i++) {
            int gi = active[i];
            int r = roomIdxOf[gi];
            if (r >= 0) occ[r] = gi;
        }

        // Step2: Day t の新規客を status昇順→入力順で処理
        if (t <= 5) {
            int nd = dayCount[t];
            for (int status = 0; status <= 4; status++) {
                for (int j = 0; j < nd; j++) {
                    int newIdx = dayGuests[t][j];
                    if (gGuests[newIdx].status != status) continue;

                    if (TryAcceptNew(occ, roomIdxOf, gradeOf, newIdx)) {
                        accepted[newIdx] = true;
                        active[activeCount] = newIdx;
                        activeCount++;
                    }
                    else {
                        accepted[newIdx] = false;
                        roomIdxOf[newIdx] = -1;
                        gradeOf[newIdx] = -1;
                    }
                }
            }
        }

        // Step3: アップグレード
        UpgradePass(occ, roomIdxOf, gradeOf, active, activeCount, t);

        // Step4: 出力
        PrintNight(occ, t);

        // チェックアウトした客を active から削除
        int i = 0;
        while (i < activeCount) {
            int gi = active[i];
            if (gGuests[gi].checkout == t) {
                roomIdxOf[gi] = -1;
                gradeOf[gi] = -1;
                active[i] = active[activeCount - 1];
                activeCount--;
            }
            else {
                i++;
            }
        }
    }

    return 0;
}
