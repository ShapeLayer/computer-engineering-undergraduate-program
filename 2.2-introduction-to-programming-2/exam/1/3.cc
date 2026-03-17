#include "bits/stdc++.h"
#define MSG_IN "任意の文字を入力してください（0で終了）"
#define MSG_O "対応した閉じ括弧です"
#define MSG_X "対応していない閉じ括弧です"
#define MSG_EXIT "0が入力されたので終了します"
using namespace std;

inline bool __eval_closer_matched(deque<char> *, char);

int main() {
  ios_base::sync_with_stdio(false);
  cin.tie(nullptr);
  cout.tie(nullptr);

  /**
   * 괄호 입력: (, ), {, }, [, ]
   * 0 : exit
   * 여는 괄호: 푸시
   * 닫는 괄호: 스택 확인 후
   *  대응됨: 対応した閉じ括弧です
   *  대응안됨: 対応していない閉じ括弧です
   */

  string get;
  deque<char> s;
  cout << MSG_IN << endl;
  while (true) {
    cin >> get;
    if (get[0] == '0') {
      cout << MSG_EXIT << endl;
      return 0;
    }
    
    for (auto each : get) {
      switch (each) {
        case '(':
        case '{':
        case '[':
          s.push_back(each);
          break;
        case ')':
        case '}':
        case ']':
          if (s.empty()) {
            cout << MSG_X << endl;
            break;
          }
          if (__eval_closer_matched(&s, each)) {
            s.pop_back();
            cout << MSG_O << endl;
          } else {
            // ????
            s.pop_back();
            cout << MSG_X << endl;
          }
          break;
      }
    }
  }

  return 0;
}

inline bool __eval_closer_matched(deque<char> *s, char chr) {
  bool evaluated;
  switch (chr) {
    case ')':
      return evaluated = s->back() == '(';
    case '}':
      return evaluated = s->back() == '{';
    case ']':
      return evaluated = s->back() == '[';
  }
  return false;
}
