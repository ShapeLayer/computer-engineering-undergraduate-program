#include <iostream>
using namespace std;

#define SWAP_REF(a, b) { auto tmp = *a; *a = *b; *b = tmp; }

// 3つの整数変数の値を小さい順に入れなおす
void sort3(int* pValue1, int* pValue2, int* pValue3); 
// 2つの整数変数の値を小さい順に入れなおす
void sort2(int* pValue1, int* pValue2);

int main() {
  int value1, value2, value3;
  cin >> value1; // 整数1つ目
  cin >> value2; // 整数2つ目
  cin >> value3; // 整数3つ目

  /*　ここを作成　*/
  sort3(&value1, &value2, &value3);
  cout << value1 << ' ' << value2 << ' ' << value3 << endl;
}

/* 渡した3つの値を小さい順に入れなおす関数 */
void sort3(int* pValue1, int* pValue2, int* pValue3) {
  /*　ここを作成　*/
  /**
   * Consider bubble sort-like access:
   * for (int i = 0; i < N; i++) {
   *   for (int j = i + 1; j < N; j++) {
   *     sort2(v[i], v[j]);
   *   }
   * }
   * 
   * then sort2 would be called in sequence of
   *  (0, 1), (0, 2), (1, 2)
   */
  sort2(pValue1, pValue2);
  sort2(pValue1, pValue3);
  sort2(pValue2, pValue3);
}

/* 渡した2つの値を小さい順に入れなおす関数 */
void sort2(int* pValue1, int* pValue2) {
  /*　ここを作成　*/
  if (*pValue1 > *pValue2) {
    SWAP_REF(pValue1, pValue2);
  }
}
