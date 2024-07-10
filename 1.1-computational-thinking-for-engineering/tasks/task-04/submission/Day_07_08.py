
letters=['A', 'B', 'C', 'D', 'E', 'F']
print(letters)

letters[0] = 'S'
print(letters)

letters.append('L')
print(letters)

letters.insert(1, 'T')
print(letters)

'''
fruits_list=[]
fruits_list.append('사과')
fruits_list.append('바나나')
fruits_list.append('망고')
print(fruits_list)
fruits_list = fruits_list + ['수박', '자몽']
print(fruits_list)
'''

'''
letters = ['A', 'B', 'C', 'D', 'E', 'F']
print(letters)
'''

'''
city_list = ['광주', '서울', '수원', '제주']
'''

'''
def count():
    hap = 200
    print(hap)
def count1():
    print(hap)

hap = 100
count()
count1()
print(hap)
'''

'''
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
two_times = list(map(lambda x: x * 2, numbers))
print(two_times)
'''

'''
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
even_numbers = list(filter(lambda x: x % 2 == 0, numbers))
print('짝수 in the list:', even_numbers)
'''

'''
def factorial(n):
    if n == 1:
        return 1
    else:
        return n * factorial(n - 1)
result = factorial(5)
print(result)
'''

'''
print((lambda a: a + 10)(5))

add = lambda a: a + 10
print(add(5))
print(add(100))

s = lambda x: x ** 2
print(s(5))
print(s(7))
'''

'''
def power(a, b):
    print(a ** b)
power(2,5)
power(b=5, a=2)
'''

'''
def hap(n1, n2=10):
    sum = n1 + n2
    return sum
print(hap(5, 20))
print(hap(5))
'''

'''
def get_sum(start, end):
    sum = 0
    for i in range(start, end + 1):
        sum = sum + i
    return sum
print(get_sum(2, 5))
'''

'''
def add(number):
    hap = 0
    for i in range(1, number + 1):
        hap = hap + i
    print('1에서 %d까지의 합계: %d' % (number, hap))
add(3)
add(20)
add(100)
'''

'''
def sum (number):
    hap = 0
    for i in range(1, number + 1):
        hap = hap + i
    return hap

sum_result = sum(3)
print(sum_result)
print(sum(100))
print(sum(1000))
'''

'''
def gugudan(dan):
    for i in range(1, 10):
        print('%3d *%3d = %3d' % (dan, i, dan * i))
    print()

gugudan(5)
gugudan(21)
gugudan(7)
gugudan(55)
'''

'''
#1
def add(a, b):
    sum = a + b
    return sum

# 2
def say():
    print('korea')

# 3   
def hello():
    return 'hi'

# 4
def sub(a, b):
    print('%d' % (a + b))
'''

'''
def add(a, b):
    sum = a + b
    return sum

c = add(3, 5)
print(c)
'''

'''
print('실수 {}'.format(3.141592))
print('실수 {0:10.3f} and {0:10.4f}'.format(3.1415926))
'''

'''
print('{} fighting'.format('hello'))
print('I like {} and {}'.format('apple', 'orange'))
print('I like {0} and {1}'.format('apple', 'orange'))
print('I like {1} and {0}'.format('apple', 'orange'))
print('I like {0} and {0}'.format('apple', 'orange'))
print('정수 {}'.format(10))
print('정수 {} and {}'.format(10,20))
print('정수 {0:5d} and {1:5d}'.format(10,20))
'''

'''
# 1
for i in range(1, 7):
    print('*' * i)

# 2
for i in range(6, 0, -1):
    print(' ' * i + '*' * (7 - i))

# 3
for i in range(6, 0, -1):
    print('*' * i)
'''

'''
for i in range(1, 10):
    for dan in range(2, 10, 2):
        print('%2d * %2d = %2d' % (dan, i, dan * i), end=' ')
    print()
'''

'''
for dan in range(2, 10):
    for i in range(1, 10):
        text = f'{dan} * {i} = {dan * i}'
        print(text)
print()
'''

'''
for dan in range(2, 10):
    print('==== %d 단 출력 =====' % dan)
    for i in range(1, 10):
        print('%2d * %2d = %2d' % (dan, i, dan * i))
'''

'''
for i in range(1, 4):
    for j in range(11, 13):
        print('i값 : % d, j값 : %d ' % (i, j))
'''

'''
hap = 0
for i in range (1,11):
    if i % 2 == 0 or i % 3 == 0:
        continue
hap += i
print(i, end=' ')
print()
print('1~10의 합계(2의 매수와 3의배수 제외) : %d' % hap)
'''

'''
hap, i = 0, 0
for i in range(1, 11):
    if i % 3 == 0:
        continue
    hap += i
    print(i, end =' ')

print()
print('1~10의 합계(3의배수 제외) : %d' % hap)
'''
