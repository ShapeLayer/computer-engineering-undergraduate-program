#import "style.typ": font-family, pallete, section, theme, url, vulnerability-chart

#let primary-color = pallete.misc.ghudegy

#show: theme.with(
  title: "C言語を用いたウェブサービスの実装",
  author: "Jonghyeon PARK",
  fill: primary-color,
  hero: [
    #rect(
      width: 100%,
      height: 60%,
      fill: primary-color,
      outset: 0%,
      inset: (left: 5em, y: 3em)
    )[
      #align(horizon)[#text(fill: white)[
        #text(size: 40pt, weight: "bold")[
          C言語を用いたウェブサービスの実装
        ]\

        #text(size: 22pt, weight: "medium")[
          簡易的なIRCサーバおよびクライアントの作成
        ]
      ]]
    ]
    #align(center + horizon)[#text(fill: primary-color, size: 22pt, weight: "medium")[
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
  title: "ウェブサーバのC言語実装",
  primary-color: primary-color,
  hero: [
    課題要件

    #list(
      spacing: 1em, marker: [#text(fill: primary-color)[#sym.arrow.filled]],
      [
        クライアントとサーバの両方から通信を開始できること
      ],
      [
        通信プロトコルとしてTCP/IP（またはUDP/IP）を使用すること
      ],
      [
        メッセージを受信し、応答を送信すること。\
        メッセージはプログラムにあらかじめ作成された内容、または直接入力したものとする
      ],
      [
        サーバとクライアントが同一PC上にあってもよい
      ]
    )
    \
    - 実装リポジトリ: #underline[#link("https://github.com/shapelayer/simple-irc")]
  ]
)[
  - 実装内容

  /*
  目標
  
  - C言語で「オブジェクト指向」を目指す
  - C言語のみで構成されるコマンドラインプログラムの作成

  #pagebreak()

  #quote(block: true, attribution: [The Rust Programming Language @rust-book-what-is-oo])[
    俗に言う「4人組（Gang of Four）」の本では、OOPを次のように定義しています。

    \
    オブジェクト指向プログラムはオブジェクトで構成されます。オブジェクトはデータと、そのデータを活用するプロシージャをまとめます。これらのプロシージャは通常、メソッドまたは演算（operation）と呼ばれます。
    
    \
    ...この定義によれば、Rustはオブジェクト指向的です。構造体と列挙型にはデータがあり、実装ブロック（impl）はその構造体と列挙型に対するメソッドを提供します。
  ]

  #pagebreak()

  Rustコードにおける構造体と実装ブロックの定義

  #text(size: .8em)[```rs
  // 構造体
  pub struct AveragedCollection {
    list: Vec<i32>,
    average: f64,
  }

  // 実装ブロック
  impl AveragedCollection {
    pub fn add(&mut self, value: i32) {
        self.list.push(value);
        self.update_average();
    }
  }
  ```]

  #pagebreak()

  C言語における同様のアプローチ `@github/cmark-gfm`

  #text(size: .8em)[```c
  // 構造体の定義
  typedef struct {
    cmark_mem *mem;
    unsigned char *ptr;
    bufsize_t asize, size;
  } cmark_strbuf;

  // コンストラクタのように動作
  void cmark_strbuf_init(cmark_mem *mem, cmark_strbuf *buf,
      bufsize_t initial_size) { ... }
  
  // コンストラクタの呼び出し
  cmark_strbuf_init(parser->mem, &parser->curline, 256);
  ```]

  #pagebreak()

  構造体定義への対応 `server_sess.h`

  #text(size: .8em)[```c
  struct server_sess
  {
    int fd;
    int opt;
    int sd_cnt;
    int port;
    struct sockaddr_in address;
    int addrlen;
    client_desc_t clients[SERVER_MAX_CLIENT_CONNECTIONS];
    fd_set readfds;
    int __new_socket;
    int __valread;
    int __activity;
    char __str_buf[STRING_BUFFER_SIZE];
  } typedef server_sess_t;
  ```]

  #pagebreak()

  実装ブロックへの対応 `server_sess.h`

  #text(size: .8em)[```c
  void init_server_sess(server_sess_t *sess);
  void server_sess_update(server_sess_t *sess);
  void server_sess_open(server_sess_t *sess);
  void server_sess_set_port(server_sess_t *sess, int port);
  void server_sess_broadcast(server_sess_t *sess, int sender_idx, const char *msg);
  void server_sess_handle_client_message(server_sess_t *sess, int index, char *buffer);
  ```]

  #pagebreak()

  サーバセッションオブジェクトを生成し、メソッド実装を呼び出す / `main.c`

  #text(size: .8em)[```c
  server_sess_t *server_sess;
  server_sess = calloc(1, sizeof(server_sess_t));

  if (!server_sess) PANIC("サーバセッションのメモリ確保に失敗しました");

  init_server_sess(server_sess);
  printf("Server session initialized.\n");

  server_sess_set_port(server_sess, args.port);
  printf("Starting server on port %d...\n", args.port);
  server_sess_open(server_sess);

  while (1) server_sess_update(server_sess);
  ```]
  */
]

