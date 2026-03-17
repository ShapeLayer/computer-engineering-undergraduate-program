#include <iostream>

using namespace std;

int main()
{
  int N, M;
  cin >> N >> M;
  int count = 0;
  for (int i = 0; i < N; i++)
  {
    int A;
    cin >> A;
    if (A <= M)
      count++;
  }
  cout << count << endl;
  return 0;
}
