#include <iostream>
#include <map>
#include <vector>
using namespace std;

struct user {
  string name;
  int age;
  string birth_date;
  string birth_place;
} typedef user_t;

int main() {
  int N;
  cin >> N;
  map<int, vector<string>> registered;

  string name, birth_place, birth_date;
  int age;
  for (int i = 0; i < N; i++) {
    cin >> name >> age >> birth_date >> birth_place;
    if (registered.find(age) == registered.end()) {
      registered[age] = vector<string>();
    }
    registered[age].push_back(name);
  }
  
  int K;
  cin >> K;
  if (registered.find(K) != registered.end()) {
    for (const auto& n : registered[K]) {
      cout << n;
    }
  }
  cout << endl;

  return 0;
}
