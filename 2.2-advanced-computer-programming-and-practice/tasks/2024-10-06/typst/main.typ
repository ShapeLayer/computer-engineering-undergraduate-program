#import "@preview/codly:0.2.0": *
#show: codly-init.with()
#codly(languages: (
  py: (name: "Python", icon: "", color: rgb("#3572A5")),
  cpp: (name: "C++", icon: "", color: rgb("#f34b7d")),
  sh: (name: "Shell", icon: "", color: rgb("#58c623"))
))


#set page(
  margin: (x: 3em, y: 4em)
)
#set text(font: ("Noto Sans CJK KR", "Noto Sans KR"), size: .9em)

#align(center)[
  #text(size: 2em)[고급프로그래밍및실습 과제 \#3]\
  
  214823 박종현
]

\
1. CHAPTER 01~06의 내용을 가지고 자신만의 문제 출제 및 해답 코드 작성(코드의 이해를 돕기 위한 주석 작성 필수)

2. 245,246p 의 1~5번 문제 풀이

\

#text(size: 1.5em)[선택: \#1] 자신만의 문제 출제 및 해답 코드 작성

\

다음 문제의 단순 테스트 케이스 생성기를 작성하여라.  \
스트레스 테스트 케이스는 생성하지 않아도 된다.  

\
#block(
  fill: luma(245),
  inset: 1em,
  radius: .5em,
  stroke: luma(237)
)[
  === _#underline[#link("https://www.acmicpc.net/problem/29616")[백준 온라인 저지, 29616번 문제: 전역 역전]]_  
  
  \
  ==== 문제 요약
  투표 결과가 백분율로 나타난다면, 이로부터 전체 투표수를 추측할 수 있다.  
  
  과거 어느 시점에서의 투표 결과와 현재의 투표 결과를 모두 만족하는 현재의 총투표수를 추정한다.
  
  추정 가능한 이전 시점의 총 투표수와 현재 시점의 총 투표수를 공백을 간격으로 순서대로 출력한다. 가능한 총 투표수가 여러 가지라면 가장 낮은 값을 결과로 출력한다.
  
  \
  
  ==== 입력
  첫째 줄에 투표 항목의 개수 $N$ ($1 <= N <= 100$) 과 투표 결과가 표현되는 소수점 자릿수 $P$ ($0 <= P <= $)가 공백으로 구분되어 주어진다.
  
  둘째 줄에 이전 시점, 백분율로 표현되는 각 항목의 투표 결과에 $10^P$를 곱한 값 $N$개가 공백으로 구분되어 주어진다.
  
  셋째 줄에 현재 시점, 백분율로 표현되는 각 항목의 투표 결과에 $10^P$를 곱한 값 $N$개가 공백으로 구분되어 주어진다.
  
  둘째 줄과 셋째 줄에 주어지는 각 값은 반올림이 이루어지지 않은 값이다. 각 시점에서 주어지는 수의 합은 $10^{P+2}$임이 보장된다.
  
  \
  
  ==== 출력
  이전 시점의 총 투표수와 현재 시점의 총 투표수를 공백을 간격으로 순서대로 출력한다.
  
  \
  
  #grid(
    columns: 2,
    inset: (right: 1em),
    [
      ==== 예제 입력 1
      ```
      2 0
      50 50
      90 10
      ``` 
    ], [
      ==== 예제 출력 1
      ```
      2 10
      ```
    ]
  )
]

#pagebreak()

== 답안
\

```cpp
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
Random rnd;  // 정의한 Random 객체 생성

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

```

== 실행 결과
#align(center)[#image("assets/output.png", width: 60%)]

=== 실행 1
```sh
g++ generator.cpp -o generator
./generator
```

```
Usage: generator n p
```

=== 실행 2
```sh
./generator 2 0
```

```
2 0
96 4
96 4
```

=== 실행 3
```sh
./generator 6 6
```

```
6 6
29370006 2925450 6588965 1329029 31830158 27956392
11878377 47185309 17625885 1871063 18578003 2861363
```
