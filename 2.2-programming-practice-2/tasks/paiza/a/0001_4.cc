#include <bits/stdc++.h>

using namespace std;

int main()
{
  int N;
  cin >> N;
  vector<pair<int, string>> students;
  for (int i = 0; i < N; i++)
  {
    int height;
    string name;
    cin >> height >> name;
    students.push_back({height, name});
  }
  sort(students.rbegin(), students.rend()); // 降順ソート
  for (auto &p : students)
  {
    cout << p.second << endl;
  }
  return 0;
}
