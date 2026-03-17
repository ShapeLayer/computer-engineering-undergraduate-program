#include <iostream>
#include <vector>
#include <string>

using namespace std;

int main()
{
  int N, M;
  cin >> N >> M;
  vector<string> names(N);
  for (int i = 0; i < N; i++)
  {
    cin >> names[i];
  }
  int index = (M - 1) % N;
  cout << names[index] << endl;
  return 0;
}
