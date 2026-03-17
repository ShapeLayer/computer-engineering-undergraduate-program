#include <iostream>
#include <vector>
using namespace std;

int N;
string oper;

class registered {
  string name;
  int num;
  public:
    void setName(string n) {
      name = n;
    }
    void setNum(int m) {
      num = m;
    }
    string getName() {
      return name;
    }
    int getNum() {
      return num;
    }
    registered(string name, int num) : name(name), num(num) {}
};

int main() {
  cin >> N;

  vector<registered *> regs;

  while (N--) {
    cin >> oper;

    if (oper == "make") {
      string name;
      int num;
      cin >> num >> name;
      registered *r = new registered(name, num);
      regs.push_back(r);
    } else {
      int idx;
      cin >> idx;
      if (oper == "getnum") {
        cout << regs[idx - 1]->getNum() << endl;
      } else if (oper == "getname") {
        cout << regs[idx - 1]->getName() << endl;
      } else if (oper == "change_num") {
        int newnum;
        cin >> newnum;
        regs[idx - 1]->setNum(newnum);
      } else if (oper == "change_name") {
        string newname;
        cin >> newname;
        regs[idx - 1]->setName(newname);
      }
    }
  }
  return 0;
}
