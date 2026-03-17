import numpy as np
import matplotlib.pyplot as plt
import sklearn.datasets
import sklearn.model_selection
import sklearn.tree
import sklearn.linear_model
import sklearn.ensemble

# データの読み込み
#dataset = sklearn.datasets.load_iris()
dataset = sklearn.datasets.load_digits()

# 訓練データとテストデータに分けます
X_train, X_test, y_train, y_test = sklearn.model_selection.train_test_split(
               dataset.data, dataset.target, test_size=0.25)#, random_state=7)

# データの無次元化(弱モデルで決定木を使うのであれば必要ありません)
#scaler = sklearn.preprocessing.StandardScaler() # 標準化
scaler = sklearn.preprocessing.MinMaxScaler()   # [0,1] 正規化
#scaler = sklearn.preprocessing.MaxAbsScaler()   # [-1,1] 正規化
#scaler = sklearn.preprocessing.RobustScaler()   # ロバストスケーリング
X_train = scaler.fit_transform(X_train) # X_train を学習し，無次元化したデータを戻します

#%% ランダムフォレスト
print("==== ランダムフォレスト ====")
rf = sklearn.ensemble.RandomForestClassifier(
    n_estimators=20,  # 分類木の数を指定します
    oob_score=True,   # oob_score=True のとき，n_estimators が少ないと OOB スコアが計算できなかった警告メッセージが出ます
    #bootstrap=False,  # サンプルを復元抽出するかどうかを指定します(デフォルト True)
    #max_samples=1.0,  # サンプルを抽出するサイズを指定します
    #max_features="sqrt", # 素性を抽出するサイズを指定します
    #n_jobs=-1,        # 全 CPU コアを使用して並列計算します
    #random_state=7,   # 使用する乱数の種を指定します
    # 分類木に関する設定
    criterion="gini",    # 乱雑さを測る指標を指定します
    max_depth=7,         # 分類木の最大深度を指定します
    min_samples_split=2, # ノードを分割するために必要なサンプルの最小値を指定します
    min_samples_leaf=1,  # 葉に必要なサンプルの最小値を指定します
    )
rf.fit(X_train, y_train)
print("   OOBスコア：", rf.oob_score_)
print("テストスコア：", rf.score(scaler.transform(X_test), y_test))
#print("  素性重要度：", rf.feature_importances_)
#print("rf.estimators_:", rf.estimators_) # 各弱モデルを確認できます

#%% バギング
print("\n==== バギング ====")
bgg = sklearn.ensemble.BaggingClassifier(
    #estimator=sklearn.tree.DecisionTreeClassifier(max_depth=7, min_samples_split=2, min_samples_leaf=1), # 弱モデルの設定
    #estimator=sklearn.linear_model.LogisticRegression(),
    n_estimators=20,  # 弱モデルの数を指定します
    oob_score=True,   # oob_score=True のとき，n_estimators が少ないと OOB スコアが計算できなかった警告メッセージが出ます
    #bootstrap=False,  # サンプルを復元抽出するかどうかを指定します(デフォルト True)
    #max_samples=1.0,  # サンプルを抽出するサイズを指定します
    #bootstrap_features=True, # 素性を復元抽出するかどうかを指定します(デフォルト False)
    #max_features=1.0, # 素性を抽出するサイズを指定します
    #n_jobs=-1,        # 全 CPU コアを使用して並列計算します
    #random_state=7,   # 使用する乱数の種を指定します
    )
bgg.fit(X_train, y_train)
print("   OOBスコア：", bgg.oob_score_)
print("テストスコア：", bgg.score(scaler.transform(X_test), y_test))
#print("bgg.estimators_:", bgg.estimators_)                   # 各弱モデルを確認できます
#print("bgg.estimators_samples_:", bgg.estimators_samples_)   # 各弱モデルが学習したサンプルのインデックスが確認できます
#print("bgg.estimators_features_:", bgg.estimators_features_) # 各弱モデルが学習した素性のインデックスが確認できます

