#import "@preview/codly:0.2.0": *
#show: codly-init.with()
#codly(languages: (
  py: (name: "Python", icon: "", color: rgb("#3572A5")),
  cpp: (name: "C++", icon: "", color: rgb("#f34b7d"))
))


#set page(
  margin: (x: 3em, y: 4em)
)
#set text(font: ("Noto Sans CJK KR", "Noto Sans KR"), size: .9em)

#align(center)[
  #text(size: 2em)[자료구조 연습문제 과제 \#1]\
  
  214823 박종현
]
\

#let c(content) = list(marker: [#text(font: "Inter")[✓]])[#content]

#text(size: 1.5em)[1장] 1.6 다음을 빅오 표기법으로 나타내어라

$
T(n)=n^2log_2 n+n^3 + 3
$

#c[$O(n^3)$]

\
#text(size: 1.5em)[1장] 1.8 다음 알고리즘의 시간 복잡도를 빅오 표기법으로 나타내어라

```py
def fn(n: int):
  _sum = 0
  for i in range(n):
    for j in range(i + 1, n + 1):
      _sum += j
```

#c[$O(n^2)$]

\
#text(size: 1.5em)[3장] 3.4 배열로 자료구조 리스트 구현 시 많은 항목 이동 필요한 연산

#c[삽입 연산]
\
#text(size: 1.5em)[3장] 3.6 파이썬 리스트의 `insert`와 `append`의 시간 복잡도로 정확한 것

#c[$O(n)$, 대부분의 경우 $O(1)$]
#c[파이썬 리스트는 일정 수준 길이가 늘어나면 더 많은 메모리를 할당하므로 `append`는 정확히 $O(1)$의 시간 복잡도를 갖지는 않는다.]
#align(center)[#image("assets/python-list-memory.png", width: 60%)
#link("https://dev.to/dillir07/here-is-how-python-list-s-memory-size-changes-w-r-t-it-s-length-28ah")[#underline[_source: Dilli Babu R_]]]
\
#text(size: 1.5em)[3장] 3.8 정렬되지 않은 리스트로 집합 구현 시 시간 복잡도가 가장 높은 연산

#c[(4) 두 집합이 같은 집합인지 검사]
#c[`contains`: $O(n)$; $" "$ `insert`: $O(log n)$; $" "$ `remove`: $O(n)$; $" "$ `equals`: $O(2n) + O("sort")$]
