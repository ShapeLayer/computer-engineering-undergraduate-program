#include <bits/stdc++.h>

using namespace std;

int main()
{
  string S, T;
  cin >> S >> T;
  if (S.back() == T.front())
  {
    cout << "YES" << endl;
  }
  else
  {
    cout << "NO" << endl;
  }
  return 0;
}
