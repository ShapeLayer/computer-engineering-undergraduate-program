#include <iostream>
#include <string>
using namespace std;

void showList(void);           // リストを表示する
void reorderList(string word); // 探索単語が先頭になるよう並べ替える

class Node
{ // リストノードの定義
public:
  string word; // 登録単語
  Node *next;  // 次のノードを参照するポインタ
};

Node *head = NULL; // 先頭ノードを参照するポインタ(先頭ポインタ)
Node *tail = NULL; // 末尾のセンチネル(番兵)ノードを参照するポインタ(末尾ポインタ)

int main()
{
  string word; // 入力単語

  cin >> word; // 単語を受け取る
  // 「\$\$」が入力されるまで繰り返す
  while (word != "$$")
  {
    // 入力単語の探索をしてリストを並べ替える
    reorderList(word);
    // リストを表示する
    showList();
    // 次の単語を受け取る
    cin >> word;
  }
}

/* リストを表示する */
void showList(void)
{
  // 先頭ノードから始めて末尾ノードで無い間以下を繰り返す
  Node *p = head;
  while (p != tail)
  {
    // 現ノードの単語を表示する
    cout << "[" << p->word << "]";
    // 次ノードへ移動する
    p = p->next;
  }
  cout << endl;
}

/*****************************************
引数の単語があれば先頭になるようにリストを並べ替え，
なければ先頭に追加する
**********************+******************/
void reorderList(string word)
{
  // 1. リストが空ならば，以下を実行する．
  if (head == tail)
  {
    // 1-1. 新ノードの領域を確保して，先頭ポインタにつなぎ，引数で渡された単語を入れる．
    Node *gen = new Node();
    head = gen;
    head->word = word;
    // 1-2. センチネル（番兵）として利用する末尾ノードを作り，末尾ポインタにつなぐ．
    tail = new Node();
    head->next = tail;
    // 1-3. 先頭ノードの次が末尾ノード，その次がNULLとなるようにつなぐ．
    tail->next = NULL;
  }
  else if (word == head->word)
  {
    // 2. それ以外で，引数の単語が先頭ノードの単語と一致するなら，並べ替えも登録も不要なので何もしない．
  }
  else
  {
    // 3. それ以外なら以下を実行する．
    // 3-1．センチネル(番兵)である末尾ノードに引数で渡された単語を設定する．
    tail->word = word;
    // 3-2. ２番目のノードから始めて，引数で渡された単語と一致するノードを発見するまで，リストをたどる．
    // （末尾のセンチネル(番兵)を通り過ぎることはない）．
    // なお，直前ノード参照のポインタが後で必要なので，次ノードへのポインタ移動時に退避する．
    Node *prev = head;
    Node *p = head->next;
    while (p->word != word)
    {
      prev = p;
      p = p->next;
    }
    // 3-3. 発見したノードが末尾ノードであれば（未登録を意味する），新ノードの領域を確保して，
    //  引数で渡された単語を設定し，リストの先頭に挿入する．
    if (p == tail)
    {
      Node *gen = new Node();
      gen->word = word;
      gen->next = head;
      head = gen;
      // さらに，末尾ノードの単語を空文字列に戻す．
    }
    else
    {
      // 3-4. そうでなければ(登録済みを意味する)，発見したノードが先頭になるようにリストをつなぎかえる．
      // （直前ノードを参照するポインタが必要となる．これは探索時に退避する．）
      prev->next = p->next;
      p->next = head;
      head = p;
    }
  }
}
