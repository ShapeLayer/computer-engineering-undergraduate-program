import numpy as np
import matplotlib.pyplot as plt
import sklearn.datasets
import sklearn.preprocessing
import sklearn.decomposition
import sklearn.manifold

iris = sklearn.datasets.load_iris() # iris データをロードします
X = iris.data   # X に iris の素性データを代入します
#X[:,3] *= 10000 # 花弁の幅の単位を [mcm] に変えます

# X の無次元化を行います
scaler = sklearn.preprocessing.StandardScaler()
X = scaler.fit_transform(X) # X を標準化したものを改めて X に代入します


#%% iris データの主成分分析
pca = sklearn.decomposition.PCA(n_components=len(X[0])) # X の素性数と同じ数の主成分を求めます
pca.fit(X) # 実際に X の主成分を計算します
print("各成分の寄与率:\n", pca.explained_variance_ratio_)
print("累積寄与率:\n", np.cumsum(pca.explained_variance_ratio_))
print("主成分:\n", pca.components_)


#%% iris データの可視化
# 2次元の図を描きたいので，主成分を2つだけ求めます
pca = sklearn.decomposition.PCA(n_components=2, copy=False)
Y = pca.fit_transform(X) # 主成分を2つ求めます
print("X.shape = ", X.shape, ", Y.shape = ", Y.shape) # X,Y の配列の形状を表示します
plt.scatter(Y[:,0], Y[:,1], alpha=0.5, c=iris.target)
#plt.savefig("iris_pca12_scatter.pdf") # 画像を保存したいときはアンコメントしてください
plt.show() # 図を表示します


#%% iris データの第3主成分と第4主成分の散布図を描こう！
print("問：iris.data の第3主成分と第4主成分の散布図を描いてください")


#%% 主成分分析における無次元化の必要性を確認しよう！
print("問：iris.data を無次元化しなかった場合，寄与率がどう変化するか調べてください")


#%% iris データの多次元尺度構成法
mds = sklearn.manifold.MDS(n_components=2)#, random_state=None)
Y = mds.fit_transform(X)
plt.scatter(Y[:,0], Y[:,1], alpha=0.5, c=iris.target)
#plt.savefig("iris_mds_scatter.pdf") # 画像を保存したいときはアンコメントしてください
plt.show() # 図を表示します

print("問：MDS を実行するたびに散布図が変わることを確認しましょう．")
print("問：MDS を実行するたびに散布図が変わりますが，点の位置関係は，毎回，概ね同じとなっていることを確認しましょう．")
print("問：MDS に乱数の種を指定することで何度実行しても同じ散布図が得られることを確認しましょう．")







