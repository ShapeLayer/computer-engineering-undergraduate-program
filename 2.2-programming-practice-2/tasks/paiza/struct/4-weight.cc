#include <iostream>
#include <vector>
using namespace std;

struct user {
  string name;
  int age;
  string birth_date;
  string birth_place;
} typedef user_t;


int main() {
  int N, K;
  cin >> N >> K;
  vector<user_t> registered;

  string name, birth_place, birth_date;
  int age;
  for (int i = 0; i < N; i++) {
    cin >> name >> age >> birth_date >> birth_place;
    registered.push_back(user_t{name, age, birth_date, birth_place});
  }

  int _i;
  for (int i = 0; i < K; i++) {
    cin >> _i >> name;
    registered[_i - 1].name = name;
  }

  for (const auto& user : registered) {
    cout << user.name << ' ' << user.age << ' ' << user.birth_date << ' ' << user.birth_place << endl;
  }

  return 0;
}
