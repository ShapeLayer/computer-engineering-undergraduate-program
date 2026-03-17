#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

struct user {
  string name;
  int age;
  string birth_date;
  string birth_place;
} typedef user_t;

bool compare(const user_t& a, const user_t& b) {
  return a.age < b.age;
}

int main() {
  int N;
  cin >> N;
  vector<user_t> registered;

  string name, birth_place, birth_date;
  int age;
  for (int i = 0; i < N; i++) {
    cin >> name >> age >> birth_date >> birth_place;
    registered.push_back(user_t{name, age, birth_date, birth_place});
  }
  sort(registered.begin(), registered.end(), compare);
  for (const auto& user : registered) {
    cout << user.name << ' ' << user.age << ' ' << user.birth_date << ' ' << user.birth_place << endl;
  }

  return 0;
}
