#include <iostream>
#include <string>

using namespace std;

class Car {
public:
  int gear;
  string color;

  Car() {
    this->gear = 10;
  }
  
  void speedUp() {
    this->speed++;
  }
  void speedDown() {
    this->speed--;
  }
private:
  int speed;
};

int main() {
  Car myCar;

  // myCar.speed = 10;
  myCar.gear = 3;
  myCar.color = "red";

  myCar.speedUp();
  myCar.speedDown();
  return 0;
}
