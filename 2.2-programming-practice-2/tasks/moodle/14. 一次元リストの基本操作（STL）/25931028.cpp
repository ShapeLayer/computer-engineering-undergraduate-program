#include <iostream>
#include <list>
#include <string>
using namespace std;

#define SHOW    1   // リストに登録されている要素を一覧表示する．
                    //  리스트에 등록된 요소를 모두 표시한다.
#define INSERT 2    // 反復子の直前に新規要素を追加する．反復子は新規要素を参照する．
                    //  반복자의 바로 앞에 새로운 요소를 추가한다. 반복자는 새 요소를 가리킨다.
#define DELETE 3    // 反復子が参照する要素を削除する．反復子は次の要素を参照する．
                    //  반복자가 가리키는 요소를 삭제한다. 반복자는 다음 요소를 가리킨다.
#define NEXT 4      // 反復子を次の要素に進める．
                    //  반복자를 다음 요소로 이동한다.
#define PREVIOUS 5  // 反復子を前の要素に進める．
                    //  반복자를 이전 요소로 이동한다.
#define END 6       // プログラムを終了する．
                    //  프로그램을 종료한다.

// バス停到着情報クラス
class Arrival
{
public:
  int busStopType;    // バス停タイプ
  string busStopName; // バス停名
  string time;        // 通過時刻

  // コンストラクタ
  Arrival(int type, string name, string t)
  {
    busStopType = type;
    busStopName = name;
    time = t;
  }
};

void showList();
void insertList();

list<Arrival> busSchedule; // バス時刻表リスト
list<Arrival>::iterator p; // 上記を参照する反復子

/* メイン関数 */
int main()
{
  int command = -1;

  p = busSchedule.begin();
  while (command != END)
  {
    switch (command)
    {
    case SHOW:
      showList();
      break;
    case INSERT:
      insertList();
      break;
    case DELETE:
      if (p != busSchedule.end()) {
        p = busSchedule.erase(p);
      }
      break;
    case NEXT:
      if (p != busSchedule.end()) {
        p++;
      }
      break;
    case PREVIOUS:
      if (p != busSchedule.begin()) {
        p--;
      }
      break;
    case END:
      return 0;
    }
    cin >> command;
  }
}

/*　リストに登録されている要素を一覧表示．*/
/* 리스트에 등록된 요소를 모두 표시한다. */
void showList()
{
  for (auto q = busSchedule.begin(); q != busSchedule.end(); ++q) {
    if (q == p) cout << '>';
    cout << q->busStopType << " " << q->busStopName << " " << q->time << endl;
  }
  cout << endl;
}

/* 反復子の直前に新規要素を追加する．*/
/* 반복자의 바로 앞에 새로운 요소를 추가한다. */
void insertList()
{
  int type;
  string name, t;

  cin >> type >> name >> t;
  Arrival a(type, name, t);

  p = busSchedule.insert(p, a);
}
