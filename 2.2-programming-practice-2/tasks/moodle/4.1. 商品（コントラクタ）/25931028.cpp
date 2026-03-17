#include <iostream>
#include <string>
using namespace std;

//Productクラスの宣言
class Product {
private:
  string productName;
  int unitPrice, num;
public:
  Product();
  Product(string pn, int up, int n);
  void show();
  void showTotal();
};

//Productクラスメンバ関数の定義
Product::Product() {
  productName = "init";
  unitPrice = 0;
  num = 0;
  cout << "商品を初期化しました" << endl;
}

Product::Product(string pn, int up, int n) {
  /*　ここを作成　*/
  this->productName = pn;
  this->unitPrice = up;
  this->num = n;
  cout << "商品を設定しました" << endl;
}

void Product::show() {
  /*　ここを作成　*/
  cout << "商品名：" << this->productName << endl;
  cout << "単価：" << this-> unitPrice << endl;
  cout << "個数：" << this->num << endl;
}

void Product::showTotal() {
  /*　ここを作成　*/
  #define CALC_TOTAL_PRICE(prod) prod->unitPrice * prod->num
  cout << "合計金額：" << CALC_TOTAL_PRICE(this) << endl;
}

int main() {
  string pn;
  int up,n;

  /*　ここを作成　*/
  Product *product1 = new Product();
  product1->show();
  cout << "商品名，単価，個数の入力：" << endl;
  cin >> pn >> up >> n;
  Product *product2 = new Product(pn, up, n);
  product2->show();
  product2->showTotal();

  return 0;
}
