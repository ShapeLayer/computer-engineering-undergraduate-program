#include "bits/stdc++.h"
using namespace std;

template <typename T>
class StackNode {
public:
  T value;
  StackNode<T> *next;
  StackNode(T value) {
    this->value = value;
    this->next;
  }
  StackNode(T value, StackNode<T> *next) {
    this->value = value;
    this->next = next;
  }
};

template <typename T>
class Stack {
private:
  StackNode<T> *top;
  int size;
public:
  /// @brief 스택이 비어있는지 확인하는 함수
  /// @return bool
  bool is_empty() {
    return top == nullptr;
  }

  /// @brief 스택이 꽉 찼는지 확인하는 함수
  /// @return 항상 false를 반환 (연결된 형태로 구현하였기 때문에 제한이 없음)
  bool is_full() { return false; }

  /// @brief 스택에 값을 넣는 함수
  /// @param value 
  void push(T value) {
    StackNode<T> *new_node = new StackNode<T>(value, top);
    top = new_node;
  }

  /// @brief 스택에서 값을 pop하는 함수
  /// @return T 타입(top->value)
  T pop() {
    T _return = top->value;
    top = top->next;
    return _return;
  }
};

// 교과서 상의 함수 정의 구현

/// @brief Stack.is_empty()의 래퍼입니다. 교과서 상 요구 사항을 구현하기 위해 선언되었습니다.
/// @tparam T 
/// @param s 
/// @return is_empty
template <typename T>
bool is_empty(Stack<T> *s) {
  return s->is_empty();
}

/// @brief Stack.is_full()의 래퍼입니다. 교과서 상 요구 사항을 구현하기 위해 선언되었습니다.
/// @tparam T 
/// @param s 
/// @return false
template <typename T>
bool is_full(Stack<T> *s) {
  return s->is_full();
}

/// @brief Stack.push()의 래퍼입니다. 교과서 상 요구 사항을 구현하기 위해 선언되었습니다.
/// @tparam T 
/// @param s 
/// @param value 
template <typename T>
void push(Stack<T> *s, T value) {
  s->push(value);
}

/// @brief Stack.pop()의 래퍼입니다. 교과서 상 요구 사항을 구현하기 위해 선언되었습니다.
/// @tparam T 
/// @param s 
/// @return Stack.pop()의 결과
template <typename T>
T pop(Stack<T> *s) {
  return s->pop();
}

int main() {
  Stack<int> stack;

  // 스택 메서드 사용
  stack.push(1);
  stack.push(2);
  stack.push(3);
  cout << stack.pop() << endl;
  cout << stack.pop() << endl;
  cout << stack.pop() << endl;

  // 래퍼 함수 사용
  push<int>(&stack, 4);
  push<int>(&stack, 5);
  push<int>(&stack, 6);
  cout << pop<int>(&stack) << endl;
  cout << pop<int>(&stack) << endl;
  cout << pop<int>(&stack) << endl;

  return 0;
}
