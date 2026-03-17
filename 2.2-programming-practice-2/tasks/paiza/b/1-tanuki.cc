#include <iostream>
using namespace std;

int main() {
  string str;
  cin >> str;
  for (char c : str) {
    switch (c) {
      case 't':
      case 'a':
        break;
      default:
        cout << c;
        break;
    }
  }
  cout << endl;
  
  return 0;
}
