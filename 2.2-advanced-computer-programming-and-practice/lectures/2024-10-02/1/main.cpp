#include "bits/stdc++.h"

using namespace std;

class Car{
private:
  int speed;
  int gear;
  char *color;
public:
  Car();
  Car(int s, int g, char *c);
  ~Car();
};

Car::Car() {
  cout << "default" << endl;
  speed = 0;
  gear = 1;
  color = new char[20];
  strcpy(color, "white");
}
Car::Car(int speed, int gear, char *c) {
  cout << "argument" << endl;
  speed = speed;
  gear = gear;
  color = new char[20];
  strcpy(color, c);
}
Car::~Car() {
  cout << "destructor" << endl;
  delete[] color;
}

int main() {
  Car c1;
  Car c2(-1, -1, "w");
  return 0;
}
