#include <iostream>

using namespace std;

int main()
{
  int N, M;
  cin >> N >> M;

  int sum = 0;
  for (int i = 0; i < N; i++)
  {
    int A;
    cin >> A;
    sum += A;
  }

  if (sum <= M)
  {
    cout << "OK" << endl;
  }
  else
  {
    cout << "NG" << endl;
  }

  return 0;
}