#show raw.where(block: true): it => text(size: .7em)[#it]

#section(
  title: "サーバ / main.c",
  primary-color: primary-color,
  hero: [ 
  `main.c` / プログラムのエントリポイント: メインループの呼び出し箇所
  \
  ```c
  int main(int argc, char const **argv)
  {
    // コマンドライン引数のパース
    main_args_t args = parse_args(argc, argv);

    // サーバセッションオブジェクトの生成
    server_sess_t *server_sess;
    server_sess = calloc(1, sizeof(server_sess_t));
    if (!server_sess) PANIC("サーバセッションの割り当てに失敗しました");
    init_server_sess(server_sess);
    printf("Server session initialized.\n");
  ```
  ]
)[
  #pagebreak()
  `main.c`
  
  ```c
    // サーバポート設定 (setter)
    server_sess_set_port(server_sess, args.port);
    printf("Starting server on port %d...\n", args.port);
    server_sess_open(server_sess);

    // メインループ開始
    while (1) server_sess_update(server_sess);

    return 0;
  ```
]

#section(
  title: "サーバ / server_sess.h",
  primary-color: primary-color,
  hero: [
    `server_sess.h` / サーバセッションオブジェクトの宣言
    ```c
    struct server_sess
    {
      int fd;
      int opt;
      int sd_cnt;
      int port;
      struct sockaddr_in address;
      int addrlen;
      client_desc_t clients[];
      fd_set readfds;

      ...
    } typedef server_sess_t;
    ```
  ]
)[
  `server_sess_t` 構造体の内部フィールドについて

  - `__` で始まるフィールドは、関数内部で一時的に使用される値

  - `server_sess_t` オブジェクト自体とは密接な関連はない

  - `update` 関数内で毎回生成することも可能だが、変数の生成コストが発生する

  - 初回のみ生成し、変数を再利用する構成をとっている

  #pagebreak()

  `server_sess.h`
  
  ```c
  struct server_sess
  {
    ...
    // 内部フィールド
    int __new_socket;
    int __valread;
    int __activity;
    char __str_buf[STRING_BUFFER_SIZE];
  } typedef server_sess_t;
  ```

  #pagebreak()

  サーバセッションオブジェクトのメソッド宣言
  ```c
  // コンストラクタ
  void init_server_sess(server_sess_t *sess);

  // メインループ
  void server_sess_update(server_sess_t *sess);

  // サーバのオープン
  void server_sess_open(server_sess_t *sess);

  // ポート設定
  void server_sess_set_port(server_sess_t *sess, int port);

  // メッセージのブロードキャスト
  void server_sess_broadcast(server_sess_t *sess, int sender_idx, const char *msg);

  // クライアントメッセージの処理
  void server_sess_handle_client_message(server_sess_t *sess, int index, char *buffer);
  ```
]


