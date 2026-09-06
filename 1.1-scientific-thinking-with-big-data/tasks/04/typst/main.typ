#let sans = ("Noto Sans KR", "Noto Sans CJK KR", "Noto Sans JP", "Noto Sans CJK JP")
#let serif = ("Noto Serif KR", "Noto Serif CJK KR", "Noto Serif JP", "Noto Serif CJK JP")
#let mono = ("Noto Sans Mono", "D2Coding", "MonoplexKR")

#set text(font: serif, size: 10pt)

// Required: Cover

#set page(columns: 1)

#align(horizon + center)[#text(size: 1.5em)[
  = 〈빅데이터의과학적탐구〉제4차 리포트
  \
  
  공과대학 컴퓨터정보통신공학과\
  박종현(214823)
]]

#pagebreak()
#counter(page).update(1)

// Required End

#set page(margin: (
  top: 15mm,
  bottom: 15mm,
  left: 15mm,
  right: 15mm,
),
  numbering: "1",
  header: [
    #text(size: .7em, fill: gray)[#columns(2)[
      #align(left)[〈빅데이터의과학적탐구〉제4차 리포트]
      #colbreak()
      #align(right)[박종현]
    ]
  ]]
)


// #show raw: it => text(font: mono)[#it]

#set text(font: serif, size: 10pt)
#show heading.where(
  level: 1
): it => block(width: 100%)[
  #set align(center)
  #text(weight: "regular", size: 1.3em)[
    #it.body
  ]
]

#show heading.where(level: 2): set text(size: 1.5em, weight: "semibold")
#show heading.where(level: 3): set text(size: 1.3em, weight: "regular")

#let img(path, size: 100%) = {
  align(center)[
    #image(path, width: size)
  ]
}

#let col2(..content) = {
  grid(
    columns: 2,
    ..content
  )
}

#let ans(ans, desc: none) = {
  grid(
    columns: 2,
    gutter: 1em,
    [답안], [#ans],
    ..if desc != none {
      ([의견], [#desc])
    } else {
      ()
    }
  )
}

#let rc(content) = text(fill: rgb("#e74c3c"))[#content]
#let cb(content) = block(fill: rgb("#f0f0f0"), inset: 1em, width: 100%)[#content]

#let ul(s) = [#underline[#link(s)]]

#set table(stroke: 0.5pt + black)

#let hero(
  title,
  subtitle,
) = [
  #place(
    top,
    float: true,
    scope: "parent",
    clearance: 30pt,
  )[
    = #title
    
    #align(center)[#text(size: 1.2em)[
      #subtitle
    ]]
    
    #align(center)[
    박종현, 
    공과대학 컴퓨터정보통신공학과\
    `jonghyeon@jnu.ac.kr`
    ]
  ]
]
#set page(columns: 2)

/**
 * Content Start
 */

#hero(
  [제4차 연습문제 답안],
  [〈빅데이터의과학적탐구〉 과제 \#4]
)

#let o1 = "①"
#let o2 = "②"
#let o3 = "③"
#let o4 = "④"


1. R에서 `setwd("C:/WORK_R")`와 `getwd()` 명령에 대하여 설명하시오.

#ans[
  `setwd`와 `getwd`의 wd는 Working Directory(워킹 디렉토리)라는 의미이다. `setwd`는 워킹 디렉토리의 setter, `getwd`는 워킹 디렉토리의 getter이다.
  
  워킹 디렉토리는 R에서 코드를 실행할 때, 어떤 파일을 참조하거나, 파일을 쓰기 작업 하는 등 파일 입출력 작업을 수행될 때 기준이 되는 경로이다. 다시 말해 워킹 디렉토리 값이 다르면 같은 명령도 다른 결과를 낼 수 있다.
]

\

2. R 패키지에 대하여 설명하고, 설치 시 유의점에 대하여 설명하시오.

