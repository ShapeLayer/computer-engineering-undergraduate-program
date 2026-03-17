#include <iostream>
#include <string>
using namespace std;

#include <iomanip>
#define COUT_WITH_PREC(prec, value) fixed << setprecision(prec) << value
#define CALC_STD_WEIGHT(height) (height * height * 22)
#define CALC_BMI(height, weight) (weight / (height * height))

bool getData(string* pName, double* pHeight, double* pWeight); // データ取得関数
double calcStandardWeight(double height); // 標準体重計算関数
double calcBMI(double height, double weight); // BMI計算関数
void showResult(string name, double standardWeight, double bmi); // 結果出力関数

int main() {
  string name; // 名前
  double height, weight, standardWeight, bmi; // 身長,体重,標準体重,BMI

  cin >> name; // 名前を入力
  cin >> height; // 身長を入力
  cin >> weight; // 体重を入力

  /*　ここを作成　*/
  if (!getData(&name, &height, &weight)) {
    // undefined behavior: return 1
    return 1;
  }

  showResult(
    name,
    calcStandardWeight(height),
    calcBMI(height, weight)
  );

  return 0;
}

/* データ取得関数 */
bool getData(string* pName, double* pHeight, double* pWeight) {
  /*　ここを作成　*/
  if (*pName == " ") return false;
  if (*pHeight <= 0) return false;
  if (*pWeight <= 0) return false;
  return true;
}

/* 標準体重計算関数 */
double calcStandardWeight(double height) {
  /*　ここを作成　*/
  return CALC_STD_WEIGHT(height);
}

/* BMI計算関数 */
double calcBMI(double height, double weight) {
  /*　ここを作成　*/
  return CALC_BMI(height, weight);
}

/* 結果出力関数 */
void showResult(string name, double standardWeight, double bmi) {
  /*　ここを作成　*/
  cout << name << "さんの標準体重は" << standardWeight << "kgです." << endl
       << "BMIは" << COUT_WITH_PREC(4, bmi) << "です." << endl
       << (
        bmi < 18.5 ? "やせ" : (
        bmi < 25 ? "標準" : (
        bmi < 30 ? "肥満" :
                   "高度肥満"))) << "型です." << endl;
}