#section(
  title: "サーバ / server_sess.c",
  primary-color: primary-color,
  hero: [
    ```c
    // コンストラクタ
    void init_server_sess(server_sess_t *sess)
    {
      for (int i = 0; i < SERVER_MAX_CLIENT_CONNECTIONS; i++)
      {
        sess->clients[i].socket = 0;
        snprintf(sess->clients[i].nickname, sizeof(sess->clients[i].nickname), "Guest%d", i);
      }

      // ソケットのオープンおよびファイルディスクリプタの割り当て試行
      if ((sess->fd = socket(AF_INET, SOCK_STREAM, 0)) == 0)
      {
        PANIC("Error during opening the socket (socket)");
      }
    ...
    ```
  ]
)[
  ```c
  ...
    // ソケットオプションの設定試行
    sess->opt = 1;
    if (setsockopt(sess->fd, SOL_SOCKET, SO_REUSEADDR, &sess->opt, sizeof(sess->opt)))
    {
      PANIC("Error during setting the socket's option (setsockopt)");
    }

    // サーバアドレス、ポートデータの設定試行
    sess->address.sin_family = AF_INET;
    sess->address.sin_addr.s_addr = INADDR_ANY;
    server_sess_set_port(sess, SERVER_PORT);
  }
  ```
  
  #pagebreak()
  
  ```c
  // サーバのオープン
  void server_sess_open(server_sess_t *sess)
  {
    // server_sess_tのアドレス情報を用いてサーバのオープンを試行
    if (bind(sess->fd, (struct sockaddr *)&sess->address, sizeof(sess->address)) < 0)
    {
      PANIC("Error during binding the socket (bind)");
    }
    sess->addrlen = sizeof(sess->address);
  
    if (listen(sess->fd, 3) < 0)
    {
      PANIC("Error during starting listening on the socket (listen)");
    }
  
    printf("Simple Chat Server started on port %d\n", sess->port);
  }
  ```
  
  #pagebreak()
  
  ```c
  // サーバのメインループサイクル
  void server_sess_update(server_sess_t *sess)
  {
    // ファイルディスクリプタ(FD)セットの初期化および監視対象の設定
    FD_ZERO(&sess->readfds);           // 読み取り監視用のFDセットを0で初期化
    FD_SET(sess->fd, &sess->readfds);  // サーバのリッスンソケットを監視対象に追加
    sess->sd_cnt = sess->fd;           // 最大のソケット番号をサーバソケットに初期設定

    // 現在接続されているすべてのクライアントソケットを監視対象に追加
    for (int i = 0; i < SERVER_MAX_CLIENT_CONNECTIONS; i++)
    {
      int sd = sess->clients[i].socket;
      if (sd > 0) FD_SET(sd, &sess->readfds);
      if (sd > sess->sd_cnt) sess->sd_cnt = sd;
    }
    // アクティビティのあるソケットを監視 (ブロッキング状態)
    // 第3, 4, 5引数がNULLのため、読み取りイベントのみを無期限に待機
    sess->__activity = select(sess->sd_cnt + 1, &sess->readfds, NULL, NULL, NULL);
    if (sess->__activity < 0) PANIC("Error during select operation (select)");
  ...
  ```
  
  #pagebreak()
  
  ```c
  ...
    // 新規クライアントの接続要求の処理
    // サーバリッスンソケットに読み取りイベントが発生すれば、新規接続があることを意味する
    if (FD_ISSET(sess->fd, &sess->readfds))
    {
      if ((sess->__new_socket = accept(sess->fd, (struct sockaddr *)&sess->address, (socklen_t *)&sess->addrlen)) < 0) PANIC();
      // 空いているクライアントスロットを探し、新しいソケット情報を保存
      for (int i = 0; i < SERVER_MAX_CLIENT_CONNECTIONS; i++)
      { if (sess->clients[i].socket == 0) {
          sess->clients[i].socket = sess->__new_socket;
          printf("New connection: Guest%d\n", i);
  
          char welcome[STRING_BUFFER_SIZE];
          snprintf(welcome, sizeof(welcome), "Welcome! You are Guest%d. Use '/nick <name>' to change nickname.\n", i);
          send_to_socket(sess->__new_socket, welcome);
          break;
    }}}
  ...
  ```
  
  #pagebreak()
  
  ```c
  ...
    // 既存クライアントからのメッセージ受信処理
    for (int i = 0; i < SERVER_MAX_CLIENT_CONNECTIONS; i++)
    {
      int sd = sess->clients[i].socket;
      // 該当クライアントソケットに読み取りイベントが発生したか確認
      if (FD_ISSET(sd, &sess->readfds))
      {
        memset(sess->__str_buf, 0, STRING_BUFFER_SIZE);
        // データの読み取り試行
        if ((sess->__valread = read(sd, sess->__str_buf, STRING_BUFFER_SIZE)) == 0) {
          close(sd); sess->clients[i].socket = 0;
          printf("User disconnected: %s\n", sess->clients[i].nickname);
        } else {
          if (sess->__valread >= STRING_BUFFER_SIZE)
            sess->__str_buf[STRING_BUFFER_SIZE - 1] = '\0';
          else
            sess->__str_buf[sess->__valread] = '\0';
          server_sess_handle_client_message(sess, i, sess->__str_buf);
  }}}}
  ```

  #pagebreak()

  
  ```c
  // オープンするポートの設定
  void server_sess_set_port(server_sess_t *sess, int port)
  {
    sess->address.sin_port = htons(port);
    sess->port = port;
  }
  ```
  \
  ```c
  // サーバ全体にメッセージを送信
  void server_sess_broadcast(server_sess_t *sess, int sender_idx, const char *msg)
  {
    for (int i = 0; i < SERVER_MAX_CLIENT_CONNECTIONS; i++)
      if (sess->clients[i].socket != 0 && i != sender_idx)
        send_to_socket(sess->clients[i].socket, msg);
  }
  ```
  
  #pagebreak()
  
  ```c
  // クライアントからメッセージを受信した際
  void server_sess_handle_client_message(server_sess_t *sess, int index, char *buffer)
  {
    buffer[strcspn(buffer, "\r\n")] = 0;
  
    if (strlen(buffer) == 0) return;
  
    // デバッグ目的でコマンド機能(ユーザ名の変更)を追加
    if (COMMAND_NICK_IS_TRIGGERED(buffer))
    {
      command_serv_handle_nick(sess, index, buffer); return;
    }
    
    char msg_out[STRING_BUFFER_SIZE + 50];
    snprintf(msg_out, sizeof(msg_out), "[%s]: %s\n", sess->clients[index].nickname, buffer);
  
    SERVER_SESS_LOG_AND_BRODCAST(sess, index, msg_out);
  }
  ```
]

