#include <algorithm>
#include <iostream>
#include <queue>
#include <string>
#include <utility>
#include <vector>

using namespace std;

int main() {
  ios::sync_with_stdio(false);
  cin.tie(nullptr);

  int H, W, N, K;
  cin >> H >> W >> N >> K;

  vector<string> grid(H);
  for (int i = 0; i < H; ++i) {
    cin >> grid[i];
  }

  vector<int> bomb_row(N), bomb_col(N), bomb_radius(N);
  vector<bool> bomb_alive(N, false);
  vector<vector<int>> bomb_id_at(H, vector<int>(W, -1));

  for (int i = 0; i < N; ++i) {
    int p, q, r;
    cin >> p >> q >> r;
    int y = p - 1;
    int x = q - 1;
    bomb_row[i] = y;
    bomb_col[i] = x;
    bomb_radius[i] = r;
    bomb_alive[i] = true;
    grid[y][x] = '$';
    bomb_id_at[y][x] = i;
  }

  for (int step = 0; step < K; ++step) {
    int X;
    cin >> X;
    int bomb_index = X - 1;
    if (bomb_index < 0 || bomb_index >= N || !bomb_alive[bomb_index]) {
      continue;
    }

    queue<int> q;
    q.push(bomb_index);

    auto clearCell = [&](int y, int x) {
      if (grid[y][x] == 'o') {
        return;
      }
      if (grid[y][x] == '$') {
        int id = bomb_id_at[y][x];
        if (id >= 0 && bomb_alive[id]) {
          q.push(id);
        }
      }
      grid[y][x] = 'o';
      bomb_id_at[y][x] = -1;
    };

    while (!q.empty()) {
      int cur = q.front();
      q.pop();
      if (!bomb_alive[cur]) {
        continue;
      }

      int by = bomb_row[cur];
      int bx = bomb_col[cur];
      int br = bomb_radius[cur];
      if (by < 0 || bx < 0) {
        continue;
      }

      bomb_alive[cur] = false;
      bomb_row[cur] = -1;
      bomb_col[cur] = -1;

      int c1 = max(0, bx - br);
      int c2 = min(W - 1, bx + br);
      for (int cx = c1; cx <= c2; ++cx) {
        clearCell(by, cx);
      }

      int r1 = max(0, by - br);
      int r2 = min(H - 1, by + br);
      for (int ry = r1; ry <= r2; ++ry) {
        if (ry == by) {
          continue;
        }
        clearCell(ry, bx);
      }
    }

    vector<pair<char, int>> buffer;
    buffer.reserve(H);
    for (int col = 0; col < W; ++col) {
      buffer.clear();
      for (int row = H - 1; row >= 0; --row) {
        if (grid[row][col] != 'o') {
          buffer.emplace_back(grid[row][col], bomb_id_at[row][col]);
        }
      }

      int idx = 0;
      for (int row = H - 1; row >= 0; --row) {
        if (idx < static_cast<int>(buffer.size())) {
          grid[row][col] = buffer[idx].first;
          int occupant = buffer[idx].second;
          bomb_id_at[row][col] = occupant;
          if (occupant >= 0) {
            bomb_row[occupant] = row;
            bomb_col[occupant] = col;
          }
          ++idx;
        } else {
          grid[row][col] = '.';
          bomb_id_at[row][col] = -1;
        }
      }
    }
  }

  for (int i = 0; i < H; ++i) {
    for (int j = 0; j < W; ++j) {
      char c = grid[i][j];
      if (c == 'o') {
        cout << '.';
      } else {
        cout << c;
      }
    }
    cout << '\n';
  }

  return 0;
}
