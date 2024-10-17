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
  #text(size: 2em)[자료구조 과제 \#3]\
  
  214823 박종현
]
\

#let c(content) = list(marker: [#text(font: "Inter")[✓]])[#content]

#text(size: 1.5em)[조건]

#c[일렬로 주어진 문자열에서 가장 긴 회문 구간 찾기]
#c[주어진 문자열의 길이를 $n$이라고 할 때, 시간 복잡도 서술]
\
#text(size: 1.5em)[big-O]
\

- `compute` -- $O(n^2)$
- `evaluate` -- $O(n)$
\
- $therefore O(n^3)$

\

#text(size: 1.5em)[/out/out.png] 예제 입력 결과
#image("out/out.png")

\

#text(size: 1.5em)[/src/app.py] 프로그램 소스


```py
from math import ceil

def compute(gets: list):
    n = len(gets)
    def evaluate(gets: list) -> bool:
        n = len(gets)
        is_palindrome = True
        for i in range(ceil(n / 2)):
            is_palindrome = is_palindrome and gets[i] == gets[-(i + 1)]
            if not is_palindrome:
                break
        return is_palindrome
    _max_len = -1
    _max_len_end = (-1, -1)
    for i in range(n):
        for j in range(i, n):
            now = gets[i:j]
            if evaluate(now):
                if _max_len < j - i:
                    _max_len = j - i
                    _max_len_end = (i, j)
    return (_max_len, _max_len_end)

if __name__ == '__main__':
    _max_len, _max_len_end = compute(input().split())
    print(f'Answer is from {_max_len_end[0]} with length {_max_len}')
```