#section(
  title: "サーバ / ビルド",
  primary-color: primary-color,
  hero: [
    - 実装はCMakeを利用してビルド

    `CMakeLists.txt`
    ```CMake
    cmake_minimum_required(VERSION 3.20)
    project(simple_irc_server C)
    set(CMAKE_C_STANDARD 11)
    set(CMAKE_C_STANDARD_REQUIRED ON)
    set(HEADERS
      src/command.h     src/server_sess.h   src/socket.h
      include/client.h  include/defines.h   include/panic.h
    )
    set(SOURCES
      src/command.c src/server_sess.c src/socket.c src/main.c
    )
    add_executable(${PROJECT_NAME} ${SOURCES} ${HEADERS})
    target_include_directories(${PROJECT_NAME} PRIVATE include)
    ```
  ],
)[]

#section(
  title: "サーバ・クライアント共通要素",
  primary-color: primary-color,
  header: [
    \
    サーバ・クライアント共通要素
  ],
  hero: [
    `client.h`

    ```c
    struct client_desc {
      int socket;
      char nickname[32];
    } typedef client_desc_t;
    ```
  ],
)[
  `panic.h`

  ```c
  #ifndef _SIMPLE_IRC_PANIC_H_
  #define _SIMPLE_IRC_PANIC_H_
  
  #define PANIC(msg) { \
    perror(msg); \
    exit(EXIT_FAILURE); \
  }
  
  #endif

  ```
]

#section(
  title: "クライアント / main.c",
  primary-color: primary-color,
  hero: [
    ```c
    int main(int argc, char const **argv)
    {
      // クライアントセッションオブジェクトの生成
      client_sess_t *client_sess;
      client_sess = calloc(1, sizeof(client_sess_t));
      if (!client_sess) PANIC("Failed to allocate client session");
      init_client_sess(client_sess);

      // サーバ接続の試行
      client_sess_connect(client_sess);

      // サーバ接続中のループ
      while (1) client_sess_update(client_sess);
    
      return 0;
    }
    ```
  ]
)[]

#section(
  title: "クライアント / client_sess.h",
  primary-color: primary-color,
  hero: [
    `client_sess.h`
    
    ```c
    struct client_sess
    {
      int sock;                // ソケットディスクリプタ
      struct sockaddr_in addr; // ソケットアドレス構造体
      char nickname[32];       // ニックネーム機能に対応
      fd_set readfds;
      
      int __valread;
      char __str_buf[];
    } typedef client_sess_t;
    ```
  ]
)[
  ```c
  // コンストラクタ
  void init_client_sess(client_sess_t *sess);

  // 現在のユーザ名の変更
  void client_sess_set_nickname(client_sess_t *sess, const char *nickname);

  // setter: 接続先アドレスの変更
  void client_sess_set_addr(client_sess_t *sess, const char *addr, int port);

  // サーバへの接続
  void client_sess_connect(client_sess_t *sess);

  // メインループ
  void client_sess_update(client_sess_t *sess);

  // サーバ切断時の動作定義
  void client_sess_on_disconnected(client_sess_t *sess);

  // サーバからの切断
  void client_sess_disconnect(client_sess_t *sess);
  ```
]


