#include "bits/stdc++.h"

using namespace std;

class Dog {
private:
  string name;
  int age;
public:
  string breed;
  string get_name();
  int get_age();
  Dog(string name, int age = 0) {
    this->name = name;
    this->age = age;
  }
  Dog(string name, string breed, int age = 0) {
    this->name = name;
    this->breed = breed;
    this->age = age;
  }
};

string Dog::get_name() {
  return this->name;
}

int Dog::get_age() {
  return this->age;
}

int main() {
  Dog dog0 = Dog("name");
  Dog dog1 = Dog("name", -1);
  Dog dog2 = Dog("name", "breed");
  Dog dog3 = Dog("name", "breed__", -1);
  cout << dog0.get_name() << " " << dog0.get_age() << " " << dog0.breed << endl;
  cout << dog1.get_name() << " " << dog1.get_age() << " " << dog1.breed << endl;
  cout << dog2.get_name() << " " << dog2.get_age() << " " << dog2.breed << endl;
  cout << dog3.get_name() << " " << dog3.get_age() << " " << dog3.breed << endl;
}
