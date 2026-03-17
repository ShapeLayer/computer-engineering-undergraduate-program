#include <iostream>
using namespace std;

#define END 'E'    // 終了
#define INSERT 'I' // 追加
#define DELETE 'D' // 削除

void initList(void);                    // リストを初期化
void showList(void);                    // リストを表示
void insertNode(int number, int value); // ノードを挿入
void deleteNode(int number);            // ノードを削除

class Node
{ // リストノードの定義
public:
  int value;  // ノードの値
  Node *next; // 次ノードを参照するポインタ
};

Node *head = NULL; // リストの先頭ノードを参照するポインタ
Node *tail = NULL; // リストの末尾ノードを参照するポインタ

int main()
{
  char command; // 操作命令番号
  int number;   // ノード番号
  int value;    // ノード値

  initList();     // リストを初期化する
  cin >> command; // 操作命令を受け取り

  while (command != END)
  { // 操作命令が終了でない限り以下を繰り返し
    switch (command)
    {                            // 命令によって分岐
    case INSERT:                 // 挿入
      cin >> number;             // 挿入する位置(負/0は先頭、正はその番号ノードの後)
      cin >> value;              // 挿入する値(整数)
      insertNode(number, value); // リストに入力値を挿入
      break;
    case DELETE:          // 削除
      cin >> number;      // 削除するノード番号
      deleteNode(number); // ノードを削除
      break;
    default: // それ以外はエラー
      cout << "error" << endl;
      break;
    }
    showList();     // リストを表示
    cin >> command; // 次の操作命令を受け取り
  }
}

/* リストを初期化する */
void initList(void)
{
  // ダミーノードを作成し，先頭ノードを参照するポインタhead（以下，先頭ポインタ）と
  // 末尾ノードを参照するポインタtail（以下、末尾ポインタ）につなぐ
  head = tail = new Node();
  // ダミーノードの内容を設定する
  tail->value = 0;
  tail->next = NULL;
}

/* リストを表示する */
void showList(void)
{
  cout << "--------------" << endl;
  // 先頭ノードから始めて末尾ノードでない間，以下を繰り返す
  Node *p = head;
  int number = 1;
  while (p != tail)
  {
    cout << number << ":" << p->value << endl; // 現ノードの番号と値を表示
    p = p->next;                               // 次のノードへ移動
    number++;
  }
  cout << "--------------" << endl << endl;
}

/*****************************************************
値valueを持つノードをnumber番目のノードの次に挿入する
numberが負またはゼロの時は先頭の前に挿入する
numberが末尾より先の時は末尾に挿入する
**************+**************************************/
void insertNode(int number, int value)
{
  // 新たなノードの領域を確保し，ポインタpNewにつなぐ
  Node *pNew = new Node();
  // 新ノードに値を入れる
  pNew->value = value;
  pNew->next = NULL;

  // 指定ノード番号numberが負またはゼロの時，またはリストが空の時は以下を実行
  if ((number <= 0) || head == tail)
  {
    // 先頭ポインタheadが参照するノードの前に新ノードを挿入
    pNew->next = head;
    head = pNew;
  }
  else
  { // それ以外の時は以下を実行
    // 先頭からnumber-1ノード分先を探し現ノードとする
    // （ポインタpの参照先を先頭ノードから開始して次ノードへnumber-1回移動する）
    Node *p = head;
    for (int i = 1; i < number; i++)
    {
      // 次ノードが末尾のダミーノードならループを抜ける
      if (p->next == tail)
      {
        break;
      }
      // 次ノードを現ノードにする
      p = p->next;
    }
    // ポインタpの参照するノードの次に新ノードを挿入
    pNew->next = p->next;
    p->next = pNew;
  }
}

/****************************************************
number番目のノードを削除する
number番目のノードがない時は何もしない
******************************************+*********/
void deleteNode(int number)
{
  // 番号が負またはゼロなら削除対象ノードがないので戻る
  if (number <= 0)
  {
    return;
  }

  // リストが空なら削除対象ノードがないので戻る
  if (head == tail)
  {
    return;
  }

  // 先頭から(number-1)ノード分先を探し現ノードとする
  // （ポインタpの参照先を先頭ノードから開始して次ノードへnumber-1回移動する）
  Node *p = head;
  for (int i = 1; i < number; i++)
  {
    // 次ノードが末尾のダミーノードなら削除対象ノードがないので戻る
    if (p->next == tail)
    {
      return;
    }
    // 次ノードを現ノードとする
    p = p->next;
  }

  /***********************************************
  以下に，ポインタpが参照するノード（現ノード）を削除するコードを追加する．
  ただし，削除のためのリンク変更には直前ノードを参照するポインタが必要なので，
  ここでは，次ノードの内容を現ノードにコピーして，次ノードを削除する方法を取る．
  ************************+**********************/
  // 次ノードを参照するポインタpNextを作る．
  Node *pNext = p->next;
  // 次ノードの内容（valueとnext）を現ノードへコピーする．
  // この際，次ノードが末尾のダミーノードならば，末尾ポインタが現ノードを参照するように設定する．
  
  if (p->next == tail)
  {
    tail = p;
  }
  p->value = pNext->value;
  p->next = pNext->next;

  // 次ノードを削除する．
  delete pNext;
}
