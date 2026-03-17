#include "bits/stdc++.h"
using namespace std;

#define _FAILURE(MSG) { \
  cout << MSG << endl; \
  return 1; \
}
#define _FAILURE_TYPE_MISMATCH _FAILURE("開き括弧と閉じ括弧の型が不一致です")
#define _FAILURE_LESS_OPENING  _FAILURE("開き括弧が不足しています")
#define _FAILURE_LESS_CLOSING  _FAILURE("閉じ括弧不足です")
#define _SUCCESS { \
  cout << "括弧の対応が取れています" << endl; \
  return 0; \
}

int main() {
  ios::sync_with_stdio(false);
  cin.tie(nullptr);
  cout.tie(nullptr);

  string get;
  cin >> get;

  stack<char> s;

  for (char each : get) {
    switch (each) {
    case '(':
    case '{':
    case '[':
      s.push(each);
      break;
    case ')':
    case '}':
    case ']':
      if (s.empty()) _FAILURE_LESS_OPENING;

      char top = s.top();
      s.pop();
      
      if ((each == ')' && top != '(') ||
          (each == '}' && top != '{') ||
          (each == ']' && top != '[')) {
        _FAILURE_TYPE_MISMATCH;
      }
      break;

    }
  }

  if (!s.empty()) _FAILURE_LESS_CLOSING;

  _SUCCESS;

  return 0;
}
