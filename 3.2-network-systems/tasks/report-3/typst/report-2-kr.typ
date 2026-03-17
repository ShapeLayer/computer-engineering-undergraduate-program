#import "style.typ": font-family, pallete, section, theme, url, vulnerability-chart

#let primary-color = pallete.misc.ghudegy

#show: theme.with(
  title: "C IRC 서버 구현체의 도커라이징",
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
          C IRC 서버 구현체의 도커라이징
        ]
      ]]
    ]
    #align(center + horizon)[#text(fill: primary-color, size: 22pt, weight: "medium")[
      Jonghyeon PARK\
      
      #text(size: .7em)[
        2026-01\
        General Exchange Student, Faculty of Science and Engineering, Saga University\
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
  title: "Dockerizing",
  primary-color: primary-color,
  hero: [
    - 자신의 PC에 Docker 환경을 구축
    
    - 간단한 WEB 서버의 기동을 확인
  ],
)[
  - 빌드 환경 선언
    - GCC 베이스 이미지 사용, CMake를 GitHub에서 Fetch하여 빌드

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

  - 서버 측 소스코드 빌드

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

  - 컨테이너 실행 시 서버 프로그램 실행 정의

  ```Dockerfile
  FROM gcc:latest
  
  ...


  EXPOSE 6667

  CMD ["/usr/src/app/server/build/simple_irc_server"]
  ```

  #pagebreak()

  - 컨테이너의 디렉토리 상태

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
  title: "Verify",
  primary-color: primary-color,
  hero: [
    - Dockerfile만 추가 작성하고 이미지 빌드, 컨테이너 실행

    - 서버는 컨테이너화 되었나?

    - 서버는 오류 없이 의도대로 동작하나?
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
