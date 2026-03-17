#include <iostream>
#include <string>
using namespace std;

#define N 3  //行
#define M 2  //列

/* メイン関数 */
int main() {
  string crypt;
  char rectangle[N][M]; //矩形
  int xpos; //行
  int ypos; //列

  getline(cin, crypt); //文字列の読み込み

  /*　ここを作成　*/
  string output;
  #define CLR_BUF(rectbuf) for (int i = 0; i < N; i++) for (int j = 0; j < M; j++) rectbuf[i][j] = ' ';
  #define PUSH_OUTPUT(rectbuf, outbuf) for (int j = 0; j < M; j++) for (int i = 0; i < N; i++) outbuf += rectbuf[i][j];
  #define MOVE_POS_NEXT(_xpos, _ypos) { \
    _xpos++; \
    if (_xpos >= M) { \
      _xpos = 0; \
      _ypos++; \
    } \
  }
  ypos = 0, xpos = 0;

  for (int ptr = 0; ptr < crypt.size(); ptr++) {
    if (ypos == 0 && xpos == 0) {
      // starts with new rect buf
      CLR_BUF(rectangle);
    }
    
    char now = crypt.at(ptr);
    rectangle[ypos][xpos] = now;
    MOVE_POS_NEXT(xpos, ypos);

    if (ypos == N) {
      PUSH_OUTPUT(rectangle, output);
      ypos = 0;
    }
  }
  if (!(ypos == 0 && xpos == 0)) {
    PUSH_OUTPUT(rectangle, output)
  }
  cout << output << endl;

  return 0;
}