#%% 勾配ブースティング決定木
print("\n==== 勾配ブースティング決定木 ====")
gbdt = sklearn.ensemble.GradientBoostingClassifier(
    # モデルに関するパラメータ
    n_estimators=100,  # 弱モデルの数を指定します
    learning_rate=0.2, # 弱モデルの学習率を指定します．learning_rate を下げたら n_estimators を上げないと未学習になります．
    #subsample=1.0,     # 弱モデルが学習する訓練データの割合を指定します．デフォルト(1.0)では弱モデルはすべての訓練データを学習します．
    #max_features=None, # 素性を抽出するサイズを "sqrt", "log2" で指定します．デフォルトでは素性の抽出は行いません．
    # 弱モデル(回帰木)に関するパラメータ
    #criterion="squared_error", # 回帰木の分割基準を指定します．GBDT 分類器でも弱モデルは回帰木が使われています．
    #criterion="friedman_mse",  # デフォルトはフリードマンによる改善スコアを含む平均二乗誤差です．デフォルト値の使用を推奨します．
    max_depth=2,               # 回帰木の最大深度を指定します
    min_samples_split=2,       # ノードを分割するために必要なサンプルの最小値を指定します
    min_samples_leaf=1,        # 葉に必要なサンプルの最小値を指定します
    # 最小化問題に関するパラメータ
    #loss="log_loss",     # 対数損失を使います．(デフォルト)
    #loss="exponential",  # 指数損失を使います．AdaBoost と同じになります
    #n_iter_no_change=10, # 学習の早期停止を行う場合は検証スコアが収束したと判断する回数を指定します．デフォルト(None)では早期停止しません
    #validation_fraction=0.1, # 早期停止を判断するために検証データとして使用する訓練データの割合を指定します
    #tol=1.0e-4,          # 検証スコアの許容範囲を指定します．検証スコアが n_iter_no_change 回連続で tol よりも小さくなれば収束したとみなします
    #verbose=True,        # 学習の進捗状況を表示するかどうかを指定します(デフォルトFalse)
    #random_state=7,      # 使用する乱数の種を指定します
    )
gbdt.fit(X_train, y_train)
print("テストスコア：", gbdt.score(scaler.transform(X_test), y_test))
#print("gbdt.estimators_:", gbdt.estimators_) # 各弱モデルを確認できます
#print("  素性重要度：", gbdt.feature_importances_)
# 学習過程における損失のグラフを描画します
# plt.plot(gbdt.train_score_)
# plt.yscale("log") # y 軸を対数軸にします
# plt.xlabel("number of weak models")
# plt.ylabel("loss")
# plt.show()

#%% アダブースト
print("\n==== アダブースト ====")
adab = sklearn.ensemble.AdaBoostClassifier(
    #base_estimator=sklearn.tree.DecisionTreeClassifier(max_depth=2, min_samples_split=2, min_samples_leaf=1), # 弱モデルの設定
    estimator=sklearn.linear_model.LogisticRegression(C=10.0),
    n_estimators=30,     # 弱モデルの数を指定します
    learning_rate=1.0,   # 弱モデルの学習率を指定します．learning_rate を下げたら n_estimators を上げないと未学習になります．
    #algorithm="SAMME.R", # base_estimator が predict_proba が使える場合に指定します(デフォルト)
    #algorithm="SAMME",   # base_estimator が predict_proba が使えない場合に指定します．SAMME.R よりも収束が遅くなります．
    #random_state=7,
    )
adab.fit(X_train, y_train)
print("テストスコア：", adab.score(scaler.transform(X_test), y_test))
#print("adab.estimators_:", adab.estimators_)               # 各弱モデルを確認できます
#print("adab.estimator_weights_:", adab.estimator_weights_) # 各弱モデルの重みを確認できます
#print("adab.estimator_errors_:\n", adab.estimator_errors_) # 各弱モデルの訓練誤差を確認できます

#%% 投票分類器1(既に学習済みのモデルを利用する場合)
print("\n==== 投票分類器1 ====")
weak_models = [("ランダムフォレスト", rf), ("バギング", bgg), ("勾配ブースティング決定木", gbdt), ("アダブースト", adab)]
vot = sklearn.ensemble.VotingClassifier(estimators=weak_models, voting="soft")
vot.estimators_ = [wm[1] for wm in weak_models]             # 学習済みモデルのリストを作ります
vot.named_estimators_ = sklearn.utils.Bunch()
vot.named_estimators_.update(weak_models)                   # 学習済みモデルの辞書を作ります
vot.le_ = sklearn.preprocessing.LabelEncoder().fit(y_train) # 教師データは何値の分類問題だったか教えます
vot.classes_ = dataset.target_names                         # 教師データのクラス名を教えます
print("テストスコア：", vot.score(scaler.transform(X_test), y_test))
#print("vot.estimators_:\n", vot.estimators_)             # 弱モデルのリストを確認できます
#print("vot.named_estimators_:\n", vot.named_estimators_) # 弱モデルの辞書を確認できます
#print("RF score:", vot.named_estimators_["ランダムフォレスト"].score(scaler.transform(X_test), y_test)) # 弱モデルの名前を使ってアクセスできます

