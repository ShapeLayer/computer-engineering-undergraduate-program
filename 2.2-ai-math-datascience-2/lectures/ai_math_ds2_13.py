

import pandas as pd
import sklearn.preprocessing

#%% 分析するデータの読み込みと表示

# 分析するデータを読み込みます
# df = pd.read_csv(***) # ***には、"ローカルに保存されているファイルのパス"や"URLのリンク先"を入力することでデータを読み込みます
df_original = pd.read_csv(r'https://archive.ics.uci.edu/static/public/878/cirrhosis+patient+survival+prediction+dataset-1.zip', compression='zip') # URLのリンク先に保存されているのが圧縮ファイルなので、左のようになります。

print(df_original.columns) # df.columns ： 列名（素性）が得られます
#print(df.head(8)) # df.head(N) ： 先頭からN行までのデータが得られます
#print(df.tail(6)) # df.tail(N) ： 末尾からN行までのデータが得られます
#print(df.dtypes) # 各素性のデータ型を確認します
#df_copy = df.copy() # データフレームをコピーする（念のために、元データのバックアップを取るため）


#%% データの前処理とクレンジング（欠損値の処理とデータ変換が対象）

# 分析するデータを読み込みます
df = pd.read_csv(r'https://archive.ics.uci.edu/static/public/878/cirrhosis+patient+survival+prediction+dataset-1.zip', compression='zip')

nan_flag = df.isnull().any() # 欠損値（NaN）が含まれている素性を判定します ※ any()を付けることで、各素性内で1つでもTrue（欠損値）があればTrue（欠損値）を返す処理を行う
# print(nan_flag) 
print(df.columns[nan_flag]) # 欠損値（NaN）が含まれている素性を表示します　

df = df.drop(['Status'], axis=1) # 目的変数を削除


#%% 欠損値の対応

# ★平均値の場合
df_mean = df.mean(numeric_only=True) # 各素性（数値型のみ）の平均値を算出
print(df_mean) # 表示
df = df.fillna(df_mean) # 各素性（数値型のみ）の平均値で補完する
# ★中央値の場合
# df_median = df.median(numeric_only=True) # 各素性（数値型のみ）の中央値を算出
# print(df_median) # 表示
# df = df.fillna(df_median) # 各素性（数値型のみ）の中央値で補完する
# ★最頻値の場合
# df_mode = df.mode().iloc[0] #　各素性の最頻値を算出
# print(df_mode)
# df = df.fillna(df_mode) # 各素性の最頻値で補完する

df['Stage'] = df['Stage'].astype(str) # 対象の素性のデータ型を変更する（後の前処理に必要）
category_cols = df.select_dtypes(include=[object]).columns # データフレームから"object"型の素性名を抽出
for col in category_cols:
    df[col].fillna('not clear', inplace=True) # 抽出した"object"型の各素性内に、欠損値があれば"not clear"で埋める


# ========== カテゴリ-データの数値化（機械学習モデルに用いる場合に必要） ========== 
#%% ラベルエンコーディング
df_le = df.copy()
for col in category_cols: # 50行目で抽出したカテゴリーデータの各素性について、次の処理を行う
    le = sklearn.preprocessing.LabelEncoder() # label encodingのオブジェクト
    le.fit(df_le[col]) 
    df_le[col] = le.transform(df_le[col]) 
    

#%% ワンホットエンコーディング
df_ohe = df.copy()
ohe = sklearn.preprocessing.OneHotEncoder(sparse=False) # one hot encodingのオブジェクト
ohe.fit(df_ohe[category_cols])
# 新たな素性名の作成
columns=[]
for i, c in enumerate(category_cols):
    columns += [f'{c}_{v}' for v in ohe.categories_[i]]

ohe_feat = pd.DataFrame(ohe.transform(df_ohe[category_cols]), columns=columns) # one hot encodig後の素性だけで構成されたデータフレーム
df_ohe = pd.concat([df_ohe.drop(category_cols, axis=1), ohe_feat], axis=1) # 元のデータフレーム（one hot encodingの対象となった素性は削除）とone hot encoding誤のデータフレームを結合する
