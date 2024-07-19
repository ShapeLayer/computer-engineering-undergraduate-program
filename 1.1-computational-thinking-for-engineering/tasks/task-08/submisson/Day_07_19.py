f = open('Data/write1.txt', 'r', encoding='utf-8')
line = f.readline()
print(line)
f.close()

f = open('Data/write1.txt', 'r', encoding='utf-8')
while True:
    line = f.readline()
    if not line:
        break
    print(line)
f.close()

f = open('Data/write1.txt', 'r', encoding='utf-8')
while True:
    line = f.readline()
    if not line:
        break
    print(line.strip())
f.close()

f = open('Data/write1.txt', 'r', encoding='utf-8')
lines = f.readlines()
print(lines)
for i in lines:
    print(i.strip())
f.close()


'''
f = open('Data/subject.txt', 'w', encoding='utf-8')
subject = ['101 python \n', '102 english \n', '103 math\n', '104 art']
f.writelines(subject)
f.close()

filename = 'Data/subject.txt'
f = open(filename, 'r', encoding='utf-8')
for line in f:
    print(line.split())
f.close()

filename = 'Data/subject.txt'
f = open(filename, 'r', encoding='utf-8')
for line in f:
    result = line.split()
    print(result[1].capitalize())
f.close()
'''

'''
# 도전
f = open('Data/gugu_new.txt', 'w', encoding='utf-8')
dan = int(input('단입력 :'))
for i in range(1,10):
    data = '%d * %d = %d \n' % (dan, i, dan * i)
    f.write(data)
f.close()

f = open('Data/gugudan_new.txt', 'w', encoding='utf-8')
while True:
    dan = int(input('단입력 :'))
    if dan !=0:
        f.write(f'= {dan}단 \n')
        for i in range(1,10):
            data = '%d * %d = %d \n' % (dan, i, dan * i)
            f.write(data)
    else:
        break
f.close()


f = open('Data/gugudan_all.txt', 'w', encoding='utf-8')
for i in range(1, 10):
    for dan in range(2, 10):
        data = '%2d * %2d = %2d' % (dan, i, dan * i)
        f.write(data + ' ')
    f.write('\n')
f.close()
'''

'''
f = open('Data/write1.txt', 'w', encoding='utf-8')
f.write('hello\n')
f.write('Everyone' + '\n')
f.write('welcome to python world\n')
color = ['red', 'blue', 'green']
for i in color:
    data = '%s \n' % i
    f.write(data)
f.close()

f = open('Data/write1.txt', 'a', encoding='utf-8')
color_2 = ['gold \n', 'silver\n', 'orange\n']
f.writelines(color_2)
f.close()

f = open('Data/write2.txt', 'w', encoding='utf-8')
while True:
    data = input('데이터 입력 :')
    if data != '':
        f.write(data + '\n')
    else:
        break
f.close()

filename = 'Data/gugudan.txt'
with open(filename, 'w', encoding='utf-8') as f:
    dan = 3
    for i in range(1, 10):
        data = '%d * %d = %d \n' % (dan, i, dan * i)
        f.write(data)
'''

'''
import pandas as pd
weather = pd.read_csv('Data/weather.csv', encoding='cp949', index_col=0)
print(weather)
print(weather.head())
print(list(weather))
print(weather.info())

print(weather.describe())
print(weather.mean())
print(weather.count())

missing_data = weather[weather['평균 풍속(m/s)'].isna()]
print(missing_data)
result = weather.dropna()
print(result.count())
result1 = weather.fillna(0)
print(result1.count())
'''

'''
import pandas as pd
name = ['lee', 'hong', 'park', 'yoon']
score = [230, 250, 300, 300]
age = [19, 26, 22, 29]
df = pd.DataFrame(index=[101, 102, 103, 104])
df['이름'] = name
df['점수'] = score
df['나이'] = age
print(df)

name = ['kim', 'gong', 'choi', 'jeong']
score = [330, 350, 310, 355]
age = [24, 23, 22, 21]
df2 = pd.DataFrame(index = [201, 202, 203, 204])
df2['이름'] = name
df2['점수'] = score
df2['나이'] = age
print(df2)
'''

'''
import pandas as pd
df = pd.read_csv('Data/nations.csv', index_col=0)
print(df. head())
print(df. tail())
print(df[:3])
print(df.loc['KR'])

print(df.loc['KR', 'capital'])
print(df['capital'].loc['KR'])
print(df.loc[['KR', 'JP'], 'capital'])
print(df['capital'].loc[['KR', 'JP']])

print(df['capital'])
print(df['capital'][:3])
print(df[:3]['capital'])
df['density'] = df['population'] / df['area']
print(df)

df_s = df.sort_values('population')
print(df_s)
df.sort_values('population', inplace=True)
print(df)
print(df.describe())
print(df['GDP'].mean())
'''

'''
import pandas as pd
import matplotlib.pyplot as plt
df = pd.read_csv('Data/nations.csv', index_col=0)

import seaborn as sns
color=sns.color_palette('Set3',len(df))
df['population'].plot(kind='pie', colors=color, autopct ='%.2f%%')
plt.legend(loc='lower left')
plt.show()
'''

'''
import pandas as pd
import matplotlib.pyplot as plt
df = pd.read_csv('Data/nations.csv', index_col=0)
df['population'].plot(kind='bar', color=('b', 'darkorange', 'g', 'r', 'm'))
plt.legend()
plt.show()

import seaborn as sns
colors = sns.color_palette('Paired', len(df))
df['population'].plot(kind='pie', autopct = '%.2f%%', colors=colors)
plt.show()
'''

'''
import pandas as pd
df = pd.read_csv('Data/nations.csv')
print(df)
df = pd.read_csv('~/Desktop/python/0718/Data/nations.csv', index_col=0)
print(df)
print(list(df))

print(df['population'])
print(df[['area', 'population']])
'''

'''
import pandas as pd
name = ['lee', 'hong', 'park', 'yoon']
score = [230, 250, 300, 300]
age = [19, 26, 22, 29]
data = {'이름': name, '점수': score, '나이' : age}
df = pd.DataFrame(data, index=[101, 102, 103, 104])
print(df)

data.to_csv('Data/data1.csv')
data.to_csv('Data/data.csv', index=False)

df2 = pd.read_csv('Data/data.csv')
print(df2)

df3 = pd.read_csv('Data/data1.csv', index_col=0)
print(df3)
print(list(df3))
'''
