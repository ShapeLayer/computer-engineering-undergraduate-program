#include "bits/stdc++.h"

class NoPersonException {
private:
  int persons;
public:
  NoPersonException();
  NoPersonException(int p) { persons = p; }
  int get_persons() { return persons; }
};

int main() {
  int pizza_slices = 12;
  int persons = -1;
  int slices_per_person = 0;


  cout << "피자 조각 수를 입력하시오: ";
  cin >> pizza_slices;
  cout << "사람 수를 입력하시오: ";
  cin >> persons;
  try {
    if (persons <= 0) {
      throw NoPersonException(persons);
    }
  } catch (NoPersonException e) {
    cout << "사람 수가 " << e.get_persons() << "명입니다. 사람 수를 다시 입력하세요." << endl;
    return 1;
  }
  slices_per_person = pizza_slices / persons;
  cout << "한 사람당 피자 조각 수: " << slices_per_person << endl;
  return 0;
}
