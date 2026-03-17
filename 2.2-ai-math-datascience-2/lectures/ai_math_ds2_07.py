import numpy as np
import matplotlib.pyplot as plt
import sklearn.datasets
import sklearn.model_selection
import sklearn.linear_model
import sklearn.tree

# データの読み込み
dataset = sklearn.datasets.load_linnerud()
#dataset = sklearn.datasets.load_diabetes()

# 訓練データとテストデータに分けます
X_train, X_test, y_train, y_test = sklearn.model_selection.train_test_split(
               dataset.data, dataset.target, test_size=0.25)#, random_state=7)

# データの無次元化
#scaler = sklearn.preprocessing.StandardScaler() # 標準化
scaler = sklearn.preprocessing.MinMaxScaler()   # [0,1] 正規化
#scaler = sklearn.preprocessing.MaxAbsScaler()   # [-1,1] 正規化
#scaler = sklearn.preprocessing.RobustScaler()   # ロバストスケーリング
X_train = scaler.fit_transform(X_train) # X_train を学習し，無次元化したデータを戻します
y_scaler = sklearn.preprocessing.MinMaxScaler()
y_train = y_scaler.fit_transform(y_train) # 教師データの無次元化

#%% 回帰器の学習
reg = sklearn.linear_model.LinearRegression() # 最小二乗法
#reg = sklearn.linear_model.Ridge(alpha=0.1)   # Ridge 回帰
#reg = sklearn.linear_model.Lasso(alpha=0.01)  # Lasso 回帰
#reg = sklearn.tree.DecisionTreeRegressor(criterion="squared_error", max_depth=2, min_samples_split=2, min_samples_leaf=1)#, #random_state=7) # 回帰木
reg.fit(X_train, y_train) # 訓練データに合う関数を見つけます

# 回帰器の性能評価
X_test_nd = scaler.transform(X_test)   # X_train の学習結果を利用し，X_test を無次元化します
y_test_nd = y_scaler.transform(y_test) # y_train の学習結果を利用し，y_test を無次元化します
print("       reg.score = ", reg.score(X_test_nd, y_test_nd)) # 予測の決定係数を表示します
y_predict_nd = reg.predict(X_test_nd)                         # テストデータに対する予測を行います
r2 = sklearn.metrics.r2_score(y_test_nd, y_predict_nd)        # 正解と予測を使って決定係数を計算することもできます
print("決定係数(無次元) = ", r2)                              # reg.score と同じ値になります
y_predict = y_scaler.inverse_transform(y_predict_nd)          # 単位が付いた予測にはスケーリングの逆変換が必要です
print("        決定係数 = ", sklearn.metrics.r2_score(y_test, y_predict)) # スケーリングしても決定係数は変わりません
print("y_test = ")
print(y_test)
print("y_predict = ")
print(y_predict)

#%% 演習問題
print("(1) 最小二乗法で求めた一次関数の重みとバイアスの値を調べてください．")

print("(2) Ridge 回帰と Lasso 回帰で alpha = 0 としたときの重みとバイアスは最小二乗法で求めた重みとバイアスに一致することを確かめてください．")

print("(3) Ridge 回帰で alpha を調整して最小二乗法よりも汎化性能(スコア)が高くなる alpha を探してください．")

print("(4) Lasso 回帰で alpha を大きくすると重みが 0 となることを確かめてください．")

print("(5) Lasso 回帰で alpha を 0 から徐々に大きくしていくと重みが 0 に収束する順番がわかります．一番最後に 0 になる素性を求めてください．")

print("(6) このソースコードでは X_train と y_train の両方を無次元化して回帰器を作っていますが，実は，y_train の方は無次元化が不要であることを確かめてください．")









