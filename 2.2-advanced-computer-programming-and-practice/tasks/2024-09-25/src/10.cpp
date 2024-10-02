#include <iostream>

using namespace std;

struct ArrayNode;
struct MyArray;

struct ArrayNode {
  /**
   * `ArrayNode` is data container for `MyArray` class to implement
   * linkedlist-like array with dynamic allocation.
   */
private:
  /**
   * `*_p` indicates `MyArray` that uses this as data container.
   * `_*p` is declared because it may be useful later, but this 
   */
  MyArray *_p;
public:
  int value;
  ArrayNode *next = NULL;
  ArrayNode *prev = NULL;
  ArrayNode(MyArray *p, ArrayNode *prev, int e) {
    this->_p = p;
    this->prev = prev;
    this->value = e;
  }
  void setNext(ArrayNode *node) {
    this->next = node;
  }
};

struct MyArray {
private:
  // 멤버 변수로는 배열의 크기를 나타내는 size와
  int size = 0;

  // 정수들이 실제로 저장된 메모리를 가리키는 `ptr`을 가진다.
  ArrayNode *ptr = NULL;  // Head
  ArrayNode *ptr_tail = NULL;  // Tail

public:
  // `size` is encapsulized: This `getSize()` is getter.
  int get_size() { return this->size; }

  // 멤버 함수로는 정수를 추가하는 append()
  void append(int e) {
    ArrayNode *last = this->ptr_tail;
    // 새 노드 생성
    ArrayNode *_new = new ArrayNode(this, last, e);
    // 마지막 노드가 null이라면 빈 리스트인 것
    if (last == NULL)
      this->ptr = _new;  // 이 경우 시작 노드를 새로 생성한 노드로 지정
    else
      last->next = _new;  // 빈 리스트가 아니라면 마지막 노드의 다음 노드를 새로 생성한 노드로 지정
    // 마지막 노드 수정
    this->ptr_tail = _new;
    // 배열 크기 증가
    this->size++;
  }

  // 마지막 정수를 삭제하는 delete()
  // delete() is reserved.
  void delete_last() {
    if (size == 0) return;  // 길이가 0이면 처리 종료

    // 마지막 노드를 가져와서
    // 마지막 노드의 이전 노드를 현재 배열의 마지막으로 지정
    ArrayNode *last = this->ptr_tail;
    this->ptr_tail = last->prev;
    // 마지막 노드 제거
    delete last;
    // 길이 1 감소
    this->size--;
  }

  // 배열 안의 정수를 출력하는 print() 등을 가진다.
  void print() {
    cout << "[" << this->size << "] ";

    // 배열 시작점을 데이터를 가져올 대상으로 지정
    ArrayNode *ptr = this->ptr;
    // 더 이상 가져올 대상이 없을 때까지 처리 반복
    while (ptr != NULL) {
      // 데이터를 가져올 대상의 값 출력
      cout << ptr->value << " ";
      // 데이터를 가져올 대상, 다음으로 지정
      ptr = ptr->next;
    }
    cout << endl;
  }
};

int main() {
  MyArray arr = MyArray();
  arr.append(1);
  arr.append(2);
  arr.append(3);
  arr.print();
  arr.delete_last();
  arr.print();
  return 0;
}
