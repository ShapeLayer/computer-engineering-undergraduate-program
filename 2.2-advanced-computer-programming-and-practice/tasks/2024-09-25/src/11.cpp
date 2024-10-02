#include <iostream>
#include <string>

using namespace std;

struct Product {
public:
  // 멤버 변수로는 제품의 이름을 나타내는 `name`,
  string name;

  // 제품의 가격을 나타내는 `price`,
  int price;

  // 제품에 대한 평가를 나타내는 `assessment`를 가진다.
  int assessment;

  /**
   * Product 생성자: name, price, assessment를 매개변수로 받는다.
   * 
   */
  Product(string name, int price, int assessment) {
    this->name = name;
    this->price = price;
    this->assessment = assessment;
  }

  // 멤버 함수로는 제품에 대한 정보들을 읽는 `getInfo()`,
  string getInfo() {
    return name + " - Price: " + to_string(price) + "; Assessment: " + to_string(assessment);
  }

  // 두 개의 제품을 비교하는 `bool isBetter(Product another)`,
  /**
   * `assessment` 속성을 기준으로 비교, `assessment`가 크면 더 나은 것으로 판단
   */
  bool isBetter(Product *other) {
    return this->assessment > other->assessment;
  }

  // 제품에 대한 정보를 출력하는 `print()`를 가진다.
  /**
   * getInfo 메서드를 호출해 받은 정보를 그대로 출력 스트림으로 전달
   */
  void print() {
    cout << this->getInfo() << endl;
  }
};

int main() {
  // Product 객체를 생성하여 테스트하여라
  /**
   * 테스트를 위해 가격 10, 평가 10의 first 상품과 가격 100, 평가 -1의 second 상품 생성
   * first는 second보다 평가가 좋음이 보장되므로(10 > -1 == true)
   * first의 정보를 항상 출력함.
   */
  Product first = Product("first", 10, 10), second = Product("second", 100, -1);
  if (first.isBetter(&second)) {
    first.print();
  } else {
    return 1;  // 만약 이 코드가 실행되면 문제가 있는 것.
  }
  return 0;
}
