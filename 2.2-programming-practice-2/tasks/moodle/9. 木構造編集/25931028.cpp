#include <iostream>
#include <string>
using namespace std;

#define WORDLENGTH 10 // 一行の長さ
#define END 'E'       // 終了
#define ADD 'A'       // 追加
#define LEFT 'L'      // 左
#define RIGHT 'R'     // 右
#define DELETE 'D'    // 削除

class Node
{ // ノードを表すクラス
public:
  string word;  // ノード格納単語
  Node *pLeft;  // 左ノードを参照するポインタ
  Node *pRight; // 右ノードを参照するポインタ
};

void showTree();
void showTreeRecursive(Node *pNode, int nodeLevel);
Node *searchNode(int searchNodeNo);
Node *searchNodeRecursive(Node *pPresentNode, int searchNodeNo);
void addNode(string word, int nodeNo, char direction);
void deleteNode(int nodeNo, char direction);

Node *pRoot;     // 根ノードを参照するポインタ
int nodeCounter; // ノードの番号付けカウンタ

/* メイン関数 */
int main()
{
  char command = ' ';         // コマンド文字
  char word[WORDLENGTH] = ""; // 単語（文字配列）
  char direction = LEFT;      // 方向指示
  int nodeNo;                 // ノード番号

  pRoot = new Node; // 根ノードを生成し，その参照を根ノードポインタに入れる
  // 根ノードの左右ポインタにNULLを，単語に"root"を入れる
  pRoot->pLeft = pRoot->pRight = NULL;
  pRoot->word = "root";

  showTree(); // 現在の木構造を表示

  // コマンドを受け取り
  cin >> command;
  if (command != END)
  {
    if (command == ADD)
      cin >> word;
    cin >> nodeNo;
    cin >> direction;
  }
  while (command != END)
  { // コマンドがENDでない限り以下の処理を繰り返し
    switch (command)
    {
    case ADD: // コマンドが「追加」であれば以下を実行
      addNode(word, nodeNo, direction);
      break;
    case DELETE: // コマンドが「切り取り」であれば以下を実行
      deleteNode(nodeNo, direction);
      break;
    default: // コマンドがどれでもなければエラー表示
      cout << "error" << endl;
      break;
    }

    showTree(); // 現在の木構造を表示

    // 次のコマンドを受け取り
    cin >> command;
    if (command != END)
    {
      if (command == ADD)
        cin >> word;
      cin >> nodeNo;
      cin >> direction;
    }
  }
}

/* 木構造を表示 */
void showTree()
{
  int nodeLevel;                       // ノードの根からの深さ
  nodeCounter = 0;                     // ノードカウンタ（ノード番号を数える）をリセット
  nodeLevel = 0;                       // ノードレベル（根からの深さ）をリセット
  showTreeRecursive(pRoot, nodeLevel); // 木の表示再帰を呼び出し
  cout << endl;
}

/* 木構造の再帰表示（右側から枝を書いていく）*/
void showTreeRecursive(Node *pNode, int nodeLevel)
{
  if (pNode == NULL)
    return;    // ノードポインタがnullならば戻る＝そこから先の木がない
  nodeLevel++; // ノードレベルをインクリメントする
  // ノードポインタの指すノード（現ノード)の右ポインタについて木の再帰表示
  // 木の右端まで行くと上記returnで抜けて下へ
  showTreeRecursive(pNode->pRight, nodeLevel);
  nodeCounter++; // ノードカウンタをインクリメントする
  // ノードレベルに合ったインデンション"\t"を付け，ノードカウンタと現ノードの単語を表示
  for (int i = 1; i < nodeLevel; i++)
    cout << "   "; // 半角スペース3つ
  cout << nodeCounter << ":" << pNode->word << endl;
  // 現ノードの左ポインタについて木の再帰表示
  showTreeRecursive(pNode->pLeft, nodeLevel);
}

/* 指定番号のノードを探索 */
Node *searchNode(int searchNodeNo)
{
  nodeCounter = 0; // ノードカウンタをリセット
  // ノードの再帰探索を行い，その戻り値を持って戻る
  return searchNodeRecursive(pRoot, searchNodeNo);
}