#section(
  title: "クライアント / client_sess.c",
  primary-color: primary-color,
  hero: [
    ```c
    // クライアントセッションコンストラクタ
    void init_client_sess(client_sess_t *sess)
    {
      sess->sock = -1;
      client_sess_set_nickname(sess, "Guest");
      
      if ((sess->sock = socket(AF_INET, SOCK_STREAM, 0)) < 0)
        PANIC("Error during socket creation (socket)");
      
      sess->addr.sin_family = AF_INET;
      client_sess_set_addr(sess, "127.0.0.1", SERVER_PORT);
    }
    ```
  ]
)[
  ```c
  // setter: ユーザ名の設定
  void client_sess_set_nickname(client_sess_t *sess, const char *nickname)
  {
    memset(sess->nickname, 0, sizeof(sess->nickname));
    strncpy(sess->nickname, nickname, sizeof(sess->nickname) - 1);
  }
  ```
  
  #pagebreak()
  
  ```c
  // setter: 接続先アドレスの設定
  void client_sess_set_addr(client_sess_t *sess, const char *addr, int port)
  {
    sess->addr.sin_port = htons(port);
  
    if (inet_pton(AF_INET, addr, &sess->addr.sin_addr) <= 0)
      PANIC("Invalid address. Address not supported (inet_pton)");
  }
  ```
  
  #pagebreak()
  
  ```c
  // サーバへの接続
  void client_sess_connect(client_sess_t *sess)
  {
    if (connect(sess->sock, (struct sockaddr *)&sess->addr, sizeof(sess->addr)) < 0)
      PANIC("Connection Failed (connect)");
  
    printf("Connected to server!\n");
    printf("Commands: /nick <name> to change nickname.\n");
  }
  ```
  
  #pagebreak()
  
  ```c
  // クライアントメインループ
  void client_sess_update(client_sess_t *sess)
  {
    // ファイルディスクリプタセットの初期化および監視対象の設定
    FD_ZERO(&sess->readfds);
    FD_SET(STDIN_FILENO, &sess->readfds);
    FD_SET(sess->sock, &sess->readfds);
  
    // ソケットアクティビティの監視 (ブロッキング状態)
    if (select(sess->sock + 1, &sess->readfds, NULL, NULL, NULL) < 0)
    {
      PANIC("Error during select operation (select)");
    }
    ...
  ```
  
  ```c
    // メッセージ受信時
    if (FD_ISSET(sess->sock, &sess->readfds))
    {
      memset(sess->__str_buf, 0, STRING_BUFFER_SIZE);
      sess->__valread = read(sess->sock, sess->__str_buf, STRING_BUFFER_SIZE);
      
      // サーバからの切断時の処理
      if (sess->__valread == 0)
      {
        client_sess_on_disconnected(sess);
        return;
      }
      
      // 受信したメッセージの出力
      printf("%s", sess->__str_buf);
    }
    ...
  ```

  #pagebreak()
  
  ```c
    ...
    // メッセージ入力処理
    if (FD_ISSET(0, &sess->readfds))
    {
      memset(sess->__str_buf, 0, STRING_BUFFER_SIZE);
      // 標準入力からメッセージを読み取り
      if (fgets(sess->__str_buf, STRING_BUFFER_SIZE, stdin) != NULL)
      {
        send(sess->sock, sess->__str_buf, strlen(sess->__str_buf), 0);
      }
    }
  }
  ```
  
  #pagebreak()
  
  ```c
  // サーバ切断時の動作定義
  void client_sess_on_disconnected(client_sess_t *sess)
  {
    printf("Disconnected from server.\n");
    exit(EXIT_SUCCESS);
  }
  ``` 
  
  \
  
  ```c
  // サーバからの切断
  void client_sess_disconnect(client_sess_t *sess)
  {
    // ファイルディスクリプタを閉じる
    close(sess->sock);
  }
  ```
]

#section(
  title: "実行結果",
  primary-color: primary-color,
  hero: [
    #figure(
      image("static/simple-irc-demo-client.png", width: 75%),
    )
  ]
)[
  #figure(
    image("static/irc-demo-3pane-eng.png")
  )
  #pagebreak()
  #figure(
    image("static/irc-demo-3pane-singh-abdul.png")
  )
]
