import numpy as np
import scipy.cluster.hierarchy
import matplotlib.pyplot as plt
import sklearn.preprocessing
import sklearn.cluster

# テストデータの作成
feature_names = ["Analysis", "Biology", "Chemistry"] # 素性の名前
sample_names = ["Alex", "Bonnie", "Colin", "Daniele", "Emily", "Fiona"] # サンプルの名前
# NumPy の2次元配列(行列)でデータを作ります
data = np.array([[60, 80, 90], # Alex の成績
                 [70, 40, 60], # Bonnie の成績
                 [70, 90, 70], # Colin の(以下略)
                 [80, 50, 60],
                 [80, 60, 80],
                 [90, 70, 70]])

print("テストデータ：")
print("\t\t" + "\t".join(feature_names))
for n, name in enumerate(sample_names):
    # ループカウンタ (n, name) に sample_names の (インデックス, リストの要素) が入ります
    print(f"{name}\t{data[n,0]:>8}\t{data[n,1]:>7}\t{data[n,2]:>9}")

# データの無次元化
#scaler = sklearn.preprocessing.StandardScaler() # 標準化
scaler = sklearn.preprocessing.MinMaxScaler()   # [0,1] 正規化
#scaler = sklearn.preprocessing.MaxAbsScaler()   # [-1,1] 正規化
#scaler = sklearn.preprocessing.RobustScaler()   # ロバストスケーリング
X = scaler.fit_transform(data) # data を学習し，無次元化したデータを戻します

#%% 階層的クラスタリング
Z = scipy.cluster.hierarchy.linkage(X,
                metric="euclidean",   # Euclid 距離
                #metric="cosine",      # コサイン類似度
                #metric="correlation", # Pearson 相関係数
                method="ward",        # Ward 法
                #method="average",     # 群平均法
                #method="complete",    # 完全連結法(最長距離法)
                #method="single",      # 単連結法(最短距離法)
                )

# 階層的クラスタのデンドログラムを描画
scipy.cluster.hierarchy.dendrogram(Z, orientation="right", color_threshold=0.8, labels=sample_names)
#plt.savefig("dendrogram.pdf")
plt.show()

# 各サンプルが属するクラスタ
sample_clust = scipy.cluster.hierarchy.fcluster(Z, t=3, criterion="maxclust") # 3つのクラスタに分ける
print("階層的クラスタリング：", sample_clust) # SciPy のクラスタ番号は1から始まります

print("問1：樹形図の頂点を上にし，2つのクラスタに色分けした図を描画してください．")

print("問2：データの近さを図る指標を変更して帯状クラスタができるか調べてください．")


#%% 非階層的クラスタリング
clustering = sklearn.cluster.KMeans(n_clusters=3, random_state=10)#, n_init="auto") # n_clusters でクラスタ数を指定．random_state は初期配置の乱数の種
#clustering = sklearn.cluster.MiniBatchKMeans(n_clusters=3, batch_size=1024, random_state=10, n_init="auto")
#clustering = sklearn.cluster.DBSCAN(eps=0.6, min_samples=1) # eps で同じクラスタに入れる半径を指定．min_samples で core-point とみなす最小の点数を指定
#clustering = sklearn.cluster.MeanShift(bandwidth=0.5, bin_seeding=True) # bandwidth でクラスタの半径を指定．bin_seeding=True で初期クラスタを自動で与える
clustering.fit(X)

# 各サンプルが属するクラスタ
sample_clust = clustering.labels_
print("非階層的クラスタリング：", sample_clust) # scikit-learn のクラスタ番号は0から始まります

print("問3：KMeans の random_state=None だと実行する度にクラスタ番号が変わるが，クラスタリングの結果は変わらないことを確かめてください．")

print("問4：DBSCAN のパラメータを変更して，階層的クラスタリングと同じ結果(クラスタ)がえられるものがあるか調べてください．")

#%% 未知データに対する予測
gabriel = np.array([[90,50,90]]) # Gabriel の成績
x = scaler.transform(gabriel)    # データの無次元化
clust = clustering.predict(x)    # 未知データが属するクラスタを予測します
print("Gabriel のクラスタ：", clust)

print("問5：KMeans は予測ができるが，DBSCAN は予測ができないことを確かめてください．")

print("問6：階層的クラスタリング, KMeans, MiniBatchKMeans, DBSCAN, MeanShift で予測ができるアルゴリズムを挙げてください．")




