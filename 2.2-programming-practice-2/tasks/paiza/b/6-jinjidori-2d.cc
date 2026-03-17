#include <iostream>
#include <vector>
#define ABS(a) ((a) < 0 ? -(a) : (a))
using namespace std;

int main() {
  int N, M, Q;
  cin >> N >> M >> Q;

  vector<vector<int>> jins(N + 1, vector<int>(M + 1, 0));
  
  string user;
  int x, y;
  while (Q--) {
    cin >> user >> x >> y;
    int curr = jins[x][y];
    int player = (user == "A") ? 1 : 2;
    
    if (curr < 0) {
      continue;
    }
    
    if (curr == 0) {
      jins[x][y] = player;
    } else if (curr > 0 && curr != player) {
      jins[x][y] = 0;
    } else if (curr == player) {
      jins[x][y] = -player;
    }
  }

  int a = 0, b = 0;
  for (int i = 1; i < N + 1; i++) {
    for (int j = 1; j < M + 1; j++) {
      int curr = jins[i][j];
      if (ABS(curr) == 1) {
        a++;
      } else if (ABS(curr) == 2) {
        b++;
      }
    }
  }

  if (a > b) {
    cout << "A" << endl;
  } else if (a < b) {
    cout << "B" << endl;
  } else {
    cout << "Draw" << endl;
  }
  return 0;
}
