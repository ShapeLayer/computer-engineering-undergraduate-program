import numpy as np
import sklearn.preprocessing
import sklearn.impute
import sklearn.datasets

#%% 平均，分散，標準偏差を計算しよう！ 
iris = sklearn.datasets.load_iris()
X = iris.data
print("花弁の長さの平均は", np.mean(X[:,2]), "[cm] です．")
print("花弁の長さの分散は", np.var(X[:,2]), "[cm^2] です．")
print("花弁の長さの標準偏差は", np.std(X[:,2]), "[cm] です．")
print("最初のサンプルは", X[0], "で，平均は", np.mean(X[0]), "です．")

print("花弁の長さの単位を [mm] に変更します．")
X[:,2] *= 10 # 第2列の要素すべてを10倍します
print("花弁の長さの平均は", np.mean(X[:,2]), "[mm] です．")
print("花弁の長さの分散は", np.var(X[:,2]), "[mm^2] です．")
print("花弁の長さの標準偏差は", np.std(X[:,2]), "[mm] です．")
print("最初のサンプルは", X[0], "で，平均は", np.mean(X[0]), "です．")


#%% 標準化
scaler = sklearn.preprocessing.StandardScaler() # 標準化を行うオブジェクトを作ります
scaler.fit(X) # 行列 X の各列の平均と標準偏差を求めます
print("データ X の各列の平均は", scaler.mean_)
print("データ X の各列の標準偏差は", scaler.scale_)
Y = scaler.transform(X) # X を標準化した行列を求めます
print("Y[:,2] の平均は", np.mean(Y[:,2]), "標準偏差は", np.std(Y[:,2]))
Z = scaler.inverse_transform(Y) # 標準化した行列の逆変換を求めます
print("X と Z との絶対誤差の最大値は", np.max(np.abs(X-Z)))


#%% 正規化(MinMaxスケーリング)
scaler = sklearn.preprocessing.MinMaxScaler() # [0,1] に入る正規化を行うオブジェクトを作ります
scaler.fit(X) # 行列 X の各列の最大値や最小値を求めます
print("データ X の各列の最大値は", scaler.data_max_)
print("データ X の各列の最小値は", scaler.data_min_)
Y = scaler.transform(X) # X を正規化した行列を求めます
print("Y[:,2] の最大値は", np.max(Y[:,2]), "最小値は", np.min(Y[:,2]))
Z = scaler.inverse_transform(Y) # 正規化した行列の逆変換を求めます
print("X と Z との絶対誤差の最大値は", np.max(np.abs(X-Z)))


#%% 正規化(MaxAbsスケーリング)
scaler = sklearn.preprocessing.MaxAbsScaler() # [-1,1] に入る正規化を行うオブジェクトを作ります
scaler.fit(X) # 行列 X の各列の絶対値の最大値を求めます
print("データ X の各列の絶対値の最大値は", scaler.max_abs_)
Y = scaler.transform(X) # X を正規化した行列を求めます
print("Y[:,2] の最大値は", np.max(Y[:,2]), "最小値は", np.min(Y[:,2]))
Z = scaler.inverse_transform(Y) # 正規化した行列の逆変換を求めます
print("X と Z との絶対誤差の最大値は", np.max(np.abs(X-Z)))


#%% ロバストスケーリング
scaler = sklearn.preprocessing.RobustScaler() # ロバストスケーリングを行うオブジェクトを作ります
scaler.fit(X) # 行列 X の各列の四分位数を学習します
print("データ X の各列の Q2 (中央値) は", scaler.center_)
print("データ X の各列のスケール (Q3-Q1) は", scaler.scale_)
Y = scaler.transform(X) # X をロバストスケーリングした行列を求めます
print("Y[:,2] の四分位数は", np.percentile(Y[:,2], q=[0, 25, 50, 75, 100]))
Z = scaler.inverse_transform(Y) # ロバストスケーリングした行列の逆変換を求めます
print("X と Z との絶対誤差の最大値は", np.max(np.abs(X-Z)))


#%% 補足：アルゴリズムの切り替え
# scikit-learn のクラスは仕様が統一されているので，次のような記述が可能です
alg = "MinMax" # アルゴリズムを表す文字列を代入します
scaler = {"MinMax":sklearn.preprocessing.MinMaxScaler(),
          "MaxAbs":sklearn.preprocessing.MaxAbsScaler(),
          "標準化":sklearn.preprocessing.StandardScaler(),
          "Robust":sklearn.preprocessing.RobustScaler()}[alg]
scaler.fit(X)
Y = scaler.transform(X) # alg で指定したアルゴリズムで無次元化します
print("Y[0] = ", Y[0])
# 問：アルゴリズムを変えると Y[0] の値が変わるか確認しましょう．


#%% 欠損値のある行を破棄しよう！
X = np.array([[2, 6, 3], [None, 4, 6], [7, 5, 9]], dtype=float)
print("X = \n", X)
Y = X[~np.isnan(X).any(axis=1),:] # 欠損値のない行から成る部分行列を作成します
print("Y = \n", Y)
# 問：欠損値のある列を破棄するプログラムを書いてみましょう．


#%% 欠損値を予測しよう！
X = np.array([[2, 6, 3], [None, 4, 6], [7, 5, 9], [0, 5, -2]], dtype=float)
print("X = \n", X)
imp = sklearn.impute.SimpleImputer(missing_values=np.nan, strategy="mean")
imp.fit(X) # X の各列の平均を学習します
print("データ X の各列の平均は", imp.statistics_)
Y = imp.transform(X) # np.nan に平均を代入します
print("Y = \n", Y)
# 問：np.nan に中央値を代入するプログラムを書いてみましょう．





