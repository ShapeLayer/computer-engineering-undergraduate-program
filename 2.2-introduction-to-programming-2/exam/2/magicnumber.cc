#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <limits>

using namespace std;

// チームデータ構造体
struct Team {
    int id; // チームID
    int W;  // 勝利数
    int L;  // 敗戦数
    int T;  // 引き分け数
    int R;  // 残り試合数
};


int main() {
    int N;
    int G;

    cin >> N;

    if (N <= 1) {
        cerr << "入力エラー" << endl;
        return 1;
    }

    G = 2 * (N - 1);

    vector<Team> teams(N);

    // --- チーム情報入力と基本チェック ---
    for (int i = 0; i < N; i++) {
        teams[i].id = i;
        if (!(cin >> teams[i].W >> teams[i].L >> teams[i].T)) {
            cerr << "入力エラー" << endl;
            return 1;
        }

        int total_played = teams[i].W + teams[i].L + teams[i].T;
        if (total_played > G) {
            cerr << "入力エラー" << endl;
            return 1;
        }

        teams[i].R = G - total_played;
        if (teams[i].R < 0) {
            cerr << "入力エラー" << endl;
            return 1;
        }
    }

    // --- リーグ全体整合性チェック ---
    long long total_W = 0;
    long long total_L = 0;
    long long total_R = 0;
    int max_R = 0;

    for (int i = 0; i < N; i++) {
        total_W += teams[i].W;
        total_L += teams[i].L;
        total_R += teams[i].R;
        if (teams[i].R > max_R) {
            max_R = teams[i].R;
        }
    }

    // 勝敗数が一致しているか？
    if (total_W != total_L) {
        cerr << "入力エラー" << endl;
        return 1;
    }

    // 残り試合合計が偶数か？
    if (total_R % 2 != 0) {
        cerr << "入力エラー" << endl;
        return 1;
    }

    // 偏りチェック
    int half_total_R = total_R / 2;
    if (max_R > half_total_R) {
        cerr << "入力エラー" << endl;
        return 1;
    }

    /******** 回答箇所ここから ********/
    int top_index = 0;
    int magic_number = 0;
    Team own_team = teams[top_index];

    int max_win = -1;

#define SET_TEAM_AS_TOP(i) { \
    max_win = teams[i].W; \
    top_index = i; \
    own_team = teams[top_index]; \
}

    for (int i = 0; i < N; i++) {
        auto now = teams[i];
        if (now.W > max_win) {
            SET_TEAM_AS_TOP(i);
        }
    }

    int remains_available_win = -1;
    for (int i = 0; i < N; i++) {
        if (i == top_index) continue;
        auto now = teams[i];
        int curr_available_win = (N - 1) * 2 - (now.L + now.T);
        if (remains_available_win < curr_available_win) {
            remains_available_win = curr_available_win;
        }
    }
    
    magic_number = (remains_available_win + 1) - own_team.W;

    /******** 回答箇所ここまで ********/

    // --- 出力 ---
    cout << "----------------------------------------" << endl;
    cout << "首位チーム: " << (own_team.id + 1)
        << " (勝利数: " << own_team.W
        << ", 残り試合: " << own_team.R << ")" << endl;

    if (magic_number <= 0) {
        cout << "マジックナンバーは点灯していません（他チームの自力優勝が消滅）" << endl;
    }
    else if (magic_number > own_team.R) {
        cout << "マジックナンバーは点灯していません（必要勝利数 "
            << magic_number << " が残り試合数 " << own_team.R << " を上回っています）" << endl;
    }
    else {
        cout << "マジックナンバー: " << magic_number << endl;
    }

    cout << "----------------------------------------" << endl;
    return 0;
}
