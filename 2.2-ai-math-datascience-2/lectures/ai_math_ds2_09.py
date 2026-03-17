import time
import itertools
import numpy as np
import scipy.stats
import matplotlib.pyplot as plt
import sklearn.datasets
import sklearn.model_selection
import sklearn.tree
import sklearn.neural_network

# データの読み込み
dataset = sklearn.datasets.load_iris()
#dataset = sklearn.datasets.load_digits()

# 訓練データとテストデータに分けます
X_train, X_test, y_train, y_test = sklearn.model_selection.train_test_split(
               dataset.data, dataset.target, test_size=0.25)#, random_state=7)

# データの無次元化
#scaler = sklearn.preprocessing.StandardScaler() # 標準化
scaler = sklearn.preprocessing.MinMaxScaler()   # [0,1] 正規化
#scaler = sklearn.preprocessing.MaxAbsScaler()   # [-1,1] 正規化
#scaler = sklearn.preprocessing.RobustScaler()   # ロバストスケーリング
X_train = scaler.fit_transform(X_train) # X_train を学習し，無次元化したデータを戻します

#%% モデルの作成
clf = sklearn.tree.DecisionTreeClassifier(max_depth=100, min_samples_split=2)
#clf = sklearn.linear_model.LogisticRegression(max_iter=200)
#clf = sklearn.neural_network.MLPClassifier(hidden_layer_sizes=(8), max_iter=1000, learning_rate_init=0.1)

# K-分割交差検証
cv_results = sklearn.model_selection.cross_validate(clf, X_train, y_train, cv=5, return_estimator=True, n_jobs=-1)
print("検証スコア：", cv_results["test_score"])
best_clf = cv_results["estimator"][np.argmax(cv_results["test_score"])] # 検証スコアが最大のモデルを選択します

# 汎化性能評価
print("訓練データに対する混同行列：")
y_predict = best_clf.predict(X_train) # 訓練データに対する予測を行います
print(sklearn.metrics.confusion_matrix(y_train, y_predict)) # 混同行列を表示します
print("訓練スコア：", sklearn.metrics.accuracy_score(y_train, y_predict))

print("テストデータに対する混同行列：")
y_predict = best_clf.predict(scaler.transform(X_test)) # テストデータを無次元化して予測を行います
print(sklearn.metrics.confusion_matrix(y_test, y_predict))
print("テストスコア：", sklearn.metrics.accuracy_score(y_test, y_predict))

#%% 学習曲線
clf = sklearn.tree.DecisionTreeClassifier(max_depth=100, min_samples_split=2)
train_sizes, train_scores, validation_scores = sklearn.model_selection.learning_curve(clf, X_train, y_train, train_sizes=[0.1, 0.33, 0.55, 0.77, 1.0], cv=5, n_jobs=-1)
train_scores_mean = np.mean(train_scores, axis=1)           # 訓練スコアの平均を計算します
train_scores_std = np.std(train_scores, axis=1)             # 訓練の標準偏差を計算します
validation_scores_mean = np.mean(validation_scores, axis=1) # 検証スコアの平均を計算します
validation_scores_std = np.std(validation_scores, axis=1)   # 検証スコアの標準偏差を計算します
# 曲線の描画
plt.figure()
plt.plot(train_sizes, train_scores_mean, "o-", color="r", label="Training score")
plt.fill_between(train_sizes, train_scores_mean - train_scores_std, train_scores_mean + train_scores_std, color="r", alpha=0.1)
plt.plot(train_sizes, validation_scores_mean, "o-", color="g", label="Validation score")
plt.fill_between(train_sizes, validation_scores_mean - validation_scores_std, validation_scores_mean + validation_scores_std, color="g", alpha=0.1)
plt.grid()
plt.ylim([0.7, 1.01]) # 縦軸の描画範囲
plt.title("Learning curve", fontsize=20)
plt.xlabel("Training sizes", fontsize=20)
plt.ylabel("Scores", fontsize=20)
plt.legend(loc="best")
#plt.savefig("learning_curve.pdf", bbox_inches="tight")
plt.show()

