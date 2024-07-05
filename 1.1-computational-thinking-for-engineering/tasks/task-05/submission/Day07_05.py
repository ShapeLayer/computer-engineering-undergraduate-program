hap, i = 0, 0
for i in range(1, 11):
    if i % 3 == 0:
        continue
    hap +=i
    print(i, end =' ')

print()
print('1~10의 합계(3의배수 제외) : %d' % hap)

'''
strings = 'ILovePython'
for ch in strings:
    if ch not in ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']:
        continue
    print(ch, end=‘ ')
'''

'''
strings = 'ILovePython'
for ch in strings:
    if ch in ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']:
        continue
    print(ch, end=‘ ')
'''

'''
fruits = ['사과', '포도', '오렌지', '바나나', '수박', '딸기']
for i in fruits:
    if i == '오렌지':
        break
    print(i, '완전 맛있어요~~~~')
'''

'''
hap = 0
count = 1

while count < 100:
    hap = hap + count
    count = count + 2

print('1과 100 사이에 있는 홀수의 합: %d' % hap)
'''

'''
count = 1
sum = 0

while count <= 10 :
    sum = sum + count
    count = count + 1
print('1에서 10까지의 합계: %d' % sum)
'''

'''
import turtle
import random

t = turtle.Turtle()
c = ['red', 'orange', 'yellowgreen', 'green', 'blue', 'indigo']
t.width(3)

a = turtle.textinput('원 그리기', '몇 개의 원를 그릴까요')
number = int(a)

for i in range(number):
    n = random.randint(0, 5)
    t.color(c[n])
    t.circle(80)
    t.left(360 / number)

turtle.done()
'''

'''
import turtle
import random

t = turtle.Turtle()
t.shape('turtle')
t.width(3)

c = ['red','orange','green','blue','purple','gold']
s = turtle.textinput('도형그리기', '몇각형을 그릴까요?')

n = int(s)
for i in range(n):
    t.color(c[random.randint(0,5)])
    t.forward(100)
    t.left(360 / n)

turtle.done()
'''

'''
import turtle
t = turtle.Turtle()
c = ['red', 'orange', 'yellowgreen', 'green', 'blue', 'indigo']
t.width(3)

for i in range(3):
    t.color(c[i])
    t.forward(100)
    t.left(360 / 3)
for i in range(4):
    t.color(c[i])
    t.forward(100)
    t.left(360 / 4)
for i in range(5):
    t.color(c[i])
    t.forward(100)
    t.left(360 / 5)

turtle.done()
'''

'''
import turtle
t = turtle.Turtle()
c = ['red', 'orange', 'yellowgreen', 'green', 'blue', 'indigo']
for i in range(6):
    t.color(c[i])
    t.circle(100)
    t.left(360/6)

turtle.done()
'''

'''
import turtle
t = turtle.Turtle()

for i in range(6):
    t.circle(80)
    t.left(360 / 6)
turtle.done()
'''

'''
dan = int(input('dan입력 :'))
for i in range(1, 10):
    text = f'{dan} * {i} = {dan * i}'
    print(text)
'''

'''
dan = int(input('출력할 구구단은: '))
for i in range(1, 10):
    print('%2d * %2d = %2d' % (dan, i, dan * i))
'''

'''
dan = 3
for i in range(9, 0, -1):
    print('%d * %d = %2d' % (dan, i, dan * i))
'''

'''
dan = 3
for i in range(1, 10):
    print('%d * %d = %2d' % (dan, i, dan * i))
'''

'''
i, hap = 0, 0

start = int(input('start 숫자 입력:'))
stop = int(input('stop 숫자 입력:'))

for i in range(start, stop + 1, 1):
    if i % 3 == 0:
        print(i, end= ' ')
        hap = hap +i

print()
print('%d에서 %d 까지의 합계: %d' % (start, stop, hap))
'''

'''
i, hap, num = 0, 0, 0
num = int(input('숫자 입력: '))
for i in range(1, num + 1, 1):
    hap = hap + i

print('1에서 %d까지의 합계: %d' % (num, hap))
'''

'''
hap = 0
for i in range(1,100,2):
    hap = hap + i
print('1과 100 사이에 있는 홀수의 합: %d' % hap)
'''

'''
hap = 0
for i in range(1,4):
    hap = hap + i
print(hap)
'''

'''
for j in 'hello':
    print(j, end='-')
'''

'''
f_list = ['사과', '바나나', '망고', '수박', '자몽']
for i in f_list:
    print(i, '맛있다')
'''

'''
for i in range(3):
    print('python')

for _ i in range(3):
    print('python')
'''