#ans[
  R은 다른 사람이 미리 작성한 코드와 함수를 가져와 사용할 수 있게 하는 기능을 가지고 있다. 여기에 이어 이들 코드와 함수를 언어 인프라에서 저장하고 관리할 수 있게 했다.

  사용자는 자신이 작성한 코드를 패키지라는 단위로 묶어, R 인프라 중 패키지 레지스트리인 CRAN에 공개할 수 있다. 또, R 기본 함수 스펙에 CRAN으로부터 패키지를 다운로드받는 함수 정의인 `install`, `install.packages`를 추가하여, R 코드 상에서 즉시 패키지를 다운로드받아 사용할 수 있게 했다.

  \

  패키지 생태계가 성숙해지고 기술이 고도화됨에 따라, 대개의 패키지는 다른 패키지에 의존성을 가지게 되었다. 만약 패키지를 설치하는 과정에서 어떤 두 패키지가 다른 버전의 같은 패키지에 의존성을 갖는다면 버전 충돌, 혹은 패키지 설치가 제대로 수행되지 않을 수 있다.

  의존성 측면에서 모든 패키지는 R에 의존성을 가지는데, 대개는 문제가 없으나, R의 버전 상황에 따라서는 너무 오래된 패키지가 동작하지 않을 수 있다. 역으로 R이 너무 오래전 버전이라면, 개정된 표준이나 정의에 근거하는 최신 패키지가 제대로 동작하지 않을 수도 있다.

  \

  이들 패키지는 일반적으로 CRAN을 통해 다운로드받을 수 있지만, 최신 베타판, 혹은 몇 이유로 CRAN이 아니라 다른 경로를 통해 패키지가 배포되는 경우가 있을 수 있다. 이러한 경우 CRAN의 검수 절차를 거치지 않았기 때문에, 잠재적으로 오작동하거나 기기에 위험한 코드가 포함되어 있을 가능성이 있다. 설치 전에 이들 패키지가 정말 신뢰 가능한지 확인해야 한다.
]

\

3. R에서 1부터 999까지의 합계의 제곱근 값을 구하시오.

#ans(
  [
    $706.7531$
    
    ```r
    result <- 0
    for (i in 1:999) {
      result <- result + i
    }
    result ** 0.5
    ```
  ],
  desc: [
    ```r
    > result <- 0
    > for (i in 1:999) {
    +   result <- result + i
    + }
    > 
    > result ** 0.5
    [1] 706.7531
    ```
  ]
)

\

4. 다음 R에서 지원하는 자료 구조들에 대하여 설명하시오.
  
  (1) 벡터
  #ans[
    벡터 값을 표현하는 자료형이다. 일반적으로 벡터의 이론적 정의와 동일하게 $(3, 5)$와 같은 값 표현에 사용한다. 때문에 모든 벡터는 요소가 모두 동일한 자료형인 1차원의 배열과 같은 형태이다. `c`함수를 이용해 생성할 수 있다.
  
    ```r
    c(1, 2, 3, 4, 5)
    ```
  ]

  (2) 행렬
  #ans[
    행렬 값을 표현하는 자료형이다. 벡터가 2차원으로 확장되어 행과 열을 갖는 형태이다. 이 값은 `matrix`함수를 이용해 생성할 수 있다.
  
    ```r
    mat <- matrix(1:6, nrow = 2, ncol = 3)
    ```
  ]
  
  (3) 배열
  #ans[
    3차원 이상의 데이터 구조를 표현할 수 있도록 의도된 자료형이다. `array`함수를 이용해 생성할 수 있다.
  
    ```r
    arr <- array(1:12, dim = c(2, 3, 2))
    ```
  ]
  
  (4) 데이터프레임
  #ans[
    일종의 표, 엑셀 시트, 관계형 데이터베이스 테이블과 비슷한 개념으로 사용 가능한 자료형이다. 각 열은 벡터로 생성하여 동일한 자료형으로 구성되어야 하지만, 이들 열 사이에는 자료형이 같지 않아도 된다. `data.frame` 함수로 생성한다.
  
    ```r
    name <- c("박종현", "오민서", "김강산")
    age <- c(25, 24, 26)
    dept <- c("컴퓨터", "산업", "일어일문")
    
    df <- data.frame(이름 = name, 나이 = age, 학과 = dept)
    df
    ```
  ]
  
  (5) 리스트
  #ans[
    리스트는 서로 다른 자료 구조와 서로 다른 데이터 타입을 모두 담을 수 있는 가장 유연한 자료 구조이다. `list`로 생성한다.
  
    ```r
    my_list <- list(
      vec = c(1, 2, 3),
      mat = matrix(1:4, 2, 2),
      df = data.frame(x = 1:2, y = c("A", "B"))
    )
    ```
  ]
  
  (6) 요인
  #ans[
    팩터는 범주형 데이터를 표현하는 데 활용하는 것이 의도되는, 특별한 형태의 벡터이다.

    ```r
    gender_data <- c("남", "여", "남", "남", "여")
    
    gender_factor <- factor(gender_data)
    
    print(gender_factor)
    # [1] 남 여 남 남 여
    # Levels: 남 여
    
    print(as.numeric(gender_factor))
    # [1] 1 2 1 1 2
    ```
  ]

