#include "bits/stdc++.h"

using namespace std;

class Student {
  char *name;
  int number;
public:
  Student(char *p, int n) {
    cout << "메모리 할당" << endl;
    name = new char[strlen(p) + 1];
    strcpy(name, p);
    number = n;
  }
  ~Student() {
    cout << "메모리 소멸" << endl;
    delete[] name;
  }
};

int main() {
  Student s1("Park", 200101010);
  Student s2(s1);  // Double free error

  return 0;
}
