data =[['apple', 100, 10], ['orange', 200, 20], ['cherry', 300, 30]]
hap = 0
for each in data:
    hap += each[2]
print(hap)

data =[[1, 2, 3], [10, 20], [1000, 2000, 3000, 4000], [1, 3, 5, 7, 9, 11]]
hap = 0
for row in data:
    for each in row:
        hap = hap + each
print(hap)

hap = 0
for row in data:
    hap += sum(row)
print(hap)

'''
list_1 = [['apple', 100], ['orange', 200]]
print(list_1)
print(list_1[0])
print(list_1[1])

print(list_1[0][0])
print(list_1[0][1])
print(list_1[1][0])
print(list_1[1][1])
'''

'''
s = ['hello', '123', 'world', '567']
numbers = [x for x in s if x.isdigit()]
print(numbers)
'''

'''
[i ** 2 for i in [1, 2, 3, 4, 5, 6]]
print([i+2 for i in range(10)])

print([i for i in range(1,10) if i %2 == 0])
'''

'''
word = input('문자열을 입력하세요 : ')
size = len(word)
for i in range(1, size + 1):
    print(word[:i])
'''

'''
strings = 'I love Coffee'
print(strings.upper())
print(strings.lower())
print(strings.capitalize())
'''

'''
a = [1, 9, 11, 99, 33, 55]
print(len(a))
print(max(a))
print(min(a))
print(sum(a))
'''

'''
letters = ['A', 'B', 'C', 'D', 'E', 'F']
print(letters)
print(letters[0:3])
print(letters[:3])
print(letters[3:])
print(letters[:])

print(letters[0:3])
print(letters[0:3:1])
print(letters[0:3:2])
print(letters[::2])
print(letters[::3])
print(letters[::-1])
print(letters[::-2])
'''

'''
print(list(range(0, 5, 1)))
print(list((range(0, 5)))
print(list((range(5)))
print(list((range(1, 11, 2)))

list_1 = list(range(1, 5, 3))
print(list_1)

list_2 = list(range(2, 5, 2))
print(list_2)

list_3 = list_2 * 3
print(list_3)

list_4 = [1, 2, 3] + [4, 5, 6]
print(list_4)
'''

'''
letters=['A', 'B', 'C', 'D', 'E', 'F']
print(letters)

letters[0] = 'S'
print(letters)

letters.append('L')
print(letters)

letters.insert(1, 'T')
print(letters)

letters.remove("B")
print(letters)

del letters[2]
print(letters)

letters.pop()
print(letters)

if "D" in letters:
    letters.remove("D")
print(letters)
'''