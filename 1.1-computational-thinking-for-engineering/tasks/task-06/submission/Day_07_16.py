import numpy as np
players = [[170, 76.4],
           [183, 86.2],
           [181, 78.5],
           [176, 80.1]]

np_players = np.array(players)
print('몸무게가 80 이상인 선수 정보')
print(np_players[np_players[:, 1] >= 80])

print('키가 180 이상인 선수 정보')
print(np_players[np_players[:, 0] >= 180])

'''
import numpy as np
y = np.arange(1, 17).reshape(4, 4)
print(y[2, 3])
print(y > 5)
print(y[y > 5])

print(y % 2 == 0)
print(y[y % 2 == 0])

print(y[0])
print(y[1])
print(y[2])
print(y[3])

print(y[1:3])

print(y[:, 1] > 5)
print(y[y[:, 1] > 5])
'''

'''
# 도전
import numpy as np

ages = np.array([18, 19, 25, 30, 28])
even = ages [ages % 2 == 0]
'''

'''
import numpy as np
a = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
aa = np.array(a)
print(aa)
print(aa[0, 2])

a = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]]
b = np.array(a)
print(b[0])
print(b[1, :])
print(b[:, 2])
print(b[0:2, 0:2])

a = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]]
b = np.array(a)
print(b[::2,::2])
print(b[1::2, 1::2])

data_a = np.array(range(1, 6))
print(data_a)
data_b = np.arange(1, 6)
print(data_b)

x = np.arange(12)
print(x)
y = x.reshape(3, 4)
print(y)
z = y.flatten()
print(z)

print(np.random.rand(5))
print(np.random.rand(5, 3))
print(np.random.randint(1, 10, size=10))
print(np.random.randint(1, 100, size=(3, 5)))

data = np.random.randint(1, 10, size=15)
print(np.mean(data))
print(np.median(data))
print(data.sum())
'''

'''
import numpy as np

scores = np.array([ 10, 20, 30, 40 ])
mid_scores = [10, 20, 30]
final_scores = [70, 80, 90]
total = mid_scores + final_scores

mid_scores = np.array([10, 20, 30])
final_scores = np.array([70, 80, 90])
total = mid_scores + final_scores
print('합계 :', total)

a = np.array([1, 2, 3, 4, 5])
print(a.ndim)
print(a.shape)
print(a.size)
print(a.dtype)
print(a.itemsize)

b = np.array([[1, 2, 3], [4, 5, 6]])
print(b)
print(len(b))
print(len(b[0]))
print(len(b[1]))

print('shape :', b.shape)
print('ndim :', b.ndim)
print('dtype :', b.dtype)
print('size :', b.size)
print('itemsize :', b.itemsize)

salary = np.array([320, 350, 430])
salary = salary + 300
print(salary)
salary = salary * 3
print(salary)

score = np.array([88, 72, 93, 90, 80, 88, 99])
print(score[2])
print(score[-1])
print(score[1:4])
print(score[4:-1])

ages = np.array([18, 19, 28, 38, 27])
y = ages > 20
print(y)
result = ages[ages > 20]
print(result)
'''

'''
phone = '010.1234.5667, 010.234.5555, 010.333.4321'
print(['-'.join(each.split('.')) for each in phone.split(', ')])
'''

'''
s = ' nice world happy family '
for each in s.split():
    print(each[0].capitalize() + each[1:].lower())
'''

'''
s = 'only, actions, gives, life, strength'
last_word = []
word = s.split(',')
for i in word:
    last_word.append(i.strip())
print(last_word)

for i in last_word:
    print(i.capitalize())
'''

'''
s = 'this, is, my, friend, python'
last_word = []
word = s.split(',')
for i in word:
    last_word.append(i.strip())
print(last_word)
'''

'''
fruits = ['apple', 'grape', 'banana']
print('-'.join(fruits))
print('*'.join(fruits))
'''

'''
s = ' welcome to the python world '
print(s.split())
s = 'hello, my good, friend '
print(s.split(','))
'''

'''
s = 'Hello, World'
print(s.lower())
print(s.upper())
print(s.capitalize())

ss = '#####this is an apple#####'
ss1 = ss.strip('#')
print(ss1.capitalize())
'''

'''
s = ' hello, world!!! '
print(s.strip())
print(s.lstrip())
print(s.rstrip())
'''

'''
a = 'black coffee'
print(a.count('e'))
print(a.find('c'))
print(a.find('s'))
print(a.index('k'))
print(a.index('s'))
'''

'''
text = 'korea fighting'
left_text = text.ljust(30)
print(left_text)
right_text = text.rjust(30)
print(right_text)
center_text = text.center(30)
print(center_text)
'''

'''
name = 'korea'
age = 20
s = f'이름: {name}, 나이: {age}세'
print(s)
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
print('정수 {} and {}'.format(10, 20))
print('정수 {0:5d} and {1:5d}'.format(10, 20))
'''

'''
print('I eat %d apples' % 3)
print('I eat %d apples' % (3))
print('I eat 3 %s' % ('apples'))
print('I eat %d %s' % (3, 'apples'))
number = 3
print('I eat %d %s' % (number, 'apples'))
'''

'''
s = "nice world happy family"
s1 = s[0:4]
s2 = s[:4]
s3 = s[:-19]
s4 = s[11:16]
s5 = s[-12:-7]
s6 = s1 + s4
print(s6)
'''

'''
letters='ABCDEF'
print(letters)
print(letters[0:3])
print(letters[:3])
print(letters[3:])
print(letters[:])
'''

'''
letters="ABCDEF"
print(letters)
print(letters[1])
print(letters[-1])
print(letters[0])
print(letters[-0])
'''

txt2 = 'happy life'
txt1 = "hello world"
txt3 = """love changes everything"""
txt4 = '''life is too short'''
st1 = """
life is too short
I love korea
"""
st2 = '''
life is too short
I love korea
'''
