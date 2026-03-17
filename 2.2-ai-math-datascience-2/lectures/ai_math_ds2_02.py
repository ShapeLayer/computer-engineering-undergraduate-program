import numpy as np
import matplotlib.pyplot as plt
import sklearn.datasets

#%% NumPy 配列を使ってみよう！
m = 3
n = 5
a = np.array([[10*i + j for j in range(n)] for i in range(m)])

#%% iris データセットを見てみよう！
iris = sklearn.datasets.load_iris()
print(iris.feature_names) # 素性の名前を表示します．sepal:萼, petal:花弁
print(iris.target_names)  # クラスの名前を表示します．
print(f"iris のデータは {iris.data.shape} 行列です．")
print(f"iris のクラスは {iris.target.shape} 次元のベクトルです．")
#print("実際に iris のデータを表示すると\n", iris.data) # 150x4 行列を表示します
#print("実際に iris のクラスを表示すると\n", iris.target) # 150 次元ベクトルを表示します
#print(iris.DESCR) # iris データセットの詳細な説明を表示します

n = 60 # n 番目のサンプルのより具体的な説明です
x = iris.data[n]   # 行列の第 n 行を取り出して x に代入します
y = iris.target[n] # ベクトルの第 n 成分を取り出して y に代入します
t = iris.target_names[y] # 第 n サンプルのクラス名を取得します
print(f"iris データセットの{n}番目のサンプルの素性は{x}，クラスは{y}です．")
print(f"つまり，萼の長さ{x[0]}cm,萼の幅{x[1]}cm,花弁の長さ{x[2]}cm,花弁の幅{x[3]}cmの{t}です．")

x = iris.data[:,0] # 行列の第 0 列を取り出して x に代入します
y = iris.data[:,1] # 行列の第 1 列を取り出して x に代入します
plt.scatter(x, y, alpha=0.5, c=iris.target) # 散布図を描きます
#plt.savefig("iris_scatter.pdf") # 画像を保存したいときはアンコメントしてください
plt.show() # 図を表示します

#%% digits データセットを見てみよう！
digits = sklearn.datasets.load_digits()
print(digits.feature_names) # 素性の名前を表示します
print(digits.target_names)  # クラスの名前を表示します
print(f"digits のデータは {digits.data.shape} 行列です．")
print(f"digits のクラスは {digits.target.shape} 次元のベクトルです．")
#print(digits.DESCR) # digits データセットの詳細な説明を表示します

n = 71 # n 番目のサンプルを可視化してみます
x = digits.data[n]    # 行列の第 n 行を取り出します ※64次元ベクトルです
print(x)
X = x.reshape([8,8]) # 8x8 行列に変換します
print(X)
plt.matshow(X, cmap=plt.cm.gray) # 行列 X を濃淡図として描きます
#plt.savefig("digits.pdf") # 画像を保存したいときはアンコメントしてください
plt.show() # 図を表示します

#%% diabetes データセットを見てみよう！ 
diabetes = sklearn.datasets.load_diabetes()
print(diabetes.feature_names) # 素性の名前を表示します
print(f"diabetes のデータは {diabetes.data.shape} 行列です．")
print(f"diabetes のターゲットは {diabetes.target.shape} 次元のベクトルです．")
#print(diabetes.DESCR) # diabetes データセットの詳細な説明を表示します

#%% linnerud データセットを見てみよう！ 
linnerud = sklearn.datasets.load_linnerud()
print(linnerud.feature_names) # 素性の名前を表示します
print(linnerud.target_names)  # 目的変数の名前を表示します
print(f"diabetes のデータは {linnerud.data.shape} 行列です．")
print(f"diabetes のターゲットは {linnerud.target.shape} 行列です．")
#print(linnerud.DESCR) # linnerud データセットの詳細な説明を表示します