/* ノードの再帰探索 */
Node *searchNodeRecursive(Node *pPresentNode, int searchNodeNo)
{
  Node *pFoundNode; // 発見したノードへのポインタ
  // ノードポインタがNULLならば戻り値をNULLにして戻る
  if (pPresentNode == NULL)
    return NULL;
  // ノードポインタが参照するノード(現ノード）の右ポインタについてノードの再帰探索
  pFoundNode = searchNodeRecursive(pPresentNode->pRight, searchNodeNo);
  // 戻り値がNULLでなければ，その戻り値を持って戻る
  if (pFoundNode != NULL)
    return pFoundNode;
  nodeCounter++; // ノードカウンタをインクリメントする
  // ノードカウンタが探索ノード番号に等しければ，現ノードポインタを持って戻る
  if (searchNodeNo == nodeCounter)
    return pPresentNode;
  // 現ノードの左ポインタについてノードの再帰探索を行う
  pFoundNode = searchNodeRecursive(pPresentNode->pLeft, searchNodeNo);
  return pFoundNode; // その戻り値を持って戻る
}

/* ノードを追加 */
void addNode(string word, int nodeNo, char direction)
{
  Node *pParentNode; // 親ノードへのポインタ
  Node *pChildNode;  // 子ノードへのポインタ
  
  // ノード番号に対応する親ノードを探索してノードポインタを得る
  // 노드 번호에 해당하는 부모 노드를 탐색하여 노드 포인터를 얻음
  pParentNode = searchNode(nodeNo);

  // ノードポインタがNULLであれば戻る（探索失敗）
  // 노드 포인터가 NULL이면 반환(탐색 실패)
  if (pParentNode == NULL)
    return;

  // 方向指示の先が空いていなければ戻る
  // 방향 지시의 위치가 비어있지 않으면 반환
  switch(direction)
  {
  case RIGHT:
    if (pParentNode->pRight != NULL)
      return;
    break;
  case LEFT:
    if (pParentNode->pLeft != NULL)
      return;
    break;
  }

  // 新しく子ノードのメモリ領域を確保する
  // 새로 자식 노드의 메모리 영역을 확보
  pChildNode = new Node;

  // 자식 노드의 내용을 설정
  // 子ノードの内容を設定する
  pChildNode->word = word; // 単語を設定
  pChildNode->pLeft = NULL;  // 左ポインタをNULLに
  pChildNode->pRight = NULL; // 右ポインタをNULLに

  // 子ノードを親ノードの方向指示の先につなぐ
  // 자식 노드를 부모 노드의 방향 지시 위치에 연결
  if (direction == RIGHT)
  {
    pParentNode->pRight = pChildNode;
  }
  else if (direction == LEFT)
  {
    pParentNode->pLeft = pChildNode;
  }
}

/* ノードの削除 */
void deleteNode(int nodeNo, char direction)
{
  Node *pNode; // 現ノードへのポインタ
  Node *p;     // 削除対象ノードへのポインタ

  // ノード番号に対応するノード(現ノード）を探索してポインタを得る
  // 노드 번호에 해당하는 노드(현재 노드)를 탐색하여 포인터를 얻음
  pNode = searchNode(nodeNo);

  // ノードポインタがNULLならば戻る(探索失敗）
  // 노드 포인터가 NULL이면 반환(탐색 실패)
  if (pNode == NULL)
  {
    return;
  }

  // 方向指示に対応する左右ポインタから，削除対象ノードへのポインタを得る
  // 방향 지시에 해당하는 좌우 포인터에서 삭제 대상 노드의 포인터를 얻음
  if (direction == RIGHT)
  {
    p = pNode->pRight;
  }
  else
  {
    p = pNode->pLeft;
  }

  // ポインタがNULLであれば削除対象ノードが無いので戻る
  // 포인터가 NULL이면 삭제 대상 노드가 없으므로 반환
  if (p == NULL)
  {
    return;
  }

  // 削除対象ノードの下に子ノードが2つあれば削除できないので戻る
  // 삭제 대상 노드 아래에 자식 노드가 2개 있으면 삭제 불가이므로 반환
  if ((p->pLeft != NULL) && (p->pRight != NULL))
  {
    return;
  }

  // 存在する子ノードへのポインタを得る（子ノードが無いならばNULL）
  // 子ノードへのポインタを，方向指示に対応して現ノードの左右ポインタのどちらかに入れる
  // 존재하는 자식 노드의 포인터를 얻음(자식 노드가 없으면 NULL)
  // 자식 노드의 포인터를 방향 지시에 따라 현재 노드의 좌우 포인터 중 하나에 넣음
  if (direction == RIGHT)
  {
    if (p->pLeft != NULL)
    {
      pNode->pRight = p->pLeft;
    }
    else
    {
      pNode->pRight = p->pRight;
    }
  }
  else if (direction == LEFT)
  {
    if (p->pLeft != NULL)
    {
      pNode->pLeft = p->pLeft;
    }
    else
    {
      pNode->pLeft = p->pRight;
    }
  }

  // 削除対象ノードのメモリ領域を解放する
  // 삭제 대상 노드의 메모리 영역을 해제
  delete p;
}