#%% 投票分類器2(弱モデルを学習する場合)
print("\n==== 投票分類器2 ====")
weak_models = list()
weak_models.append(("DT3", sklearn.tree.DecisionTreeClassifier(max_depth=3)))
weak_models.append(("DT5", sklearn.tree.DecisionTreeClassifier(max_depth=5)))
weak_models.append(("DT7", sklearn.tree.DecisionTreeClassifier(max_depth=7)))
weak_models.append(("LR1", sklearn.linear_model.LogisticRegression(C=0.1, max_iter=100)))
weak_models.append(("LR2", sklearn.linear_model.LogisticRegression(C=1.0, max_iter=100)))
weak_models.append(("LR3", sklearn.linear_model.LogisticRegression(C=10.0, max_iter=100)))
weak_models.append(("RF3", sklearn.ensemble.RandomForestClassifier(n_estimators=20, max_depth=3)))
weak_models.append(("RF5", sklearn.ensemble.RandomForestClassifier(n_estimators=20, max_depth=5)))
weak_models.append(("RF7", sklearn.ensemble.RandomForestClassifier(n_estimators=20, max_depth=7)))
vot = sklearn.ensemble.VotingClassifier(
    estimators=weak_models, # ("弱モデル名", 弱モデル) を要素とするリストを渡します
    voting="hard",          # 多数決ルールの投票でクラスを予測します(デフォルト)
    #voting="soft",          # 弱モデルの予測確率の合計でクラスを予測します
    #weights=[1.0 for i in range(len(weak_models))], # 弱モデルの予測に重みを付けて合議することもできます
    n_jobs=-1,              # 全 CPU コアを使用して並列計算します(デフォルトNone)
    )
vot.fit(X_train, y_train)
print("テストスコア：", vot.score(scaler.transform(X_test), y_test))
#print("vot.estimators_:\n", vot.estimators_)             # 弱モデルのリストを確認できます
#print("vot.named_estimators_:\n", vot.named_estimators_) # 弱モデルの辞書を確認できます
#print("RF7 score:", vot.named_estimators_["RF7"].score(scaler.transform(X_test), y_test)) # 弱モデルの名前を使ってアクセスできます

#%% スタッキング
print("\n==== スタッキング1 ====")
weak_models = list()
weak_models.append(("LR3", sklearn.linear_model.LogisticRegression(C=10.0, max_iter=400)))
weak_models.append(("RF7", sklearn.ensemble.RandomForestClassifier(n_estimators=20, max_depth=7)))
stack = sklearn.ensemble.StackingClassifier(
    estimators=weak_models,        # ("弱モデル名", 弱モデル) を要素とするリストを渡します
    final_estimator=sklearn.linear_model.LogisticRegression(), # 出力層での弱モデルを渡します
    cv=5,                         # 交差検証を行う分割数を渡します
    stack_method="predict_proba", # 弱モデルで予測するメソッドを指定します．デフォルトでは predict_proba が使えるか判断し，使えたら predict_proba，使えなかったら predict を使います
    passthrough=False, # False(デフォルト)の場合，弱モデルの予測のみを訓練データとして final_estimator を学習します．True の場合，弱モデルの予測と元の訓練データで final_estimator を学習します
    n_jobs=-1,                    # 全 CPU コアを使用して並列計算します(デフォルトNone)
    )
stack.fit(X_train, y_train)
print("テストスコア：", stack.score(scaler.transform(X_test), y_test))
#print("stack.estimators_:\n", stack.estimators_)             # 弱モデルのリストを確認できます
#print("stack.named_estimators_:\n", stack.named_estimators_) # 弱モデルの辞書を確認できます
#print("stack.final_estimator_:", stack.final_estimator_)     # 出力層での弱モデルを確認できます
#print("RF7 score:", stack.named_estimators_["RF7"].score(scaler.transform(X_test), y_test)) # 弱モデルの名前を使ってアクセスできます

#%% 二層スタッキング
print("\n==== スタッキング2 ====")
layer2_models = list()
layer2_models.append(("DT5", sklearn.tree.DecisionTreeClassifier(max_depth=5)))
layer2_models.append(("RF5", sklearn.ensemble.RandomForestClassifier(n_estimators=20, max_depth=5)))

# 出力層から順番に作成します
layer2 = sklearn.ensemble.StackingClassifier(estimators=layer2_models, final_estimator=sklearn.linear_model.LogisticRegression(), n_jobs=-1)

layer1_models = list()
layer1_models.append(("LR3", sklearn.linear_model.LogisticRegression(C=10.0, max_iter=400)))
layer1_models.append(("RF7", sklearn.ensemble.RandomForestClassifier(n_estimators=20, max_depth=7)))

# final_estimator に次の層のスタッキングオブジェクトを指定します．第一層を強モデルと思ってプログラムします
clf = sklearn.ensemble.StackingClassifier(estimators=layer1_models, final_estimator=layer2, n_jobs=-1)

clf.fit(X_train, y_train)
print("テストスコア：", clf.score(scaler.transform(X_test), y_test))
#print("clf.estimators_:\n", clf.estimators_)             # 弱モデルのリストを確認できます
#print("clf.named_estimators_:\n", clf.named_estimators_) # 弱モデルの辞書を確認できます
#print("clf.final_estimator_:", clf.final_estimator_)     # 出力層での弱モデルを確認できます









