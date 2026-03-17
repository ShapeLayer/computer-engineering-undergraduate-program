#include <iostream>
using namespace std;

int main() {
  int N;
  cin >> N;

  if (N < 2) {
    cout << "clear" << endl;
  } else if (N < 9) {
    cout << "sunny" << endl;
  } else {
    cout << "cloudy" << endl;
  }

  return 0;
}
