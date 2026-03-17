import matplotlib.pyplot as plt
import sklearn.datasets
import sklearn.model_selection
import sklearn.tree

# データの読み込み
dataset = sklearn.datasets.load_iris()
#dataset = sklearn.datasets.load_digits()

# 訓練データとテストデータに分けます
X_train, X_test, y_train, y_test = sklearn.model_selection.train_test_split(
               dataset.data, dataset.target, test_size=0.25)#, random_state=7)

# データの無次元化(実は決的木では無次元化は必要ありません)
# scaler = sklearn.preprocessing.StandardScaler() # 標準化
# X_train = scaler.fit_transform(X_train) # X_train を学習し，無次元化したデータを戻します
# print(scaler.transform([[0.0, 0.0, 2.45, 1.7]]))
# print(scaler.inverse_transform([[0.0, 0.0, -0.712, 0.667]]))

#%% 分類木モデル
clf = sklearn.tree.DecisionTreeClassifier(
        criterion="entropy", # 情報エントロピーを使用します
        #criterion="gini",    # Gini 不純度を使用します
        max_depth=2,         # 分類木の最大深度を指定します
        min_samples_split=2, # ノードを分割するために必要なサンプルの最小値を指定します
        min_samples_leaf=1,  # 葉に必要なサンプルの最小値を指定します
        #random_state=7,      # 学習の際に使用する乱数の種を指定します
        )
clf.fit(X_train, y_train)    # 訓練データに合う分類木を見つけます

# 分類木の性能評価
print("訓練データに対する混同行列：")
y_predict = clf.predict(X_train) # 訓練データに対する予測を行います
cm = sklearn.metrics.confusion_matrix(y_train, y_predict) # 混同行列を作成します
print(cm) # cm[i,j] には i が正解であるものを j と予測した回数が保存されます
#           つまり，対角成分が正答数で，非対角成分が誤答数になります
acc = sklearn.metrics.accuracy_score(y_train, y_predict) # 2つのベクトルの確度を計算します
print(f"  訓練スコア = {100*acc} %")

print("テストデータに対する混同行列：")
#X_test = scaler.transform(X_test) # X_train の学習結果を利用し，X_test を無次元化します
y_predict = clf.predict(X_test) # テストデータに対する予測を行います
cm = sklearn.metrics.confusion_matrix(y_test, y_predict)
print(cm)      

acc = sklearn.metrics.accuracy_score(y_test, y_predict) # 2つのベクトルの確度を計算します
print(f"テストスコア = {100*acc} %")
acc = clf.score(X_test, y_test) # y_predict を作らなくても score メソッドで確度を計算できます
print(f"   clf.score = {100*acc} %")
print(f"  素性重要度 = {clf.feature_importances_}")

#%% 学習した分類木の描画
plt.figure(figsize=(10, 10))
sklearn.tree.plot_tree(clf,
    feature_names=dataset.feature_names, # 素性の名前を指定します
    #class_names=list(dataset.target_names), # クラスの名前を指定します
    #filled=True, # True ならば枠の中に色を塗ります
    )
#plt.savefig("decision_tree.pdf") # 画像を保存します
plt.show()









