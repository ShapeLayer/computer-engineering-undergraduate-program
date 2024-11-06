#include "bits/stdc++.h"

using namespace std;

class Vector2 {
private:
  double x, y;
public:
  Vector2(double xval = .0, double yval = .0) : x(xval), y(yval) {}
  
  void display() {
    cout << "(" << x << ", " << y << ")";
  }

  Vector2 operator+(Vector2 &v2) {
    Vector2 v;
    v.x = this->x + v2.x;
    v.y = this->y + v2.y;
    return v;
  }
};

int main() {
  Vector2 v1(1., 2.), v2(3., 4.);
  Vector2 v3 = v1 + v2;
  v3.display();
}
