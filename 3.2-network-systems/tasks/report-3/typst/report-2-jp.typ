#import "style.typ": font-family, pallete, section, theme, url, vulnerability-chart

#let primary-color = pallete.misc.ghudegy

#show: theme.with(
  title: "C言語によるIRCサーバ実装のDocker化",
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
          C言語によるIRCサーバ実装の\ Docker化
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

#show raw.where(block: true): it => text(size: .7em)[#it]

#section(
  title: "Docker化 (Dockerizing)",
  primary-color: primary-color,
  hero: [
    - 自身のPCにDocker環境を構築
    
    - 簡単なWEBサーバの起動を確認
  ],
)[
  - ビルド環境の宣言
    - GCCベースイメージを使用し、GitHubからCMakeをフェッチしてビルド

  ```Dockerfile
  FROM gcc:latest

  WORKDIR /root
  RUN mkdir temp
  WORKDIR /root/temp
  RUN curl -OL https://github.com/Kitware/CMake/releases/download/v4.2.1/cmake-4.2.1.tar.gz
  RUN tar -xzvf cmake-4.2.1.tar.gz

  WORKDIR /root/temp/cmake-4.2.1
  RUN ./bootstrap -- -DCMAKE_BUILD_TYPE:STRING=Release
  RUN make -j4
  RUN make install
  
  ...
  ```

  #pagebreak()

  - サーバ側のソースコードのビルド

  ```Dockerfile
  FROM gcc:latest

  ...

  WORKDIR /usr/src/app
  COPY ./server/include ./server/include
  COPY ./server/src ./server/src
  COPY ./server/CMakeLists.txt ./server/CMakeLists.txt
  COPY ./include ./include

  WORKDIR /usr/src/app/server
  RUN mkdir build
  WORKDIR /usr/src/app/server/build
  RUN cmake .. 
  RUN make
  ```

  #pagebreak()

  - コンテナ実行時のサーバプログラム実行の定義

  ```Dockerfile
  FROM gcc:latest
  
  ...


  EXPOSE 6667

  CMD ["/usr/src/app/server/build/simple_irc_server"]
  ```

  #pagebreak()

  - コンテナ内のディレクトリ構造

  ```
  /root/tmp
         ↳/cmake-4.2.1.tar.gz
         ↳/cmake-4.2.1/
  /usr/src/app
             ↳/server
                   ↳/build
                        ↳/simple_irc_server
  ```
]

#section(
  title: "検証 (Verify)",
  primary-color: primary-color,
  hero: [
    - Dockerfileを追加作成し、イメージのビルドとコンテナの実行を行う

    - サーバはコンテナ化されたか？

    - サーバはエラーなく意図通りに動作するか？
  ]
)[
  ```sh
  ❯ docker build . -t simple-irc-server
  ❯ docker run --name simple-irc-server -d -p 6667:6667 simple-irc-server
  ```

  \
  
  ```sh
  ❯ docker ps
  CONTAINER ID   IMAGE               COMMAND                  CREATED          STATUS          PORTS                                         NAMES
  1331a57eabc0   simple-irc-server   "/usr/src/app/server…"   17 seconds ago   Up 17 seconds   0.0.0.0:6667->6667/tcp, [::]:6667->6667/tcp   simple-irc-server
  ```

  #pagebreak()

  #grid(
    columns: 2,
    gutter: .8em,
    [
      - Session \#0
      ```
      ❯ ./simple_irc_client
      Connected to server!
      Commands: /nick <name> to change nickname.
      Welcome! You are Guest0. Use '/nick <name>' to change nickname.
      ぷにぷに
      [Guest1]: ぷにぷにって言うな！
      [Guest1]: おい！赤スーパーだったからって、ぷて言えば許されるとでも思ってるのか！他に言うことがあるだろ！
      [Guest1]: おいなんかいうことがあったろ
      …でもかわいい
      [Guest1]: あ、いいね
      [Guest1]: 気分がよくなってきた
      かわいいでもぷにぷに…
      [Guest1]: …何か意味違うそう
      ```
    ],
    [
      - Session \#1
      ```
      ❯ ./simple_irc_client
      Connected to server!
      Commands: /nick <name> to change nickname.
      Welcome! You are Guest1. Use '/nick <name>' to change nickname.
      [Guest0]: ぷにぷに
      ぷにぷにって言うな！
      おい！赤スーパーだったからって、ぷにぷにって言えば許されるとでも思ってるのか！他に言うことがあるだろ！
      おいなんかいうことがあったろ
      [Guest0]: …でもかわいい
      あ、いいねいいね
      気分がよくなってきた
      [Guest0]: かわいいでもぷにぷに…
      …何か意味違うそう
      ```
    ]
  )

  #pagebreak()

  - Host
  ```
  docker kill simple-irc-server
  ```

  
  #grid(
    columns: 2,
    gutter: .8em,
    [
      - Session \#0
      ```
      ❯ ./simple_irc_client
      ...
      かわいいでもぷにぷに…
      [Guest1]: …何か意味違うそう
      Disconnected from server.
      ```
    ],
    [
      - Session \#1
      ```
      ❯ ./simple_irc_client
      ...
      [Guest0]: かわいいでもぷにぷに…
      …何か意味違うそう
      Disconnected from server.
      ```
    ]
  )
  
]

#pagebreak()
