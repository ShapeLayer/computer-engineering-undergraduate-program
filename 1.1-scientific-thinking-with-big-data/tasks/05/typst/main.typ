#let sans = ("Noto Sans KR", "Noto Sans CJK KR", "Noto Sans JP", "Noto Sans CJK JP")
#let serif = ("Noto Serif KR", "Noto Serif CJK KR", "Noto Serif JP", "Noto Serif CJK JP")
#let mono = ("Noto Sans Mono", "D2Coding", "MonoplexKR")

#set text(font: serif, size: 10pt)

// Required: Cover

#set page(columns: 1)

#align(horizon + center)[#text(size: 1.5em)[
  = 〈빅데이터의과학적탐구〉제5차 리포트
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
      #align(left)[〈빅데이터의과학적탐구〉제5차 리포트]
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
  [제5차 연습문제 답안],
  [〈빅데이터의과학적탐구〉 과제 \#5]
)

#let o1 = "①"
#let o2 = "②"
#let o3 = "③"
#let o4 = "④"


1. R에서 나머지와 몫을 구하는 산술연산자에 대하여 예시를 들어 설명하시오.

#ans[
  R은 실수 나눗셈 연산, 몫 연산, 나머지 연산을 모두 제공한다는 측면에서 파이썬과 비슷하다. 다만 구체적으로 그 연산자에 있어서는 파이썬과 다소 차이가 있다.

  \

  실수 나눗셈 연산은 `/`으로 파이썬과 동일하지만, 몫 연산은 `%/%`, 나머지 연산은 `%%`이다. 실제로는 다음과 같이 사용될 수 있다.

  ```r
  > 10 / 3
  [1] 3.333333
  > 10 %/% 3
  [1] 3
  > 10 %% 3
  [1] 1
  ```
]

\

2. 다음의 결과가 산출되는 `[ ]`에 들어가는 비교연산값을 구하시오.
  ```r
  x <- c(1, 2, 3, 4, 5, 6, 7)
  x[ ]
  # [1] 4 5 6 7
  ```

#ans([
  ```r
  > x <- c(1, 2, 3, 4, 5, 6, 7)
  > x[x >= 4]
  [1] 4 5 6 7
  ```
])

\

3. 다음의 결괏값을 산출하시오.
  ```r
  x <- 3
  y <- 5
  (x < 4) & (y < 4)
  ```

#ans([거짓(`False`)],
  desc: [
    ```r
    > x <- 3
    > y <- 5
    > (x < 4) & (y < 4)
    [1] FALSE
    ```
  ]
)

\

4. 반복문을 이용하여 1부터 100까지 숫자의 합을 산출하는 R 프로그램을 작성하시오.

#ans([```r
> x <- 0
> 
> for (i in 1:100) {
+   x <- x + i
+ }
> 
> x
[1] 5050
```])

\

5. 다음 값들에서 50 이상과 50 미만의 수량을 산출하는 R 프로그램을 작성하시오.
  ```text
  54, 39.6, 51.6, 52.8, 51.6, 52.8, 54, 52.8, 16.8, 52.8, 52.8, 54
  ```

#ans([
  ```r
  > get <- c(54, 39.6, 51.6, 52.8, 51.6, 52.8, 54, 52.8, 16.8, 52.8, 52.8, 54)
  > length(get)
  [1] 12
  > length(get[get >= 50])
  [1] 10
  > length(get[get < 50])
  [1] 2
  > 
  ```
])

\

6. 고수준 그래프 함수와 저수준 그래프 함수에 대하여 설명하시오.

#ans([
  저수준 그래픽 함수(low-level graphics function)는 어떤 그래프나 그래픽을 그릴 때, 가장 기초가 되는 선, 점 등을 그려낼 수 있는 원시적인 그래픽 함수들을 의미한다.

  고수준 그래픽 함수(high-level graphics function)는 내부적으로 이러한 저수준 함수들을 호출하면서 각 함수에 정의되어있는 형식의 그래프를 작성한다.

  선, 텍스트, 도형 그리기 함수 등을 이용하여 그래프를 그려내는 것은 매우 시간 소모적이므로, 일반적인 그래프 작성 과정에서는 고수준 함수로 그래프를 그려낸 후, 저수준 함수로 필요한 자료나 요소들을 보충하는 과정을 거친다.
])

\

7. `par()` 함수에 대하여 설명하시오.

#ans([
  `par` 함수는 그래픽의 출력 환경을 설정하거나 현재 설정을 확인하는 데 사용된다. 그래프의 여백(`mar`), 레이아웃(`mfrow`, `mfcol`), 글자 크기(`cex`), 색상(`col`)등의 외형을 결정할 수 있다.

  이 함수는 그래프의 출력 환경을 설정하므로, 이후에 호출되는 모든 그래프 작성 함수에 영향을 미친다.

  ```r
  # 화면을 2행 2열로 나누어 4개의 그래프를 한 화면에 출력하도록 설정
  par(mfrow = c(2, 2))

  # 그래프의 하, 좌, 상, 우 여백을 설정
  par(mar = c(5, 4, 4, 2))
  ```
])

\

다음은 세계 스마트폰 판매 현황이다.

#text(size: .8em)[#table(
  columns: 7,
  inset: (x: .5em, y: .8em),
  align: center + horizon,
  [*제조사*], [*Samsung*], [*Huawei*], [*Apple*], [*Xiaomi*], [*OPPO*], [*Other*],
  [*수량*], [2090], [0.158], [0.121], [0.093], [0.086], [0.332],
)]

\

```r
manufacturers <- c("Samsung", "Huawei", "Apple", "Xiaomi", "OPPO", "Other")
quantities <- c(2090, 0.158, 0.121, 0.093, 0.086, 0.332)  
```

\

8. 상기 값들에 대한 막대그래프를 작성하시오.

#ans(
  [
    #image("assets/8.png")
  ],
  desc: [
  ```r
  barplot(quantities, names.arg = manufacturers, 
          main = "세계 스마트폰 판매 현황", 
          col = "skyblue", 
          ylab = "수량",
          cex.names = 0.8)
  ```
  ]
)

\

9. 상기 값들에 대한 선그래프를 작성하시오.

#ans(
  [
    #image("assets/9.png")
  ],
  desc: [
  ```r
  plot(quantities, type = "o", col = "red", 
       xaxt = "n", # 기본 x축 숨김
       main = "세계 스마트폰 판매 현황", 
       xlab = "제조사", ylab = "수량")
    
  axis(1, at = 1:6, labels = manufacturers)
  ```
  ]
)

\

10. 상기 값들에 대한 파이 차트를 작성하시오.

#ans(
  [
    #image("assets/10.png")
  ],
  desc: [
  ```r
  pie(quantities, labels = manufacturers, 
      main = "세계 스마트폰 판매 현황", 
      col = rainbow(length(quantities)))
  ```
  ]
)