'''
for i in range(1, 10, 3):
    print(i, end='**')

print()

for i in range(0, 10, 2):
    print(i, end=' ')
'''

'''
for i in range(100):
    print(i)
'''

'''
import turtle
t = turtle.Turtle()
t.shape('turtle')
s = turtle.textinput('도형입력', '도형을 입력하시오: ')
size = turtle.textinput('', '길이: ')
w = int(size)

if s == '사각형':
    t.fd(w)
    t.lt(90)
    t.fd(w)
    t.lt(90)
    t.fd(w)
    t.lt(90)
    t.fd(w)
    t.lt(90)
if s == '삼각형':
    t.fd(w); t.lt(120)
    t.fd(w); t.lt(120)
    t.fd(w); t.lt(120)
if s == '원':
    t.circle(w)

turtle.done()
'''

'''
import random
number = random.randint(0, 2)

t.fd(50)
t.fillcolor(c_list[number])

t.begin_fill()
t.circle(100)
t.end_fill()
'''

'''
import turtle
t = turtle.Turtle()
t.shape('turtle')

c_list = ['orange', 'cyan', 'yellowgreen' ]

t.fillcolor(c_list[0])
t.begin_fill()
t.circle(100)
t.end_fill()

t.fd(20)

t.fillcolor(c_list[1])
t.begin_fill()
t.circle(100)
t.end_fill()

t.fd(20)

t.fillcolor(c_list[2])
t.begin_fill()
t.circle(100)
t.end_fill()

t.fd(20)

turtle.done()
'''

'''
import turtle
t = turtle.Turtle()
turtle.setup(width=500, height=500)

t.shape('turtle'); t.color('orange')
t.width(5); t.speed(1)

t.fd(400); t.stamp(); t.backward(100); t.speed(10)

t.color('purple')
t.shapesize(1, 2)
t.circle(100)

turtle.done()
'''

'''
import turtle
t = turtle.Turtle()
turtle.setup(width = 500, height =500)

t.shape('turtle'); t.color('orange')
t.width(5); t.speed(1)

t.fd(400); t.stamp(); t.backward(100); t.speed(10)
t.color('purple')
t.shapesize(1,2)
t.circle(100)

turtle.done()
'''

'''
year = int(input('연도를 입력하시오: '))
if (year % 4 == 0 and year % 100 != 0) or year % 400 == 0:
    print(year, '년은 윤년입니다.')
else:
    print(year, '년은 윤년이 아닙니다.')
'''

'''
year = int(input('연도를 입력하시오: '))
if year % 4 == 0 and year % 100 != 0:
    print(year, '년은 윤년입니다.')
elif year % 400 == 0:
    print(year, '년은 윤년입니다.')
else:
    print(year, '년은 윤년이 아닙니다.')
'''

'''
data = ['paper', 'money', 'cellphone']
if 'money' in data:
    pass
else:
    print('카드사용')
'''

'''
num = int(input('정수를 입력하시오: '))
if num >= 0:
    if num == 0:
        print('0입니다.')
    else:
        print('양수입니다.')
else:
    print('음수입니다.')
'''

'''
jumsu = int(input('점수를 입력: '))
if jumsu >=90:
    print('A 등급')
elif jumsu >=80:
    print('B 등급')
elif jumsu >=70:
    print('C 등급')
else:
    print('F 등급')
'''

'''
number = input('데이터 입력 :')
length = len(number)
print('입력한 데이터는 %s는 %d자리 숫자(문자)입니다' % (number, length))
'''

'''
number = input('1~999 사이의 숫자를 입력 :')
if len(number) == 3:
    print(' 입력한 숫자 %s는 3자리 숫자' % number)
elif len(number) == 2:
    print(' 입력한 숫자 %s 2자리 숫자' % number)
else:
    print(' 입력한 숫자 %s는 1자리 숫자' % number)
'''

'''
number = int(input('1~999 사이의 숫자를 입력 :'))
if number >= 100:
    print(' 입력한 정수 %d는 3자리 숫자' %number)
elif number >= 10:
    print(' 입력한 정수 %d는 2자리 숫자' % number)
else:
    print(' 입력한 정수 %d는 1자리 숫자' % number)
'''

'''
num = int(input('정수를 입력: '))
if num > 0:
    print('양수입니다.')
elif num == 0:
    print('0입니다.')
else:
    print('음수입니다.')
'''

'''
num = int(input('숫자를 입력하시오: '))
if num % 2 == 0:
    print('짝수입니다.')
else:
    print('홀수입니다.')
'''
