#include "bits/stdc++.h"
using namespace std;

class Student {
public:
  string name;
  string phone;
  Student(string name, string phone): name(name), phone(phone) {}
};

class Lab {
public:
  string name;
  Student *chief;
  Student *manager;
  Lab(string name): name(name) {
    this->name = name;
  };
  void setChief(Student *p) {
    this->chief = p;
  }

  void setManager(Student *p) {
    this->manager = p;
  }

  void print() {
    cout << this->name << endl;
    cout << "chief " << this->chief->name << "; " << this->chief->phone << endl;
    cout << "manager " << this->manager->name << "; " << this->manager->phone << endl;
  }
};

int main() {
  Lab lab("영상처리");
  Student *p = new Student("김철수", "011-1234-5678");

  lab.setChief(p);
  lab.setManager(p);
  lab.print();

  delete p;
  return 0;
}
