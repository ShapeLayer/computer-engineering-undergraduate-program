import os
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
import pandas as pd
import sklearn.datasets
import sklearn.decomposition
import sklearn.manifold
import sklearn.ensemble
import sklearn.model_selection
import sklearn.metrics

# このソースコードを動かす前提条件：データファイル(iris.csv)はこのソースコードと同じディレクトリ入れてください

# パスの解説：
# 計算機の中にあるファイル(やディレクトリ)は同じ名前のものがあると区別できないので重複は許されません
# ファイルの数が増えてくると名前の衝突が発生するので，ファイルをまとめるディレクトリを作り，ディレクトリの中にファイルを格納します
# つまり，ファイルの識別を「ディレクトリ + ファイル」で行えば名前の衝突は起きにくくなります
# ファイル，ディレクトリの数が増えてくるとディレクトリの中にディレクトリを作る必要が出てきます
# したがって，ファイルシステムは木構造(あるファイル，ディレクトリ(これらをまとめてノードといいます)の親は唯一つになる構造)です
# なお，最も上位にあるディレクトリは親を持たないので，特別なノードです．ルートといいます(木構造の根に当たります)
# このように，計算機は「ルート + ディレクトリ + ... + ディレクトリ + ファイル」でファイルを区別しています
# 言い換えると「ルートから出発してどのディレクトリを通って目的のファイルに到達するか」という道順でファイルを区別しているので，
# この道順を「パス」といいます
# 特に，ルートから記述したパスを「絶対パス」とか「フルパス」といいます
# いつも絶対パスでファイル名を記述するのは大変なので，
# 現在プログラムが利用しているディレクトリ(カレントディレクトリ)から記述したパスを「相対パス」といいます
# データが入っているファイルを Python で読み込む方法

print("カレントディレクトリ：\n", os.getcwd()) # カレントディレクトリを取得します
print("\n__file__：\n", __file__)              # __file__ にはこのソースコードの絶対パスが入っています
print("\nこのソースコードのファイル名：\n", os.path.basename(__file__))        # このソースコードのファイル名を取得します
print("\nこのソースコードのあるディレクトリ名：\n", os.path.dirname(__file__)) # このソースコードのあるディレクトリを取得します

is_full_path = True  # 絶対パスでファイルを読み込む場合
#is_full_path = False # 相対パスでファイルを読み込む場合
if is_full_path:
    dirs = __file__.split(os.sep) # 絶対パスをファイル・ディレクトリ名のリストに分けます
    #print(dirs)                  # 何をやっているかわからなかったら dirs を表示してみましょう
    dirs[-1] = "iris.csv"         # csv ファイルのファイル名に差し替えます
    #print(dirs)                  # 何をやっているかわからなかったら dirs を表示してみましょう
    path = os.sep.join(dirs)      # 絶対パスを作成します
    print("\n読み込むファイルの絶対パス：\n", path)
else:
    os.chdir(os.path.dirname(__file__)) # カレントディレクトリをこのソースコードのあるディレクトリに移動します
    print("\nカレントディレクトリを", os.getcwd(), "に移動しました．")
    path = "iris.csv" # カレントディレクトリからの相対パスを作成します
    print("\n読み込むファイルの相対パス：\n", path)

# ファイルからのデータの読み込み方法その1: NumPy を使う
a = np.loadtxt(path,                 # csv ファイルのパスを指定します
               delimiter=",",        # , を値の区切りとします
               skiprows=1,           # 1行目までをヘッダと解釈してデータを読み飛ばします
               encoding="utf-8_sig", # 文字コードを指定します
               dtype=str)            # 文字列の配列として csv ファイルを読み込みます
data = a[:,0:4].astype(float) # 第0列から第3列までを倍精度浮動小数点数の配列に変換します
target = a[:,4].astype(int)   # 第4列を整数型の配列に変換します
print("\n NumPy で読み込んだ  data  の形状：", data.shape)
print(" NumPy で読み込んだ target の形状：", target.shape)

# ファイルからのデータの読み込み方法その2: Pandas を使う
# Pandas のデータフレームは NumPy の配列よりも柔軟にデータを扱えるので前処理で利用することが多いです
df = pd.read_csv(path,            # csv ファイルのパスを指定します
                 sep=",",         # , を値の区切りとします
                 #header=None,    # 1行目にヘッダがない場合はアンコメントします
                 encoding="utf8", # 文字コードを指定します
                 dtype=str)       # 文字列のデータフレームとしてcsv ファイルを読み込みます
df_data = df.iloc[:,0:4].astype(float) # 第0列から第3列までを倍精度浮動小数点数のデータフレームに変換します
data = df_data.values                  # Pandas のデータフレームから NumPy の配列を取得します
df_target = df.iloc[:,4].astype(int)   # 第4列を整数型のデータフレームに変換します
target = df_target.values              # Pandas のデータフレームから NumPy の配列を取得します
print("Pandas で読み込んだ  data  の形状：", data.shape)
print("Pandas で読み込んだ target の形状：", target.shape)