#%% 検証曲線
clf = sklearn.tree.DecisionTreeClassifier(min_samples_split=2)
param_name = "max_depth"
param_range = [2**k for k in range(6)]
train_scores, validation_scores = sklearn.model_selection.validation_curve(clf, X_train, y_train, param_name=param_name, param_range=param_range, cv=5, n_jobs=-1)
train_scores_mean = np.mean(train_scores, axis=1)           # 訓練スコアの平均を計算します
train_scores_std = np.std(train_scores, axis=1)             # 訓練の標準偏差を計算します
validation_scores_mean = np.mean(validation_scores, axis=1) # 検証スコアの平均を計算します
validation_scores_std = np.std(validation_scores, axis=1)   # 検証スコアの標準偏差を計算します
# 曲線の描画
plt.figure()
plt.plot(param_range, train_scores_mean, "o-", color="r", label="Training score")
plt.fill_between(param_range, train_scores_mean - train_scores_std, train_scores_mean + train_scores_std, color="r", alpha=0.1)
plt.plot(param_range, validation_scores_mean, "o-", color="g", label="Validation score")
plt.fill_between(param_range, validation_scores_mean - validation_scores_std, validation_scores_mean + validation_scores_std, color="g", alpha=0.1)
plt.grid()
plt.ylim([-0.1, 1.01]) # 縦軸の描画範囲
plt.title("Validation curve", fontsize=20)
plt.xlabel(param_name, fontsize=20)
plt.ylabel("Scores", fontsize=20)
plt.legend(loc="best")
#plt.savefig("validation_curve.pdf", bbox_inches="tight")
plt.show()

#%% ハイパーパラメータチューニング
clf = sklearn.neural_network.MLPClassifier(max_iter=1000)
# GridSearchCV で探索する場合は組み合わせの数が多くなりすぎないように注意しましょう！
params = {"hidden_layer_sizes":[t for t in itertools.product((2,4,10),repeat=2)], # 隠れ層のニューロン数が 2, 4, 10 から成る2層MLPのすべての組み合わせ
          #"activation":["logistic", "tanh", "relu"], # 隠れ層の活性化関数
          "learning_rate_init":np.linspace(0.01, 0.05, 3), # 0.01 以上 0.05 以下を3点で等分割した配列．つまり [0.01, 0.03, 0.05]
          #"alpha":np.logspace(-5, 1, 4), # -5 以上 1 以下を4点で等分割した [-5, -3, -1, 1] を10のベキ指数にした配列．つまり [10**(-5), 10**(-3), 10**(-1), 10**1]
          }
print("ハイパーパラメータを探索する範囲：", params)
scv = sklearn.model_selection.GridSearchCV(clf, # ハイパーパラメータチューニングするモデル
                                           params, # 上のモデルに渡す変数とその範囲を対応させた辞書
                                           cv=5,   # 交差検証の数
                                           scoring="accuracy", # 確度でスコアを測ります
                                           n_jobs=-1, # 全 CPU コアを使って並列計算します
                                           )
# RandomizedSearchCV では乱数を生成する scipy.stats の関数を指定することもできます
#params["learning_rate_init"] = scipy.stats.uniform(0.01, 0.04) # [0.01, 0.01+0.04] の範囲の一様分布
#params["alpha"] = scipy.stats.loguniform(1.0e-5, 1.0e+1) # [1.0e-5, 1.0e+1] の範囲の対数スケール一様分布
#scv = sklearn.model_selection.RandomizedSearchCV(clf, params, cv=5, scoring="accuracy", n_iter=10, n_jobs=-1)#, random_state=7)
start_time = time.time() # 現在時刻を取得します(1970年1月1日0時0分0秒からの経過時間)
scv.fit(X_train, y_train)
end_time = time.time()
print("計算時間：", end_time - start_time, "秒")
print("最良モデルのハイパーパラメータ：", scv.best_params_)
print("最良モデルの検証スコア：　", scv.best_score_)
best_clf = scv.best_estimator_
print("最良モデルのテストスコア：", best_clf.score(scaler.transform(X_test), y_test))
#print(scv.cv_results_) # すべての交差検証の結果を見たい場合はアンコメントしてください

#%% 演習問題
print("(1) 分類木，ロジスティック回帰，MLP分類器それぞれの学習曲線を描いて過学習になっているか判断してください．")

print("(2) iris データセットと digits データセットそれぞれに対して，分類木の深さを変化させたときの検証曲線を描いて sweet spot を探してください．")

print("(3) RandomizedSearchCV では scipy.stats の分布関数を使ってハイパーパラメータの範囲を指定できることを確認してください．")
print("    さらに，ニューロン数が 2, 4, 10 以外にも三層パーセプトロンでテストスコアが高いモデルを探してください．")

print("(4) scv.cv_results_ にはすべての交差検証結果が辞書で保存されています．")
print("    scv と整数 k を引数とする，平均検証スコア上位 k 個のモデルのパラメータのリストを戻す関数を作成してください．")