\
  
5. 다음의 변수 `a`에서 두 번째 원소인 2를 산출하는 명령을 쓰시오.
  ```r
  a <- c(1, 2, 0.5, 3, 7, -2, 10)
  ```

#ans([
  ```r
  a[2]
  ```
])

\

6. 다음 값들의 합계, 평균, 표준편차, 최솟값, 최댓값을 R에서 구하시오.
  ```r
  54, 39.6, 51.6, 52.8, 51.6, 52.8, 54, 52.8, 16.8, 52.8, 52.8, 54
  ```

#ans(
  [
    - 합계: $585.6$
    - 평균: $48.8$
    - 표준편차: $10.8101$
    - 최솟값: $16.8$
    - 최댓값: $54$
  ],
  desc: [
    ```r
    > v <- c(54, 39.6, 51.6, 52.8, 51.6, 52.8, 54, 52.8, 16.8, 52.8, 52.8, 54)
    > sum(v)
    [1] 585.6
    mean(v)
    > mean(v)
    [1] 48.8
    sd(v)
    > sd(v)
    [1] 10.8101
    > min(v)
    [1] 16.8
    > max(v)
    [1] 54
    ```
  ]
)

\

7. 다음의 벡터 `x`값을 행렬 `y`값으로 변경하는 명령을 쓰시오.
  ```r
  x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
  ```
  
  ```
  y
  [ ,1] [,2] [,3]
  [1,] 1 4 7
  [2,] 2 5 8
  [3,] 3 6 9
  ```

#ans[
  ```r
  y <- matrix(x, nrow = 3)
  ```
]

\
  
8. 다음과 같은 데이터프레임 `df`를 벡터값들을 이용하여 생성하시오.
  ```
   df
     x y z
   1 1 red TRUE
   2 2 white TRUE
   3 3 blue TRUE
   4 4 yellow FALSE
   ```

#ans[
  ```r
  _x <- c(1, 2, 3, 4)
  _y <- c("red", "white", "blue", "yellow")
  _z <- c(TRUE, TRUE, TRUE, FALSE)
  
  df <- data.frame(x = _x, y = _y, z = _z)
  df
  ```
]

\

9. 상기 데이터프레임 `df`에서 `x`행의 값들의 평균과 합계를 구하시오.

#ans(
  [
    - 평균: $2.5$
    - 합계: $10$
  ],
  desc: [
    ```r
    > mean(df$x)
    [1] 2.5
    > sum(df$x)
    [1] 10
    ```
  ]
)

\

10. 상기 데이터프레임 `df`에서 행의 이름을 '숫자', '색상', '논릿값'으로 변경하시오.

#ans[
  ```r
  > colnames(df) <- c("숫자", "색상", "논릿값")
  df
  > df
    숫자   색상 논릿값
  1    1    red   TRUE
  2    2  white   TRUE
  3    3   blue   TRUE
  4    4 yellow  FALSE
  ```
]
