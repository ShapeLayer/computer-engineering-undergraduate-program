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
  #text(size: 2em)[자료구조 과제 \#2]\
  
  214823 박종현
]
\

#let c(content) = list(marker: [#text(font: "Inter")[✓]])[#content]

#text(size: 1.5em)[조건]

#c[정의 3.3 Polynomial ADT를 파이썬 클래스로 구현해야 함.]
#c[연산 중 `multiply`는 구현하지 않음]
#c[`read_poly`는 별도의 함수로 구현을 하거나 `polynomial class`의 연산으로 구현 가능함]
#c[`add` 연산을 구현 시에 $P_1 + P_2$와 같이 수학 연산자로 수행 가능하도록 프로그래밍하는 경우 추가 점수를 구현함.]
\
#text(size: 1.5em)[big-O]
\

- `min, max` \@ `_generate_coeff_with_other` -- $O(n)$
- `[ ... for i in range(_min) ]` \@ `_generate_coeff_with_other` - $O(n)$
\
- $therefore O(n + n + n) = O(3n)$

\

#text(size: 1.5em)[/out/out1.png] 예제 입력 결과
#image("out/out1.png")

#text(size: 1.5em)[/src/app.py] 프로그램 소스

```py
import warnings

def convert_super_str(n: int) -> str:
    SUPERSCRIPTS = '⁰¹²³⁴⁵⁶⁷⁸⁹'

    buf = []
    while n >= 0:
        buf.append(SUPERSCRIPTS[n % 10])
        n //= 10
        if n == 0:
            break
    return ''.join(buf[::-1])

s = convert_super_str

class Polynomial:
    def __init__(self, coeff_len=0, coefficients=[]):
        if coefficients:
            self.coefficients = coefficients
        else:
            self.coefficients = [0 for _i in range(coeff_len)]

    def __str__(self) -> str:
        return ' + '.join([ f'{self.coefficients[i]}x{s(i)}' if i else f'{self.coefficients[i]}' for i in range(self.degree(), -1, -1) ])
    
    def __add__(self, other: 'Polynomial') -> 'Polynomial':
        return self.add(other)

    def __sub__(self, other: 'Polynomial') -> 'Polynomial':
        return self.subtract(other)

    def _coeff_zfill(self, n: int):
        for _i in n - self.managed_coeff:
            self.coefficients.append(0)

    @property
    def managed_coeff(self) -> int:
        return len(self.coefficients)

    def degree(self) -> int:
        tail_zeros = 0
        for each in self.coefficients[::-1]:
            if each == 0:
                tail_zeros += 1
            else:
                break
        return len(self.coefficients) - tail_zeros - 1
    
    def evaluate(self, scalar: int | float) -> int | float:
        return sum([ self.coefficients[i] * (scalar ** i) for i in range(len(self.coefficients)) ])
    
    def _generate_coeff_with_other(self, other: 'Polynomial', weight: int=1) -> list:
        _min, _max = min(self.managed_coeff, other.managed_coeff), max(self.managed_coeff, other.managed_coeff)
        _new_coeff = [ self.coefficients[i] + other.coefficients[i] * weight for i in range(_min) ]
        if len(self.coefficients) > _min:
            for i in range(_min, _max):
                _new_coeff.append(self.coefficients[i] * weight)
        else:
            for i in range(_min, _max):
                _new_coeff.append(other.coefficients[i] * weight)
        return _new_coeff

    def add(self, rhs: 'Polyonomial') -> 'Polynomial':
        return Polynomial(coefficients=self._generate_coeff_with_other(rhs))
    
    def subtract(self, rhs):
        return Polynomial(coefficients=self._generate_coeff_with_other(rhs, weight=-1))
    
    def multiply(self, rhs):
        '''
        연산 중 multiply는 구현하지 않음 ((1) 조건, 2항)
        '''
        warnings.warn('deprecated', DeprecationWarning)

    def display(self):
        print(str(self))

def read_poly() -> Polynomial:
    n = int(input('다항식의 최고 차수를 입력하시오: '))
    coeff = []
    for i in range(n, -1, -1):
        coeff.append(int(input(f'\tx{s(i)}의 계수 : ')))
    return Polynomial(coefficients=coeff[::-1])

if __name__ == '__main__':
    a = read_poly()
    b = read_poly()
    c = a + b
    print('A(x) = ', end='')
    a.display()
    print('B(x) = ', end='')
    b.display()
    print('C(x) = ', end='')
    c.display()
    print('C(2) =', c.evaluate(2))

```
