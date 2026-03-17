#include <iostream>

using namespace std;

int main()
{
  int A, B;
  cin >> A >> B;
  if (A > B)
  {
    cout << 1 << endl;
  }
  else if (A == B)
  {
    cout << 0 << endl;
  }
  else
  {
    cout << -1 << endl;
  }
  return 0;
}
