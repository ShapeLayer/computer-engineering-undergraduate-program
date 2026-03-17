#include <iostream>
using namespace std;

#define SWAP_REF(a, b) { auto tmp = *a; *a = *b; *b = tmp; }

void sort2(int* pValue1, int* pValue2); // 渡した2つの値を小さい順に入れなおす関数

int main() {
  int value1, value2;
  cin >> value1; // 整数1つ目
  cin >> value2; // 整数2つ目

  /*　ここを作成　*/
  sort2(&value1, &value2);
  cout << value1 << ' ' << value2 << endl;

  return 0;
}

/* 渡した2つの値を小さい順に入れなおす関数 */
void sort2(int* pValue1, int* pValue2) {
  /*　ここを作成　*/
  if (*pValue1 > *pValue2) {
    SWAP_REF(pValue1, pValue2);
  }
}
