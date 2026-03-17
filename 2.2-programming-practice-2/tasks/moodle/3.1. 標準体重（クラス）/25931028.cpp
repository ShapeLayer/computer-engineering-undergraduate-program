#include <iostream>
#include <string>
using namespace std;

class Body { //Bodeクラスの宣言
public:
  string name;
  double height;
  double weight;
  void showSW(); //適正体重まであと何kgかを表示
};

void Body::showSW() { //Bodyクラスメンバ関数の定義
  /*　ここを作成　*/
  #define CALC_STD_WEIGHT(h) h * h * 22
  cout << CALC_STD_WEIGHT(this->height) - this->weight << endl;
}

int main() {
  /*　ここを作成　*/
  Body *a = new Body();
  cin >> a->name >> a->height >> a->weight;
  Body *b = new Body();
  cin >> b->name >> b->height >> b->weight;

  a->showSW();
  b->showSW();
  cout << (a->height > b->height ? a->name : b->name) << endl;

  return 0;
}
