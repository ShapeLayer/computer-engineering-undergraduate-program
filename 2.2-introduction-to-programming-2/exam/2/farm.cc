/**
 * 문 1. 농장 운영
 * 
 * 길이 100의 배열로 농장을 나타내기 위해 char형 배열 farm[100]을 생성하였다. 초기상태에서는 모든 값이 `'`이다.
 * 이 농장에서 하루 한 번 활동하여, 10일분의 활동을 기록한다.
 * 
 * 활동의 종류는 아래와 같다.
 * 
 * ```
 * 〈활동 내용(입력)〉
 * 물 주기(`w`)   water
 * 비료 주기(`f`) fertilize
 * 씨앗 심기(`s`) sow seeds
 * 수확하기(`h`)  harvest
 * ```
 * 
 * 이어서, 어느 요소부터 어느 요소까지 해당 활동을 할 것인지 입력한다. (0~72, 52~99 등)
 * ```
 * 농장 요소의 상태는 아래와 같다.
 * - 초기 상태의 요소 `.`에 씨앗을 심으면(s) 싹(`^`)상태가 된다.
 *   (다른 상태에서는 싹을 심어도 상태가 변화하지 않는다.)
 * - 싹 `^` 상태의 요소에 총 3회의 물 주기(`w`)를 하면, 채소 `@` 상태가 된다.
 * - 싹 `^` 상태의 요소에 비료 주기(`f`)를 하면, 물 주기(`w`)를 2회 한 것으로 간주한다.
 *   이미 1회 이상 물은 준 요소라면, 채소(`@`) 상태가 된다.
 * - 채소 `@` 상태에서 3일이 지나면 (3일째에), 시든 채소 `*` 상태가 된다.
 * - 채소 `@` 혹은 시든 채소 `*`상태에서 수확하기(`h`)를 하면, 초기 상태 `.`가 된다.
 * ```
 * 상기는 초기 코드에 이미 구현되어있다.
 * 
 * 
 * 
 * 이번에는 위 농장의 수입과 지출에 대해서도 조사하게 되었다.
 * 초기 자금은 10000엔으로 하고, 매일 수입과 지출을 파악한다.
 * 
 * 아래의 활동에는 비용이 발생한다.
 * 
 * | 활동 내용(입력값) | 비용 |
 * | :-: | :-: |
 * | 비료(f) | 150엔/요소 |
 * | 물(w) | 50엔/요소 |
 * | 씨앗(s) | 5엔/요소 |
 * 
 * * 각 활동은 대상 범위의 모든 요소에 대해 비용이 발생한다.
 *   해당 구역의 상태가 변화지 않더라도, 지정된 범위 내에서 활동한 만큼 비용이 발생한다.
 * 
 * 수확(h)에는 수익률에 따라 수익이 있다.
 * | 수확물 | 수익 |
 * | `@` | 500엔/요소 |
 * | `*` | 10엔/요소 |
 * 
 * 
 * 활동 중에 자금이 부족하면, 그 시점에서 해당 날의 활동을 중단하고,
 * `「資金不足︓<活動内容>はX~Yのみ実施．」` (자금 부족: <활동내용>은 X~Y까지만 실시함.)라고 출력한다.
 * 활동은 왼쪽 요소에서부터 우선하여 수행하여야 한다.
 * 
 * 또한, 1개 요소도 처리하지 못하고 중단한 경우에는,
 * `資金不足︓<活動内容>を実施できませんでした」` (자금 부족: <활동내용>은 실시할 수 없었습니다.)라고 출력한다.
 * 
 * 이 규칙에 따라 초기 코드를 수정하여 일 수입, 지출이 올바르게 계산되도록 하여라.
 */

#include <iostream>
#include <map>
using namespace std;

struct PlantInfo {
    char state;    // '.'=empty, '^'=seedling, '@'=vegetable, '*'=withered
    int watering;  // number of times watered
    int daysSinceHarvest;  // days passed since becoming '@'

    PlantInfo() : state('.'), watering(0), daysSinceHarvest(0) {}
};

const int FARM_SIZE = 100;
const int INITIAL_BALANCE = 10000;
const int COST_SOW = 5;
const int COST_WATER = 50;
const int COST_FERTILIZE = 150;
const int REWARD_HARVEST_GOOD = 500;
const int REWARD_HARVEST_BAD = 10;

// --- 農園初期化 ---
void initializeFarm(map<int, PlantInfo>& farm) {
    for (int i = 0; i < FARM_SIZE; ++i) {
        farm[i] = PlantInfo();
    }
}

// --- 種まき ---
int sowSeeds(map<int, PlantInfo>& farm, int start, int end, int& balance) {
    int totalCost = 0;
    int firstDone = -1, lastDone = -1;

    if (balance - COST_SOW >= 0) firstDone = start;
    for (int i = start; i <= end; ++i) {
        if (balance - COST_SOW < 0) { break; }
        
        if (farm[i].state == '.') {
            farm[i].state = '^';
        }
        balance -= COST_SOW;
        totalCost += COST_SOW;
        lastDone = i;
    }

    if (firstDone == -1)
        cout << "資金不足：種まきを実施できませんでした" << endl;
    else if (lastDone < end)
        cout << "資金不足：種まきは " << firstDone << "～" << lastDone << " のみ実施" << endl;

    return totalCost;
}



