#import "@preview/codly:0.2.0": *
#show: codly-init.with()
#codly(languages: (
  py: (name: "Python", icon: "", color: rgb("#3572A5")),
  cpp: (name: "C++", icon: "", color: rgb("#f34b7d"))
))


#set page(
  margin: (x: 3em, y: 4em)
)
#set text(font: ("Noto Sans CJK KR", "Noto Sans KR"), size: .9em)

#align(center)[
  #text(size: 2em)[고급프로그래밍및실습 과제 \#2]\
  
  214823 박종현
]
\

#text(size: 1.5em)[\#9] 평균을 구하는 멤버 함수 `getAverage()`를 중복 정의해보자.
```cpp
#include <iostream>

using namespace std;

struct Calculator {
public:
  float getAverage(int a, int b) {
    /**
     * Calculate average of numbers.
     *
     *
     * @param a, b Two integers to be averaged.
     * @return average of `values`.
     */
    return ((float)(a + b)) / 2;
  }

  float getAverage(int a, int b, int c) {
    /**
     * Calculate average of numbers.
     *
     *
     * @param a, b, c Three integers to be averaged.
     * @return average of `values`.
     */
    return ((float)(a + b + c)) / 3;
  }
};

int main() {
  /**
   * Input expected: 3 Integers seperated by whitespace.
   * example:
   * 7 8 10
   */
  Calculator calc = Calculator();
  int a, b, c;
  
  cin >> a >> b >> c;
  float first = calc.getAverage(a, b);
  float second = calc.getAverage(a, b, c);
  cout << "The result of two overloaded `getAverage()` function" << endl;
  cout << "getAverage(a, b): " << first << endl;
  cout << "getAverage(a, b, c): " << second << endl;

  return 0;
}
```
#image("./assets/9.png")
#pagebreak()

#text(size: 1.5em)[\#10] `MyArray`라는 이름의 클래스를 작성하여 보자 ...
```cpp
#include <iostream>

using namespace std;

struct ArrayNode;
struct MyArray;

struct ArrayNode {
  /**
   * `ArrayNode` is data container for `MyArray` class to implement
   * linkedlist-like array with dynamic allocation.
   */
private:
  /**
   * `*_p` indicates `MyArray` that uses this as data container.
   * `_*p` is declared because it may be useful later, but this 
   */
  MyArray *_p;
public:
  int value;
  ArrayNode *next = NULL;
  ArrayNode *prev = NULL;
  ArrayNode(MyArray *p, ArrayNode *prev, int e) {
    this->_p = p;
    this->prev = prev;
    this->value = e;
  }
  void setNext(ArrayNode *node) {
    this->next = node;
  }
};

struct MyArray {
private:
  // 멤버 변수로는 배열의 크기를 나타내는 size와
  int size = 0;

  // 정수들이 실제로 저장된 메모리를 가리키는 `ptr`을 가진다.
  ArrayNode *ptr = NULL;  // Head
  ArrayNode *ptr_tail = NULL;  // Tail

public:
  // `size` is encapsulized: This `getSize()` is getter.
  int get_size() { return this->size; }

  // 멤버 함수로는 정수를 추가하는 append()
  void append(int e) {
    ArrayNode *last = this->ptr_tail;
    // 새 노드 생성
    ArrayNode *_new = new ArrayNode(this, last, e);
    // 마지막 노드가 null이라면 빈 리스트인 것
    if (last == NULL)
      this->ptr = _new;  // 이 경우 시작 노드를 새로 생성한 노드로 지정
    else
      last->next = _new;  // 빈 리스트가 아니라면 마지막 노드의 다음 노드를 새로 생성한 노드로 지정
    // 마지막 노드 수정
    this->ptr_tail = _new;
    // 배열 크기 증가
    this->size++;
  }

  // 마지막 정수를 삭제하는 delete()
  // delete() is reserved.
  void delete_last() {
    if (size == 0) return;  // 길이가 0이면 처리 종료

    // 마지막 노드를 가져와서
    // 마지막 노드의 이전 노드를 현재 배열의 마지막으로 지정
    ArrayNode *last = this->ptr_tail;
    this->ptr_tail = last->prev;
    // 마지막 노드 제거
    delete last;
    // 길이 1 감소
    this->size--;
  }

  // 배열 안의 정수를 출력하는 print() 등을 가진다.
  void print() {
    cout << "[" << this->size << "] ";

    // 배열 시작점을 데이터를 가져올 대상으로 지정
    ArrayNode *ptr = this->ptr;
    // 더 이상 가져올 대상이 없을 때까지 처리 반복
    while (ptr != NULL) {
      // 데이터를 가져올 대상의 값 출력
      cout << ptr->value << " ";
      // 데이터를 가져올 대상, 다음으로 지정
      ptr = ptr->next;
    }
    cout << endl;
  }
};

int main() {
  MyArray arr = MyArray();
  arr.append(1);
  arr.append(2);
  arr.append(3);
  arr.print();
  arr.delete_last();
  arr.print();
  return 0;
}
```
#image("./assets/10.png")
#pagebreak()

#text(size: 1.5em)[\#11] `Product`라는 이름의 클래스를 작성하여 보자 ...
```cpp
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
```
#image("./assets/11.png")
