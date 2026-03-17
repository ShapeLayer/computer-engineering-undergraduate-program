#include <iostream>
#include <string>
using namespace std;

//Bodyクラスの宣言
class Body {
private:
  string name;
  double height;
  double weight;
public:
  string getName() { return name; }
  double getHeight() { return height; }
  double getWeight() { return weight; }
  void setInfo(string n, double h, double w);
};

//Bodyクラスメンバ関数の定義
void Body::setInfo(string n, double h, double w){
  /*　ここを作成　*/
  this->name = n;
  this->height = h;
  this->weight = w;
}

double bmi(Body* pB);

int main(){
  /*　ここを作成　*/
  string _name;
  double _height, _weight;

  Body *a = new Body();
  Body *b = new Body();

  cin >> _name >> _height >> _weight;
  a->setInfo(_name, _height, _weight);
  cin >> _name >> _height >> _weight;
  b->setInfo(_name, _height, _weight);

  cout << (bmi(a) > bmi(b) ? a->getName() : b->getName()) << endl;

  return 0;
}

//bmi関数の定義
double bmi(Body* pB){
  string n = pB->getName();
  /*　ここを作成　*/
  #define CALC_BMI(h, w) w / (h * h)
  double BMI = CALC_BMI(pB->getHeight(), pB->getWeight());
  cout << n << "さんのBMI値は" << BMI << endl;
  return BMI;
}
