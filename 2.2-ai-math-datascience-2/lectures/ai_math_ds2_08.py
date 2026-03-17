import matplotlib.pyplot as plt
import sklearn.datasets
import sklearn.model_selection
import sklearn.neural_network

# データの読み込み
dataset = sklearn.datasets.load_iris()
#dataset = sklearn.datasets.load_digits()

# 訓練データとテストデータに分けます
X_train, X_test, y_train, y_test = sklearn.model_selection.train_test_split(
               dataset.data, dataset.target, test_size=0.25)#, random_state=7)

# データの無次元化(NNでは無次元化が必須です)
#scaler = sklearn.preprocessing.StandardScaler() # 標準化
scaler = sklearn.preprocessing.MinMaxScaler()   # [0,1] 正規化
#scaler = sklearn.preprocessing.MaxAbsScaler()   # [-1,1] 正規化
#scaler = sklearn.preprocessing.RobustScaler()   # ロバストスケーリング
X_train = scaler.fit_transform(X_train) # X_train を学習し，無次元化したデータを戻します

#%% 多層パーセプトロンモデル
clf = sklearn.neural_network.MLPClassifier(
        # モデルに関するパラメータ
        hidden_layer_sizes=(4,2,4), # 隠れ層のニューロン数をタプルで指定します
        #activation="relu",         # 隠れ層の活性化関数を指定します(デフォルト"relu")
        #activation="logistic",     # 隠れ層の活性化関数にシグモイド関数を使います
        #activation="tanh",         # 隠れ層の活性化関数に双曲線正接関数を使います
        #activation="identity",     # 隠れ層の活性化関数に恒等写像を使います
        # 最小化問題に関するパラメータ
        alpha=1.0e-6,               # L2 安定化項の係数を指定します
        # 最適化手法に関するパラメータ
        tol=1.0e-4,                 # 損失変化量の許容範囲を指定します
        #n_iter_no_change=10,       # 損失が n_iter_no_change 回連続で tol よりも小さくなれば収束したとみなします
        max_iter=100,               # 最大反復回数を指定します．この回数までに収束しなければ警告メッセージを出します
        solver="adam",              # 最適化手法を指定します(デフォルト"adam")
        #solver="sgd",              # 確率的勾配降下法を使います
        #batch_size="auto",         # 損失関数を計算する際に使用するデータサイズを指定します
        #shuffle=True,              # 各反復でサンプルをシャッフルするか指定します
        learning_rate_init=0.01,    # 初期学習率を指定します．重みを更新する際の大きさを制御します
        #learning_rate="constant",  # SGDでの重みの更新方法を指定します．"constant"では学習率を常に learning_rate_init にします
        #learning_rate="invscaling",# 逆スケーリング指数を使用して学習率を徐々に減少させます
        beta_1=0.9,                 # Adamでの1次モーメント(勾配)に使う減衰率を [0,1) の範囲で指定します
        beta_2=0.999,               # Adamでの2次モーメント(勾配の二乗)に使う減衰率を [0,1) の範囲で指定します
        epsilon=1.0e-8,             # Adamでの安定化パラメータを指定します
        #verbose=True,              # 学習の進捗状況を表示するかどうかを指定します(デフォルトFalse)
        #random_state=7,            # 学習の際に使用する乱数の種を指定します
        )
clf.fit(X_train, y_train) # 訓練データに合う関数(ニューラルネットワークのパラメータ)を見つけます

# 分類器の性能評価
print("訓練データに対する混同行列：")
y_predict = clf.predict(X_train) # 訓練データに対する予測を行います
cm = sklearn.metrics.confusion_matrix(y_train, y_predict) # 混同行列を作成します
print(cm)
acc = sklearn.metrics.accuracy_score(y_train, y_predict) # 2つのベクトルの確度を計算します
print("訓練スコア：", acc)

print("テストデータに対する混同行列：")
y_predict = clf.predict(scaler.transform(X_test)) # テストデータを無次元化して予測を行います
cm = sklearn.metrics.confusion_matrix(y_test, y_predict)
print(cm)      

acc = sklearn.metrics.accuracy_score(y_test, y_predict) # 2つのベクトルの確度を計算します
print("テストスコア：", acc)

#%% 学習したモデルの情報
#print("各層の重み行列：")
#print(clf.coefs_)
#print("各層のバイアス：")
#print(clf.intercepts_)
# 学習過程における損失のグラフを描画します
plt.plot(clf.loss_curve_)
plt.yscale("log") # y 軸を対数軸にします
plt.xlabel("number of iterations")
plt.ylabel("loss")
#plt.savefig("mlp_loss.pdf")
plt.show()

#%% 演習問題
print("(1) このソースコードを実行するとおそらく警告メッセージが出ます．MLPClassifier の引数を変更して警告が出ないようにしてください．")

print("(2) MLPClassifier の引数を変更して訓練スコアが 1.0 になるモデルを見つけてください．")

print("(3) (2) で求めた MLP よりもテストスコアが高い MLP を見つけてください．")

print("(4) 最適化手法として Adam と SGD を比較し，どちらが速く(少ない反復回数で収束するか)判定してください．")

print("(5) digits データセットに対するMLP分類器を作成し，汎化性能を確認してください．")







