#include <iostream>
#include <string>
#include <vector>

using namespace std;

int main() {
  int n;
  cin >> n;
  cout << "New Awesome " << n << " App" << endl;

  string name;
  cin >> name;
  cout << name << endl;

  vector<int> vec;
  int gets;
  for (int i = 0; i < n; i++) {
    cin >> gets;
    vec.push_back(gets);
  }
  for (int i = 0; i < n; i++) {
    cout << vec[i] << endl;
  }

  return 0;
}
