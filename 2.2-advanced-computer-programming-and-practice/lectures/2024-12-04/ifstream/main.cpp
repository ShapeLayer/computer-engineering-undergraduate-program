#include "bits/stdc++.h"
using namespace std;

int main() {
  ifstream fin;
  fin.open("in.in");

  if (!fin) {
    cout << "Error opening file" << endl;
    return 1;
  }

  char c;
  fin.get(c);
  while (!fin.eof()) {
    cout << c;
    fin.get(c);
  }

  fin.close();
  return 0;
}
