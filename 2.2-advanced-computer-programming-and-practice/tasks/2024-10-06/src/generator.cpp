#include <bits/stdc++.h>
#include <random>
using namespace std;

/**
 * Random 클래스
 * 임의의 수를 선택하기 위해 `random_device`와 `mt19937` 객체를 생성해야하는 소요를 줄임
 */
class Random {
private:
  // 임의의 수를 선택하는데 사용되는 랜덤 디바이스, 메르센 트위스터 19937 유사 난수 생성기를 가짐
  random_device _random_device;
  mt19937 _gen;
public:
  Random() {
    // mt19937 구현체 객체 생성
    this->_gen = mt19937(_random_device());
  }

  int next(int init, int fin) {
    /**
     * next
     *  $[init, fin]$ 구간 사이 임의의 정수를 선택하여 반환
     */

    // 균일 정수 분포 생성
    uniform_int_distribution<> dist(init, fin);
    return dist(this->_gen);  // mt19937을 이용하여 균일 정수 분포에서 값 선택
  }
};

int n, p;
Random rnd;

void div(int n, vector<int> *res, int mx)
{
  /**
   * div 함수
   * 
   *  res 벡터에 합이 10의 거듭제곱인 정수 집합을 추가함
   */
  res->clear();
  vector<int> range;

  // 구간 내에서 임의 값 생성
  // 이 값은 전체에서 각 범위를 나누는 구분자 역할을 수행함
  // n개 값을 생성해야 한다면, n - 1 개의 구분자를 생성함
  for (int i = 0; i < n - 1; i++)
  {
    range.push_back(rnd.next(0, mx));
  }
  range.push_back(mx);

  // 생성한 구분자를 정렬
  sort(range.begin(), range.end());
  
  // 각 구분자에 대해, 현재 구분자와 직전 구분자의 차를 계산하여 결과 벡터에 추가
  int pre = 0;
  for (int i = 0; i < n; i++)
  {
    res->push_back(range[i] - pre);
    pre = range[i];
  }
}

int main(int argc, char *argv[])
{
  if (argc < 3) {
    cout << "Usage: generator n p" << endl;
    return 1;
  }

  n = stoi(argv[1]), p = stoi(argv[2]);
  cout << n << " " << p << endl;
  int mx = 100 * (int)pow(10, p);

  // 이전 상황과 현재 상황에 대해 투표 결과 백분위 생성
  // a: 이전 상황, b: 현재 상황
  vector<int> a, b;

  while (true)
  {
    // 각 상황 벡터에 대해 투표 결과 백분위 생성
    div(n, &a, mx);
    div(n, &b, mx);

    // 올바른 내용이 생성되었는지 확인하기 위한 플래그
    bool is_true = true;

    for (int i = 0; i < n; i++)
    {
      // 어떤 투표 항목에 대해서,
      // 이전 항목의 점유율이 0이 아니었는데
      // 현재 항목의 점유율이 0이라면
      // 올바르지 않은 내용이 생성된 것이므로 재생성해야함
      if (a[i] != 0 && b[i] == 0) {
        is_true = false;
      }
    }

    // 올바른 값이 생성되었다면 반복 종료
    if (is_true) {
      break;
    }
  }

  // 이전 시점 값 출력
  cout << a[0];
  for (int i = 1; i < n; i++)
  {
    cout << " " << a[i];
  }
  cout << endl
  // 현재 시점 값 출력
       << b[0];
  for (int i = 1; i < n; i++)
  {
    cout << " " << b[i];
  }
  cout << endl;
  return 0;
}
