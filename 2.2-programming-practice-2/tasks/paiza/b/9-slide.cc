#include <iostream>
using namespace std;

int main() {
  int H, W, Q;
  cin >> H >> W >> Q;
  bool grid[H][W];
  string line;
  for (int i = 0; i < H; i++) {
    cin >> line;
    for (int j = 0; j < W; j++) {
      grid[i][j] = line[j] == '#';
    }
  }

  for (int q = 0; q < Q; q++) {
    int type, idx;
    cin >> type >> idx;
    idx--;

    if (type == 1) {
      bool temp = grid[idx][0];
      for (int j = 0; j < W - 1; j++) {
        grid[idx][j] = grid[idx][j + 1];
      }
      grid[idx][W - 1] = temp;
    } else if (type == 2) {
      bool temp = grid[0][idx];
      for (int i = 0; i < H - 1; i++) {
        grid[i][idx] = grid[i + 1][idx];
      }
      grid[H - 1][idx] = temp;
    }
  }

  for (int i = 0; i < H; i++) {
    for (int j = 0; j < W; j++) {
      cout << (grid[i][j] ? '#' : '.');
    }
    cout << endl;
  }

  return 0;
}
