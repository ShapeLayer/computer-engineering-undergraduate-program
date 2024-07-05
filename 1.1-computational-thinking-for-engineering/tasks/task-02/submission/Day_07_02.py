score = int(input('성적을 입력: '))

if score >= 90:
    print('합격입니다.')
    print('장학금도 받을 수 있어요')
else:
    print('불합격입니다.')
    print('파이팅하세요')

'''
import random
print(random.random())
print(random.randint(1, 7))
print(random.randrange(7))
print(random.randrange(1, 7))
print(random.randrange(0, 10, 2))
'''

'''
print(list(range(0, 5, 1)))
print(list(range(0, 5)))
print(list(range(5)))
print(list(range(1, 11, 2)))
'''

'''
no1 = 1.457
no2 = 1.557
print('%s : 반올림 후 데이터 값 %s' % (no1, round(no1)))
print('%s : 반올림 후 데이터 값 %s' % (no2, round(no2)))
print('%s : 반올림 후 데이터 값 %s' % (no1, round(no1, 1)))
print('%s : 반올림 후 데이터 값 %s' % (no2, round(no2, 2)))
'''

'''
weight = float(input('몸무게를 kg 단위로 입력: '))
height = float(input('키를 미터 단위로 입력: '))
bmi = (weight / (height ** 2))
print('당신의 BMI =', bmi)
'''

'''
print(4 << 1)
print(4 << 2)
print(2 << 4)
print(16 >> 2)
print(9 >> 2)
'''

'''
print(bin(9))
print(bin(10))
print(bin(9 & 10))
print(bin(9 | 10))
print(bin(9 ^ 10))
print(9 ^ 10)
'''

'''
print(bool(0))
print(bool(99))
print(bool(-12.3))
print(bool(''))
print(bool('abc'))
'''

'''
a = 15
print( (a >= 10) and (a<=19) )
print( (a <= 10) or (a<=19) )
print(not(a >= 10))
'''

'''
a = 10
b = 7
print(a, b)
print('a > b:', a > b)
print('a >= b:', a >= b)
print('a < b:', a < b)
print('a <= b:', a <= b)
print('a == b:', a == b)
print('a != b:', a != b)
print('-' * 20)
'''

'''
bottom = float(input('밑변:'))
height = float(input('높이:'))
a = (bottom ** 2 + height ** 2) ** .5
print('빗변의 길이는 :', a)
'''

'''
data = input('5글자 입력: ')
r_data = data[4] + data[3] + data[2] + data[1] + data[0]
print(data)
print(r_data)
'''

'''
n = int(input('두 자리 정수 입력: '))

a = n // 10
b = n % 10

reverse = b * 10 + a 
sum = n + reverse

print('원본 데이터:', n)
print('역순 데이터:', reverse)
print('두 수의 합:', sum)
'''

'''
a = 2
b = 3

print('a + b =', a + b)
print('a - b =', a - b)
print('a * b =', a * b)
print('a / b =', a / b)
print('a // b =', a // b)
print('a % b =', a % b)
print('a ** b =', a ** b)
'''