// --- 水やり ---
int waterPlants(map<int, PlantInfo>& farm, int start, int end, int& balance) {
    int totalCost = 0;
    int firstDone = -1, lastDone = -1;

    if (balance - COST_WATER >= 0) firstDone = start;
    for (int i = start; i <= end; ++i) {
        if (balance - COST_WATER < 0) { break; }

        if (farm[i].state == '^') {
            farm[i].watering++;
            if (farm[i].watering >= 3) {
                farm[i].state = '@';
            }
        }
        balance -= COST_WATER;
        totalCost += COST_WATER;
        lastDone = i;
    }

    if (firstDone == -1)
        cout << "資金不足：水やりを実施できませんでした" << endl;
    else if (lastDone < end)
        cout << "資金不足：水やりは " << firstDone << "～" << lastDone << " のみ実施" << endl;

    return totalCost;
}

// --- 施肥 ---
int fertilizePlants(map<int, PlantInfo>& farm, int start, int end, int& balance) {
    int totalCost = 0;
    int firstDone = -1, lastDone = -1;

    if (balance - COST_FERTILIZE >= 0) firstDone = start;    
    for (int i = start; i <= end; ++i) {
        if (balance - COST_FERTILIZE < 0) { break; }

        if (farm[i].state == '^') {
            farm[i].watering += 2;
            if (farm[i].watering >= 3) {
                farm[i].state = '@';
            }
        }
        balance -= COST_FERTILIZE;
        totalCost += COST_FERTILIZE;
        lastDone = i;
    }

    if (firstDone == -1)
        cout << "資金不足：施肥を実施できませんでした" << endl;
    else if (lastDone < end)
        cout << "資金不足：施肥は " << firstDone << "～" << lastDone << " のみ実施" << endl;

    return totalCost;
}

// --- 収穫 ---
int harvestPlants(map<int, PlantInfo>& farm, int start, int end, int& balance) {
    int income = 0;
    for (int i = start; i <= end; ++i) {
        if (farm[i].state == '@') {
            farm[i].state = '.';
            farm[i].daysSinceHarvest = 0;
            farm[i].watering = 0;
            income += REWARD_HARVEST_GOOD;
        }
        else if (farm[i].state == '*') {
            farm[i].state = '.';
            farm[i].daysSinceHarvest = 0;
            farm[i].watering = 0;
            income += REWARD_HARVEST_BAD;
        }
    }
    balance += income;
    return income;
}

// --- 経過日処理 ---
void updateFarm(map<int, PlantInfo>& farm) {
    for (auto& entry : farm) {
        if (entry.second.state == '@') {
            entry.second.daysSinceHarvest++;
            if (entry.second.daysSinceHarvest >= 3) {
                entry.second.state = '*';
                entry.second.watering = 0;
            }
        }
    }
}

// --- 表示 ---
void displayFarm(const map<int, PlantInfo>& farm, int balance) {
    cout << endl << "農園状態:" << endl;
    for (const auto& entry : farm) cout << entry.second.state;
    cout << endl;
    cout << "残高: " << balance << "円" << endl;
}

// --- メイン ---
int main() {
    map<int, PlantInfo> farm;
    initializeFarm(farm);
    int balance = INITIAL_BALANCE;

    cout << "農園シミュレーション開始（10日間）" << endl;
    cout << "初期残高: " << balance << "円" << endl;

    for (int day = 1; day <= 10; ++day) {
        char activity;
        int start, end;
        int dailyExpense = 0, dailyIncome = 0;

        cout << endl << "Day " << day << ": 活動を入力 (s:種, w:水, f:肥料, h:収穫) → ";
        cin >> activity;
        cout << "範囲 (start end): ";
        cin >> start >> end;

        if (start < 0 || end >= FARM_SIZE || start > end) {
            cout << "範囲エラー再入力" << endl;
            day--;
            continue;
        }

        switch (activity) {
        case 's': dailyExpense = sowSeeds(farm, start, end, balance); break;
        case 'w': dailyExpense = waterPlants(farm, start, end, balance); break;
        case 'f': dailyExpense = fertilizePlants(farm, start, end, balance); break;
        case 'h': dailyIncome = harvestPlants(farm, start, end, balance); break;
        default:
            cout << "無効な入力" << endl; day--; continue;
        }

        updateFarm(farm);
        displayFarm(farm, balance);

        cout << endl;
        cout << "Day " << day << " の収支: "
            << "支出 " << dailyExpense << "円, 収入 " << dailyIncome
            << "円 → 残高 " << balance << "円" << endl;
        cout << "------------------------------------------------------------" << endl;
    }

    cout << endl << "10日間終了！最終残高: " << balance << "円" << endl;
    return 0;
}
