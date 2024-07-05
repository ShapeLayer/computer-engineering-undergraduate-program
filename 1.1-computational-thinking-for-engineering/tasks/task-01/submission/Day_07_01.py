'''
import turtle
t = turtle.Turtle()
t.shape('turtle')
t.color('orange')
t.width(5)
t.forward(100)
t.color('blue')
t.circle(100)
turtle.done()
'''

'''
a, b =7,19
sum = a+b
print(sum)

print('='*15)
print(3.14,56,'hello',True)
print(type(3.14),type(56),type('hello'),type(True))

a = 3.14
print(365.1, a, type(a))
aa = 56
print(aa, type(aa))
'''

'''
x = int(input('첫번째 정수를 입력하세요 : '))
y = int(input('두번째 정수를 입력하세요 : '))
sum = x + y
print(x, '와', y, '의 합은', sum)
'''

'''
area_no = input("""
1. 서울   2. 광주   3. 제주
4. 부산   5. 대구   6. 인천
위 지역 중 정보를 조회할 지역의 번호를 입력하세요: 
""")

print(type(area_no))
'''

'''
print('%d' % 1)
print('%d %d' % (1,2))
print('%f' % (1.124))
print('%f %f' % (1.5,3.14))
print('%s' % ('one'))
print('%s, %s' % ('one','two'))
'''

'''
name = 'korea'
age = 20
string = '이름: %s, 나이: %d세' % (name, age)
print(string)
string1 = '이름: {}, 나이: {}세'.format(name, age)
print(string1)
string2 = f'이름: {name}, 나이: {age}세'
print(string2)
'''

'''
import turtle
t=turtle.Turtle()
s=turtle.Turtle()
t.shape('turtle')
s.shape('square')
t.color('orange')
s.color('purple')
w = 5
t.width(w)
s.width(w)
t.forward(100)
s.backward(100)
turtle.done()
'''

'''
import turtle
t = turtle.Turtle()
t.shape('turtle')

size = int(input('집의 크기는 얼마로 할까요 ?'))

t.width = 3
t.color('darkorange')

t.fillcolor('blue')
t.begin_fill()
t.forward(size)
t.right(90)
t.forward(size)
t.right(90)
t.forward(size)
t.right(90)
t.forward(size)
t.right(90)
t.end_fill()


t.fillcolor('red')
t.begin_fill()
t.forward(size)
t.left(120)
t.forward(size)
t.left(120)
t.forward(size)
t.left(120)
t.end_fill()

turtle.done()
'''

import turtle
s, t = turtle.Turtle(), turtle.Turtle()
t.shape('turtle')
s.shape('square')
t.color('orange')
s.color('purple')
w = 5
t.width(w)
s.width(w)
t.forward(100)
s.backward(100)

size = 50
t_a = 72
s_a = 60

t.fillcolor('silver')
t.begin_fill()

t.fd(size)
t.lt(t_a)
t.fd(size)
t.lt(t_a)
t.fd(size)
t.lt(t_a)
t.fd(size)
t.lt(t_a)
t.fd(size)
t.lt(t_a)

t.end_fill()

s.fillcolor('gold')
s.begin_fill()

s.fd(size)
s.lt(s_a)
s.fd(size)
s.lt(s_a)
s.fd(size)
s.lt(s_a)
s.fd(size)
s.lt(s_a)
s.fd(size)
s.lt(s_a)
s.fd(size)
s.lt(s_a)

s.end_fill()

turtle.done()
