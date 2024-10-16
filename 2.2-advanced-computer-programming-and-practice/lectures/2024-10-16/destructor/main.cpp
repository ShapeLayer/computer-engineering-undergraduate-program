#include "bits/stdc++.h"

class Foo {
public:
  char* var;
  Foo(int len) {
    var = new char[len];
  }
  Foo (Foo *foo) {
    this->var = new char(strlen(foo->var));
    strcpy(this->var, foo->var);
  }
};

int main() {
  Foo foo0 = new Foo(10);
  foo0.var = "asdf";
  Foo foo1 = new Foo(foo0);
  cout << foo0.var << endl;
  cout << foo1.var << endl;
  return 0;
}
