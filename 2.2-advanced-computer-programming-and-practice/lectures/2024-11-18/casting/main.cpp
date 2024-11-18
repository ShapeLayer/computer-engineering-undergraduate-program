#include "bits/stdc++.h"

class Car {};
class Bus : public Car {};

class Box {};

int __entrypoint_1() {
  Bus* pBus1 = new Bus();
  Car* pCar2 = static_cast<Car*>(pBus1);
  Car* dynPCar2 = dynamic_cast<Car*>(pBus1);
  Car* pCar3 = (Car*)pBus1;

  Car* pCar1 = new Car();
  Bus* pBus2 = static_cast<Bus*>(pCar1);
  #if false
  // 런타임 dynamic_cast의 피연산자는 다형 클래스 형식이어야 합니다.C/C++(698)
  // dynamic_cast는 다형 클래스 형식에서만 사용할 수 있습니다. 이 형식은 가상 함수를 포함하는 클래스이거나, 다형 클래스의 하위 클래스여야 합니다.
  // 
  // 가상함수: 부모 클래스의 포인터로 자식 클래스의 객체를 가리킬 때, 부모 클래스의 포인터로 자식 클래스의 멤버 함수를 호출할 수 있도록 하는 것
  // 가상함수의 선언: virtual 반환형 함수이름(매개변수);
  // 이와 같이 수행하면 vtable에 가상함수의 주소가 저장되어, 가상함수를 호출할 때 vtable을 참조하여 호출할 함수의 주소를 찾아 호출한다.
  // 가상함수의 선언이 없으면, 부모 클래스의 포인터로 자식 클래스의 객체를 가리킬 때, 부모 클래스의 멤버 함수만 호출할 수 있다.
  // 따라서, dynamic_cast를 사용할 때는 반드시 가상함수를 사용해야 한다.

  Bus* dynPBus2 = dynamic_cast<Bus*>(pCar1);
  #endif

  return 0;
}

int __entrypoint_2() {
  char* pc;
  // reinterpret_cast는 포인터 타입 간의 단순 형변환을 허용한다.
  pc = reinterpret_cast<char*>(0x10000ef);

  Car* pCar1 = new Car();
  Box* pBox1 = reinterpret_cast<Box*>(pCar1);

  // const_cast는 const 한정자를 제거하는 캐스트 연산자이다.
  const Car* pCar2 = new Car();
  Car* pCar3 = const_cast<Car*>(pCar1);
  return 0;
}

int main() {
  __entrypoint_1();
  __entrypoint_2();
  return 0;
}
