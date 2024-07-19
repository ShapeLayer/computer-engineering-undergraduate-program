import pandas as pd
name = ['lee', 'hong', 'park', 'yoon']
score = [230, 250, 300, 300]
age = [19, 26, 22, 29]
data_df = pd.DataFrame(index=[101,102,103,104])
data_df['이름'] = name
data_df['점수'] = score
data_df['나이'] = age
print(data_df)

'''
import pandas as pd
s = pd.Series(
    [100, 90.8, 96, 80, 70],
    index=['학생1', '학생2', '학생3', '학생4', '학생5']
)

print(s['학생4'])
print(s[3])
print(s[['학생1', '학생3']])
print(s[::2])

name = ['이순신', '김만덕', '홍길동']
gender = ['남', '여', '남']
age = [25, 40, 18]
first = pd.DataFrame()
first['이름'] = name
first['성별'] = gender
first['나이'] = age
print(first)
'''

'''
import pandas as pd
name = pd.Series(['이순신', '김만덕', '홍길동', '강산'])
print(name)
name_1 = pd.Series(
    ['이순신', '김만덕', '홍길동', '강산'],
    index=['학생1', '학생2', '학생3', '학생4']
)
print(name_1)
'''

'''
import matplotlib.pyplot as plt
import seaborn as sns
fig, ax = plt.subplots(2, 2, figsize=(7, 7))
x = [x for x in range(7, 13)]
y = [456, 492, 578, 599, 670, 854]
colors = sns.color_palette('BuGn', len(y))
ax[0, 0].bar(x, y, color=colors)
ax[0, 1].plot(x, y, color='yellowgreen', marker='^')
ax[1, 0].scatter(x, y, color='skyblue')
ax[1, 1].barh(x, y, color=colors)
plt.show()
'''

'''
import matplotlib.pyplot as plt
import seaborn as sns
fig, ax = plt.subplots(1, 4, figsize=(10, 3))
x = [x for x in range(7, 13)]
y = [456, 492, 578, 599, 670, 854]
colors = sns.color_palette('Blues', len(y))
ax[0].bar(x, y , color=colors)
ax[1].plot(x, y, color='yellowgreen', marker='^')
ax[2].scatter(x, y, color='skyblue')
ax[3].barh(x, y, color=colors)
plt.show()
'''

'''
import matplotlib.pyplot as plt
times = [7, 8, 9]
timelabels = ['Sleep', 'Study', 'the others']
c = ['gold', 'skyblue', 'yellowgreen']
plt.pie(
    times, labels=timelabels, autopct='%.2f',
    counterclock=False, startangle=90,
    colors=c
)
plt.show()
'''

'''
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
x = np.arange(20, 50)
y = np.random.randint(0, 30, size=30)
colors = sns.color_palette('hls', len(x))
plt.scatter(x, y, color=colors)
plt.title('SCATTER', fontsize=25)
plt.show()
'''

'''
from matplotlib import pyplot as plt
years = [1965, 1975, 1985, 1995, 2005, 2015]
ko = [130, 650, 2450, 11600, 17790, 27250]
jp = [890, 5120, 11500, 42130, 40560, 38780]
ch = [100, 200, 290, 540, 1760, 7940]

import numpy as np
x_range = np.arange(len(years))
plt.bar(x_range + 0.0, ko, width = 0.3, label='Korea', color='skyblue')
plt.bar(x_range + 0.3, jp, width = 0.3, label='Japan', color='gold')
plt.bar(x_range + 0.6, ch, width = 0.3, label='China', colr='silver')
plt.xticks(range(len(years)), years)
plt.title('GDP per capita')
plt.ylabel('dollars')
plt.show()
'''

'''
import matplotlib.pyplot as plt
years = [1960, 1970, 1980, 1990, 2000, 2010, 2020]
gdp = [80.0, 257.0, 1686.0, 6505, 11865.3, 22105.3, 33591.0]

import seaborn as sns
colors = sns.color_palette('hls', len(years))
plt.barh(range(len(years)), gdp, color=colors)
plt.yticks(range(len(years)), years)
plt.title('KOREA GDP', fontsize=25)
plt.xlabel('dollar')
plt.ylabel('year')
plt.show()
'''

'''
import matplotlib.pyplot as plt
years = [1960, 1970, 1980, 1990, 2000, 2010, 2020]
gdp = [80.0, 257.0, 1686.0, 6505, 11865.3, 22105.3, 33591.0]

colors = ['black', 'dimgray', 'darkgray', 'silver', 'lightgray', 'skyblue', 'yellowgreen']
plt.bar(range(len(years)), gdp, color=colors)
plt.xticks(range(len(years)), years)
plt.title('KOREA GDP', fontsize=25)
plt.ylabel('dollars')
plt.xlabel('year')

plt.show()

import seaborn as sns

colors = sns.color_palette('Set3', len(years))
colors = sns.color_palette('RdPu', len(years))
colors = sns.color_palette('RdBu', len(years))
colors = sns.color_palette('Paired', len(years))
colors = sns.color_palette('hls', len(years))
plt.bar(range(len(years)), gdp, color=colors)

plt.show()
'''

'''
import matplotlib.pyplot as plt
years = [1960, 1970, 1980, 1990, 2000, 2010, 2020]
gdp = [80.0, 257.0, 1686.0, 6505, 11865.3, 22105.3, 33591.0]

plt.plot(years, gdp, color='orange', marker='o', linestyle='solid')
plt.title('KOREA GDP')
plt.ylabel('dollar')
plt.xlabel('years')
plt.show()
'''

'''
import matplotlib.pyplot as plt
data1 = [3, 5, 7, 9]
data2 = [8, 6, 4, 2]
plt.title('Line Graph')
plt.plot(data1, color='orange', marker='o', label='happy')
plt.plot(data2, color='b', marker='^', label='stress')
plt.legend()
plt.show()
'''

'''
import matplotlib.pyplot as plt
xdata = [3, 5, 7, 9]
ydata = [2, 4, 6, 8]
plt.title('Line Graph')
plt.plot(xdata, ydata, color='g', linestyle=':')
plt.xlabel('X value')
plt.ylabel('Y value')
plt.show()
'''

'''
import matplotlib.pyplot as plt
xdata = [3, 5, 7, 9]
ydata = [2, 4, 6, 8]
plt.title('Line Graph')
plt.plot(xdata,ydata, color='g')
plt.show()
'''