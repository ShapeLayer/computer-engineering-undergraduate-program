#include <iostream>
#include <string>
using namespace std;

#define PRINT_INPUT_VAL_INFORM cout << "商品名，単価，個数の入力：" << endl

//Productクラスの宣言
class Product {
private:
  string productName;
  int unitPrice, num;
public:
  Product();
  void setProduct(string pn, int up, int n);
  void show();
};

//PremierProductクラスの宣言
class PremierProduct : public Product {
  /*　ここを作成　*/
private:
  int point;
public:
  PremierProduct();
  void setPoint(int);
  void showPoint();
};

//Productクラスメンバ関数の定義
Product::Product() {
  productName = "init";
  unitPrice = 0;
  num = 0;
  cout << "商品を初期化しました" << endl;
}

void Product::setProduct(string pn, int up, int n) {
  productName = pn;
  unitPrice = up;
  num = n;
  cout << "商品を設定しました" << endl;
}

void Product::show() {
  cout << "商品名：" << productName << endl;
  cout << "単価：" << unitPrice << endl;
  cout << "個数：" << num << endl;
}

//PremierProductクラスメンバ関数の定義
PremierProduct::PremierProduct() {
  /*　ここを作成　*/
  cout << "プレミアポイントを初期化しました" << endl;
}

void PremierProduct::setPoint(int pp) {
  /*　ここを作成　*/
  this->point = pp;
  cout << "プレミアポイントを設定しました" << endl;
}

void PremierProduct::showPoint() {
  /*　ここを作成　*/
  cout << "プレミアポイント：" << this->point << endl;
}

int main() {
  string pn;
  int up, n, pp;

  Product product1;
  /*　ここを作成　*/
  product1.show();

  Product product2;
  /*　ここを作成　*/
  PRINT_INPUT_VAL_INFORM;
  cin >> pn >> up >> n;
  product2.setProduct(pn, up, n);
  product2.show();

  PremierProduct product3;
  /*　ここを作成　*/
  PRINT_INPUT_VAL_INFORM;
  cin >> pn >> up >> n;
  product3.setProduct(pn, up, n);
  product3.show();
  cout << "プレミアポイントの入力：" << endl;;
  cin >> pp;
  product3.setPoint(pp);
  product3.showPoint();

  return 0;
}
