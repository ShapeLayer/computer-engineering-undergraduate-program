#include<iostream>
#include<string>
using namespace std;

class Node {
public:
  string name;
  Node* next;
};

Node* field_head;    //先頭ノードのアドレス
Node* field_tail;    //末尾ノードのアドレス
Node* field_current;  //現在ノードのアドレス
Node* field_tmp;    //暫定ノードのアドレス


void Initialize() {
  field_head = new Node();    //最初に作る先頭ノード
  field_current = field_head;  //現在ノードのアドレス  

  field_current->name = "1.アミューズ";
  field_current->next = new Node();
  field_current = field_current->next;

  field_current->name = "2.オードブル";
  field_current->next = new Node();
  field_current = field_current->next;

  field_current->name = "3.スープ";
  field_current->next = new Node();
  field_current = field_current->next;

  field_current->name = "4.ポワソン";
  field_current->next = new Node();
  field_current = field_current->next;

  field_current->name = "5.ソルベ";
  field_current->next = new Node();
  field_current = field_current->next;

  field_current->name = "6.アントレ";
  field_current->next = new Node();
  field_current = field_current->next;

  field_current->name = "7.デセール";
  field_current->next = new Node();
  field_current = field_current->next;

  field_current->name = "8.カフェ・ブティフール";
  field_current->next = new Node();
  field_current = field_current->next;

  field_current->name = "dummy";
  field_current->next = NULL;

  field_tail = field_current;
}


void Display() {
  field_current = field_head;  //現在ノードのアドレス  
  while (field_current->name != "dummy") {
    cout << field_current->name << endl;
    field_current = field_current->next;
  }
  cout << endl;
}


void Delete() {
  int num;
  cout << "何番目のメニューを削除しますか？(1～8)" << endl;
  cin >> num;

  /*変更可能ここから*/

  Node *entry = new Node();
  auto __targeted_prev = entry;
  __targeted_prev->next = field_head;
  auto __targeted = field_head;
  for (int i = 0; i < num - 1; i++) {
    __targeted_prev = __targeted;
    __targeted = __targeted->next;
  }

  __targeted_prev->next = __targeted->next;
  delete __targeted;

  field_head = entry;
  /*変更可能ここまで*/
}

int main() {
  Initialize();
  Display();
  Delete();
  Display();
}
