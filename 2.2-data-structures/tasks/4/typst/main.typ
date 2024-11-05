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
  #text(size: 2em)[자료구조 과제 \#4]\
  
  214823 박종현
]
\

#let c(content) = list(marker: [#text(font: "Inter")[✓]])[#content]

#text(size: 1.5em)[조건]

#c[`LinkedList`를 활용하여 `SparsePoly` 클래스 구현]
#c[과제 \#3 `Polynomial` ADT 연산 중 `add`, `equal`, `degree`, `coef` 구현]
#c[`read`, `display` 구현]
#c[`add` 연산: `p1 + p2` 가능하게 구현]
#c[`equal` 연산: `p1 == p2` 가능하게 구현]
#c[교재의 예제 입력과 달리 임의의 차수 순으로 입력 가능해야함]
#c[다항식의 노드는 차수가 감소하는 순서를 유지해야 함]
\
#text(size: 1.5em)[`add` 연산의 시간복잡도 #super[big-O]]
\

#c[다항식의 차수: $n$, 계수가 $0$이 아닌 항의 개수: $m$]
#c[다항식의 차수 $n$에 대해, $n$회 반복 수행함.]
$therefore O(n)$

\

#text(size: 1.5em)[/out/out.png] 예제 입력 결과
#image("out/out.png")

\

#text(size: 1.5em)[/src/app.py] 프로그램 소스


```py
from typing import TypeVar, Generic

T = TypeVar("T")

class Node(Generic[T]):
    def __init__(self, data: T, link: 'Node'):
        self.data: T = data
        self.link = link

class LinkedList:
    def __init__(self):
        self.head = None
    
    def is_empty(self):
        return self.head == None

    def is_full(self):
        return False

    def get_node(self, pos: int) -> Node:
        if pos < 0:
            return None
        node = self.head
        while pos > 0 and node != None:
            node = node.link
            pos -= 1
        return node
    
    def get_entry(self, pos: int) -> T:
        node = self.getNode(pos)
        if node == None:
            return None
        else:
            return node.data

    def __getitem__(self, key: int) -> T:
        return self.get_entry(key)

    def insert(self, pos: int, elem: T):
        prev = self.get_node(pos - 1)
        if prev == None:
            self.head = Node(elem, self.head)
        else:
            node = Node(elem, prev.link)
            prev.link = node
    
    def delete(self, pos: int):
        prev = self.get_node(pos - 1)
        if prev == None:
            if self.head is not None:
                self.head = self.head.link
        elif prev.link != None:
            prev.link = prev.link.link

class Term:
    def __init__(self, expo, coef):
        '''
        :param expo: 항의 지수
        :param coef: 항의 계수
        '''
        self.expo = expo
        self.coef = coef

class SparsePoly(LinkedList):
    def __str__(self):
        coef_buf = self.coef()
        str_buf = []
        degs = [*coef_buf.keys()]
        while degs:
            deg = degs.pop()
            str_buf.append(f'{coef_buf[deg]} x^{deg}')
        return ' +\t'.join(str_buf)
    
    def read(self):
        '''
        사용자 입력 함수
        '''
        while True:
            gets = [*map(int, input('계수 차수 입력(종료: -1): ').split())]
            if gets[0] == -1 and gets[1] == -1:
                break
            if (len(gets) != 2):
                # fallback
                continue
            c, d = gets
            if self.get_node(d) == None:
                self._fill_until(d)
            self.get_node(d).data = c
        
        self.display()
    
    def _fill_until(self, pos: int):
        node = self.head # pos 0
        if node == None:
            self.head = Node(0, None)
            node = self.head
        for i in range(pos):
            if node.link == None:
                node.link = Node(0, None)
            node = node.link

    def display(self):
        '''
        화면 출력 함수
        '''
        print(f'\t입력 다항식: {self.__str__()}')

    def add(self, polyB: 'SparsePoly') -> 'SparsePoly':
        '''
        다항식 덧셈 함수
        '''
        _new = SparsePoly()
        _new.head = Node(0, None)
        entry_self, entry_other, entry_new = self.head, polyB.head, _new.head
        while True:
            if entry_self:
                entry_new.data += entry_self.data
                entry_self = entry_self.link
            if entry_other:
                entry_new.data += entry_other.data
                entry_other = entry_other.link
            if entry_self != None or entry_other != None:
                entry_new.link = Node(0, None)
                entry_new = entry_new.link
            else:
                break
        return _new

    def __add__(self, other: 'SparsePoly') -> 'SparsePoly':
        return self.add(other)

    def equal(self, other: 'SparsePoly') -> bool:
        '''
        다항식 항등 평가
        '''
        entry_self, entry_other = self.head, other.head
        while True:
            if entry_self == None and entry_other == None:
                return True
            if entry_self == None or entry_other == None:
                return False
            if entry_self.data != entry_other.data:
                return False
            entry_self, entry_other = entry_self.link, entry_other.link

    def __eq__(self, other: 'SparsePoly') -> 'SparsePoly':
        return self.equal(other)

    def degree(self):
        '''
        다항식 차수 반환
        '''
        i = 0
        entry = self.head
        while True:
            if entry.link == None:
                return i
            i += 1
            entry = entry.link

    def coef(self) -> dict[int, int]:
        '''
        다항식 계수 반환
        '''
        coef_buf = {}
        node = self.head
        degree = 0
        while node != None:
            if node.data != 0:
                coef_buf[degree] = node.data
            node = node.link
            degree += 1
        return coef_buf

if __name__ == '__main__':
    a, b = SparsePoly(), SparsePoly()
    a.read()
    b.read()
    print(f'\tA = {a}')
    print(f'\tB = {b}')
    print(f'\tA + B = {a + b}')

```

#text(size: 1.5em)[/1.in] 예제 입력
```
3 12
2 8
1 0
-1 -1
8 12
-3 10
10 6
-1 -1
```

#text(size: 1.5em)[/1.out] 예제 출력
```
계수 차수 입력(종료: -1): 계수 차수 입력(종료: -1): 계수 차수 입력(종료: -1): 계수 차수 입력(종료: -1): 	입력 다항식: 3 x^12 +	2 x^8 +	1 x^0
계수 차수 입력(종료: -1): 계수 차수 입력(종료: -1): 계수 차수 입력(종료: -1): 계수 차수 입력(종료: -1): 	입력 다항식: 8 x^12 +	-3 x^10 +	10 x^6
	A = 3 x^12 +	2 x^8 +	1 x^0
	B = 8 x^12 +	-3 x^10 +	10 x^6
	A + B = 11 x^12 +	-3 x^10 +	2 x^8 +	10 x^6 +	1 x^0
```
