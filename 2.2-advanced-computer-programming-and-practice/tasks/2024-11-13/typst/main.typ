#import "@preview/codly:0.2.0": *
#show: codly-init.with()
#codly(languages: (
  py: (name: "Python", icon: "", color: rgb("#3572A5")),
  cpp: (name: "C++", icon: "", color: rgb("#f34b7d")),
  sh: (name: "Shell", icon: "", color: rgb("#58c623"))
))


#set page(
  margin: (x: 3em, y: 4em)
)
#set text(font: ("Noto Sans CJK KR", "Noto Sans KR"), size: .9em)

#align(center)[
  #text(size: 2em)[고급프로그래밍및실습 과제 \#5 (10주차)]\
  
  214823 박종현
]

1. `++`, `--`
2. `+`, `-`, `*`, `/`
3. `=`, `()`, `[]`
4. `==`, `!=`
5. `<<`, `>>`
6. `*`, `->`

- 각자 최소 1개 씩 오버로딩

== 답안
```cpp
#include "bits/stdc++.h"
#define ERR_MESSAGE_INDEX_OUT_OF_RANGE "Index out of range"

using namespace std;

class Vector2 {
  friend ostream& operator<<(ostream &os, const Vector2 &v) {
    os << "Vector2D" << v.to_string();
    return os;
  }
  friend istream& operator>>(istream &is, Vector2 &v) {
    is >> v._x >> v._y;
    return is;
  }
private:
  double _x, _y;
public:
  Vector2(double x = 0., double y = 0.) : _x(x), _y(y) {}

  inline int x() const { return _x; }
  inline int y() const { return _y; }
  inline void x(int x) { _x = x; }
  inline void y(int y) { _y = y; }

  string to_string() const {
    return "(" + std::to_string(x()) + ", " + std::to_string(y()) + ")";
  }

  Vector2 operator+(const Vector2 &other) const {
    Vector2 v;
    v.x(this->x() + other.x());
    v.y(this->y() + other.y());
    return v;
  }

  Vector2 operator-(const Vector2 &other) const {
    Vector2 v;
    v.x(this->x() - other.x());
    v.y(this->y() - other.y());
    return v;
  }

  Vector2 operator*(double scalar) const {
    Vector2 v;
    v.x(this->x() * scalar);
    v.y(this->y() * scalar);
    return v;
  }

  Vector2 operator*(const Vector2 &other) const {
    Vector2 v;
    v.x(this->x() * other.x());
    v.y(this->y() * other.y());
    return v;
  }

  Vector2 operator/(const Vector2 &other) const {
    Vector2 v;
    v.x(this->x() / other.x());
    v.y(this->y() / other.y());
    return v;
  }

  Vector2 operator==(const Vector2 &other) const {
    return this->x() == other.x() && this->y() == other.y();
  }

  Vector2 operator!=(const Vector2 &other) const {
    return this->x() != other.x() || this->y() != other.y();
  }

  Vector2 operator+=(const Vector2 &other) {
    this->x(this->x() + other.x());
    this->y(this->y() + other.y());
    return *this;
  }

  Vector2 operator-=(const Vector2 &other) {
    this->x(this->x() - other.x());
    this->y(this->y() - other.y());
    return *this;
  }

  Vector2 operator*=(const Vector2 &other) {
    this->x(this->x() * other.x());
    this->y(this->y() * other.y());
    return *this;
  }

  Vector2 operator/=(const Vector2 &other) {
    this->x(this->x() / other.x());
    this->y(this->y() / other.y());
    return *this;
  }

  Vector2 operator++() {
    this->x(this->x() + 1);
    this->y(this->y() + 1);
    return *this;
  }

  Vector2 operator++(int) {
    this->x(this->x() + 1);
    this->y(this->y() + 1);
    return *this;
  }


  Vector2 operator--() {
    this->x(this->x() - 1);
    this->y(this->y() - 1);
    return *this;
  }

  Vector2 operator--(int) {
    this->x(this->x() - 1);
    this->y(this->y() - 1);
    return *this;
  }

  Vector2& operator=(const Vector2 &other) {
    if (this != &other) {
      this->x(other.x());
      this->y(other.y());
    }
    return *this;
  }

  double& operator[](int index) {
    if (index == 0) {
      return _x;
    } else if (index == 1) {
      return _y;
    } else {
      throw std::out_of_range(ERR_MESSAGE_INDEX_OUT_OF_RANGE);
    }
  }

  Vector2* operator->() {
    return this;
  }

  const Vector2& operator*() const {
    return *this;
  }
};


// Usage Examples
int main() {
  Vector2 v1(1., 2.), v2(3., 4.);
  Vector2 v3 = v1 + v2;
  Vector2 v4 = v1 - v2;
  Vector2 v5 = v1 * v2;
  Vector2 v6 = v1 / v2;

  cout << "v1: " << v1 << endl;
  cout << "v2: " << v2 << endl;
  cout << "v3: " << v3 << endl;
  cout << "v4: " << v4 << endl;
  cout << "v5: " << v5 << endl;
  cout << "v6: " << v6 << endl;

  cout << endl;

  v3 = v2 * 3.;
  cout << "v3: " << v3 << endl;
  v5 += v3;
  cout << "v5: " << v5 << endl;
  v2 -= v1;
  cout << "v2: " << v2 << endl;
  v4 *= v2;
  cout << "v4: " << v4 << endl;
  v1 /= v2;
  cout << "v1: " << v1 << endl;
  ++v1++;
  cout << "v1: " << v1 << endl;
  --v1--;
  cout << "v1: " << v1 << endl;

  cout << endl;
  cout << "input and enter: ";
  cin >> v1;
  cout << "inputed: " << v1 << endl;

  cout << "v1.x: " << v1[0] << endl;
  cout << "v2.y: " << v2[1] << endl;

  cout << (&v1)->to_string() << endl;
  return 0;
}

```
\
== 실행 결과
#align(center)[#image("assets/out.png", width: 60%)]