# ファイルからのデータの読み込みに失敗した人は以下をアンコメントして iris データを取得してください
# dataset = sklearn.datasets.load_iris()
# data = dataset.data
# target = dataset.target

#%% iris データセットから不均衡データを作ります
id1 = np.arange(50,100)  # versicolor から抽出するインデックスを作ります
id2 = np.arange(100,150) # virginica から抽出するインデックスを作ります
#np.random.seed(seed=7)   # 乱数の種を指定します
np.random.shuffle(id1)   # データをシャッフルします
np.random.shuffle(id2)   # 使用データを固定したい場合はコメントアウト
id_train = np.array(list(id1[:40]) + list(id2[:5]))  # 負例40個，正例5個
id_test = np.array(list(id1[40:]) + list(id2[5:10])) # 負例10個，正例5個
# 訓練データとテストデータに分けます
X_train = data[id_train]
X_test = data[id_test]
y_train = target[id_train] - 1 # iris データのクラス番号が setosa == 0, versicolor == 1, virginica == 2 であり，
y_test = target[id_test] - 1   # setosa は使わないので，クラス番号を versicolor == 0, virginica == 1 に変更します

print("次元削減前の X_train の形状：", X_train.shape)
print("次元削減前の X_test  の形状：", X_test.shape)

# データを無次元化します
#scaler = sklearn.preprocessing.StandardScaler() # 標準化
#scaler = sklearn.preprocessing.MinMaxScaler()   # [0,1] に正規化
scaler = sklearn.preprocessing.RobustScaler()   # ロバストスケーリング
X_train = scaler.fit_transform(X_train)         # 訓練データからスケールを学習
X_test = scaler.transform(X_test)               # テストデータを無次元化します

# 次元削減を行います(分類器の性能を上げる目的ではなく使い方の例です)
reduction = sklearn.decomposition.PCA(n_components=2) # 主成分を2つ求めます
#reduction = sklearn.manifold.Isomap(n_components=2) # 座標を2つ求めます
X_train = reduction.fit_transform(X_train)  # 次元を下げたデータに変換します
X_test = reduction.transform(X_test)

print("次元削減した X_train の形状：", X_train.shape)
print("次元削減した X_test  の形状：", X_test.shape)

#%% 分類器を作成します
models = sklearn.ensemble.RandomForestClassifier()
parameters = {"n_estimators":[2,4,10,20,50,100], "max_depth":[2,4,10,20,50]} # RF に渡すパラメータ
#models = sklearn.ensemble.GradientBoostingClassifier(max_depth=3, min_samples_split=2, min_samples_leaf=1, subsample=1)
#parameters = {"n_estimators":[2,4,10,20,50,100,200], "learning_rate":np.logspace(-3,-0.5,5)} # GBDT に渡すパラメータ

# 学習時のサンプルの重みを調整するための配列を作ります
weight = sklearn.utils.class_weight.compute_sample_weight({0:1.0, 1:10.0}, y_train) # クラス0の重みを1.0, クラス1の重みを10.0にします
#weight = sklearn.utils.class_weight.compute_sample_weight("balanced", y_train) # y_train の 0 と 1 の数から重みを自動で調整します

# パラメータをグリッドサーチし，スコア(scoring で決めます)が最も高いモデルを探します
scv = sklearn.model_selection.GridSearchCV(models, parameters, scoring="roc_auc", cv=2, n_jobs=-1)
scv.fit(X_train, y_train, sample_weight=weight) # サンプルの重みが大きいものを重視して学習します
clf = scv.best_estimator_ # scoring で指定したスコアが最も高かった分類器を採用します
print("ベストパラメータ：", scv.best_params_)
print("ベストスコア：", scv.best_score_)

# グリッドサーチで学習したすべての分類器のスコアを描画します
# スコアの可視化を諦めれば parameters にもっと多種のパラメータを指定できます
key_list = list(parameters.keys())
x = [d[key_list[0]] for d in scv.cv_results_["params"]]
y = [d[key_list[1]] for d in scv.cv_results_["params"]]
z = scv.cv_results_["mean_test_score"]
fig, ax = plt.subplots()
cax = ax.scatter(x, y, c=z, s=500*z, vmin=max(z)*0.8, vmax=1, cmap=matplotlib.colormaps["brg"])
fig.colorbar(cax)
ax.set_xscale("log")
ax.set_yscale("log")
ax.set_xlabel(key_list[0], fontsize=20)
ax.set_ylabel(key_list[1], fontsize=20)
ax.set_title("CV score", fontsize=20)
plt.show()

# テストデータで分類器の汎化性能を調べます
print("===== 汎化性能 =====")
y_predict = clf.predict(X_test)
cm = sklearn.metrics.confusion_matrix(y_test, y_predict)
print("混同行列：")
print(cm)
print("確度：", sklearn.metrics.accuracy_score(y_test, y_predict))
print("ROC AUC:", sklearn.metrics.roc_auc_score(y_test, y_predict))
print("F1:", sklearn.metrics.f1_score(y_test, y_predict))
print("再現率：", sklearn.metrics.recall_score(y_test, y_predict))
print("精度：", sklearn.metrics.precision_score(y_test, y_predict))




