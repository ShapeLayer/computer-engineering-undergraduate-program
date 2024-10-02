#include "bits/stdc++.h"

using namespace std;

class Car {
private:
  const int serial_number;
public:
  Car(int s) : serial_number(s) {  // `serial_number(s)`: 생성과 동시에 할당 (= const int serial_number = s)
    // serial_number = s;
    // 생성 이후에 수정해야 하므로 const 키워드가 달려있으면 오류 발생
  }
  void print() {
    cout << serial_number << endl;
  }
};

int main() {
  return 0;
}
