#include <iostream>
using namespace std;

int main() {
  int N;
  cin >> N;

  string name, birth_place, birth_date;
  int age;
  for (int i = 0; i < N; i++) {
    cin >> name >> age >> birth_date >> birth_place;
    cout << "User{" << endl
         << "nickname : " << name << endl
         << "old : " << age << endl
         << "birth : " << birth_date << endl
         << "state : " << birth_place << endl
         << "}" << endl;
  }

  return 0;
}
