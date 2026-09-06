#let sans = ("Noto Sans KR", "Noto Sans CJK KR", "Noto Sans JP", "Noto Sans CJK JP")
#let serif = ("Noto Serif KR", "Noto Serif CJK KR", "Noto Serif JP", "Noto Serif CJK JP")
#let mono = ("Noto Sans Mono", "D2Coding", "MonoplexKR")

#set text(font: serif, size: 10pt)

// Required: Cover

#set page(columns: 1)

#align(horizon + center)[#text(size: 1.5em)[
  = 〈빅데이터의과학적탐구〉제7차 리포트
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
      #align(left)[〈빅데이터의과학적탐구〉제7차 리포트]
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
    jonghyeon\@jnu.ac.kr
    ]
  ]
]

#show raw.where(block: false): it => box(fill: rgb("f5f5f5"), outset: (y: 5pt), inset: (x: 5pt), text(fill: red, it))
#show raw.where(block: true): it => block(fill: rgb("f5f5f5"), outset: (y: 10pt), inset: (x: 10pt), width: 100%, it)

/**
 * Content Start
 */

#hero(
  [제7차 연습문제 답안],
  [〈빅데이터의과학적탐구〉 과제 \#7]
)

#let o1 = "①"
#let o2 = "②"
#let o3 = "③"
#let o4 = "④"


#set table(stroke: 0.5pt + gray,)

1. 기술통계 기법인 빈도분석, 기술 분석, 교차분석, 다차원 척도법에 대하여 설명하시오.

#ans[
  빈도분석(Frequency Analysis)은 데이터에서 개별 값들이 등장하는 횟수를 산출하여 데이터의 분포 특징을 파악하는 분석을 의미한다. 분석 대상은 무엇이든 될 수 있는데, 주로 빈도분석이 사용되는 범주형 데이터 뿐 아니라, 문자열 분석, 언어 특성 연구, 기초 암호학 등에서 빈출 데이터가 주요한 메트릭 중 하나로 간주된다. 일반적인 빈도분석에서는 성별, 지역 등의 범주형 변수의 특성 파악, 이상치 식별, 일반화 작업에 사용된다.

  기술 분석(Descriptive Analysis)은 어떤 데이터를 서술하는 데 동원되는, 데이터의 전체적인 특징을 요약하여 설명하는 통계량을 산출하여 사용하는 분석이다. 평균, 분산, 표준편차, 최솟값, 최댓값, 왜도, 첨도 등의 통계치를 사용하여 데이터의 분포, 경향성 등을 파악한다.
  
  교차분석(Crosstab Analysis)은 두 개 이상의 범주형 변수 간의 관계를 파악하기 위해 빈도와 비율을 교차표로 작성하는 분석을 의미한다. 변수 간의 독립성이나 관련성을 확인하는 데 사용된다.

  다차원 척도법(Multidimensional Scaling, MDS)은 객체 간의 유사성/비유사성을 측정하여 다차원 공간에 점으로 표현하는 분석이다. 개체들 간의 상대적 위치를 시각화하여 구조적인 관계를 이해하기 쉽게 도와준다.
]

\

2. 자료를 구분하는 명목척도, 서열척도, 등간척도, 비율척도에 대하여 설명하시오.

#ans[
  명목척도(Nominal Scale)는 단순히 대상을 분류하거나 구분하기 위해 이름을 붙인 명목상의 척도이다. 성별에서 남/여 값, 혈액형, 지역 등 값에 이름을 붙인 것이 대표적으로, 산술 연산이 불가능하다.

  서열척도(Ordinal Scale)는 순서나 서열의 의미를 갖거나, 갖도록 만들 수 있는 척도이다. 직급, 학점(A/B/C), 만족도 순위 등이 이에 해당하는데, 이들의 순위는 알 수 있지만 이들 값의 간격이 일정함이 보장되지는 않는다.

  등간척도(Interval Scale)는 측정 값 사이의 간격이 산술적으로 일정한 서열 척도이다. 온도나 IQ 등의 척도가 여기에 해당하는데, 절대 0점이 없으며 덧셈, 뺄셈이 가능하다.

  비율척도 (Ratio Scale)는 모든 측정의 속성을 갖추고 있으며서 절대 영점이 존재하는 척도이다. 몸무게, 키, 소득, 쇼핑액 등이 이에 해당한다. 이들 값은 곱셈, 나눗셈을 포함하여 모든 산술 연산이 가능하다.
]

\

3. `http://ssra.or.kr.co.kr/bigdata/data.csv`에서 `data.csv` 파일을 다운로드하여 R로 불러들여 `data`라는 데이터프레임 변수로 만들고, 이 데이터프레임의 성별, 연령대, 직업, 주거지역 변수들에 대하여 `descr` 패키지를 이용한 빈도분석을 수행하여 빈도표와 막대그래프를 작성하시오.

#ans[
  #grid(
    columns: 4,
    [#figure(image("assets/3-1-성별분포.png"), caption: [성별분포의 빈도 막대그래프])],
    [#figure(image("assets/3-2-연령대분포.png"), caption: [연령대분포의 빈도 막대그래프])],
    [#figure(image("assets/3-3-직업분포.png"), caption: [직업분포의 빈도 막대그래프])],
    [#figure(image("assets/3-4-주거지역분포.png"), caption: [주거지역분포의 빈도 막대그래프])],
  )

  \

  ```R
  data <- read.csv("data.csv")
  ```

  \
  
  ```R
  freq_vars <- c("성별", "연령대", "직업", "주거지역")
  for(v in freq_vars) {
    cat("\n---", v, "빈도분석 결과 ---\n")
    freq_table <- freq(data[[v]], plot=TRUE, main=paste(v, "분포"))
    print(freq_table)
  }
  ```
]

\

4. 상기 데이터프레임의 쇼핑액 변수에 대하여 `psych` 패키지를 이용한 기술 분석을 수행하여 표본 수, 평균, 표준편차, 중앙값, 최솟값, 최댓값, 범위, 왜도, 첨도, 표준오차 값을 산출하시오.

#ans[
  #align(center)[
    #table(
      columns: 4,
      align: left + horizon,
      [vars], [1], [n], [90],
      [mean], [174.2], [sd], [35.46],
      [median], [172.8], [trimmed], [175.17],
      [mad], [32.02], [min], [80.4],
      [max], [244.8], [range], [164.4],
      [skew], [-0.26], [kurtosis], [-0.01],
      [se], [3.74], [], []
    )
  ]
  
  ```R
  > shopping_desc <- describe(data$쇼핑액)
  > print(shopping_desc)
     vars  n  mean    sd median trimmed   mad  min   max range  skew kurtosis   se
  X1    1 90 174.2 35.46  172.8  175.17 32.02 80.4 244.8 164.4 -0.26    -0.01 3.74
  ```
]

\

5. 상기 데이터프레임을 이용한 교차분석을 수행하여 성별을 행, 연령대를 열로 하여 교차빈도표를 작성하시오.

#ans[
  #table(
  columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto),
  inset: 7pt,
  align: center + horizon,
  table.header(
    [*성별*], [*항목*], [*25-29세*], [*30-34세*], [*35-39세*], [*40-44세*], [*45-49세*], [*50세 이상*], [*Total*]
  ),
  
  // 남자 데이터
  table.cell(rowspan: 5)[*남자*], [$N$], [4], [9], [4], [5], [10], [23], [55],
  [$sqrt(Chi)$], [0.030], [0.772], [0.018], [0.441], [1.485], [0.868], table.cell(rowspan: 4)[0.611],
  [$N/"Row Total"$], [0.073], [0.164], [0.073], [0.091], [0.182], [0.418],
  [$N/"Col Total"$], [0.667], [0.818], [0.571], [0.455], [0.417], [0.742],
  [$N/"Table Total"$], [0.044], [0.100], [0.044], [0.056], [0.111], [0.256],
  
  // 여자 데이터
  table.cell(rowspan: 5)[*여자*], [$N$], [2], [2], [3], [6], [14], [8], [35],
  [$sqrt(Chi)$], [0.048], [1.213], [0.028], [0.693], [2.333], [1.364], table.cell(rowspan: 4)[0.389],
  [$N/"Row Total"$],[0.057], [0.057], [0.086], [0.171], [0.400], [0.229],
  [$N/"Col Total"$],[0.333], [0.182], [0.429], [0.545], [0.583], [0.258],
  [$N/"Table Total"$],[0.022], [0.022], [0.033], [0.067], [0.156], [0.089],
  
  // Total 데이터
  [*Total*], [-], [6], [11], [7], [11], [24], [31], [*90*],
  [], [-], [0.067], [0.122], [0.078], [0.122], [0.267], [0.344], []
)

  
  \
  
  ```R
  > cross_tab <- CrossTable(data$성별, data$연령대)
  Warning message:
  In chisq.test(tab, correct = FALSE, ...) :
    Chi-squared approximation may be incorrect
  
  > print(cross_tab)
     Cell Contents 
  |-------------------------|
  |                       N | 
  | Chi-square contribution | 
  |           N / Row Total | 
  |           N / Col Total | 
  |         N / Table Total | 
  |-------------------------|
  
  ================================================================================
               data$연령대
  data$성별    25-29세   30-34세   35-39세   40-44세   45-49세   50세 이상   Total
  --------------------------------------------------------------------------------
  남자               4         9         4         5        10          23      55
                 0.030     0.772     0.018     0.441     1.485       0.868        
                 0.073     0.164     0.073     0.091     0.182       0.418   0.611
                 0.667     0.818     0.571     0.455     0.417       0.742        
                 0.044     0.100     0.044     0.056     0.111       0.256        
  --------------------------------------------------------------------------------
  여자               2         2         3         6        14           8      35
                 0.048     1.213     0.028     0.693     2.333       1.364        
                 0.057     0.057     0.086     0.171     0.400       0.229   0.389
                 0.333     0.182     0.429     0.545     0.583       0.258        
                 0.022     0.022     0.033     0.067     0.156       0.089        
  --------------------------------------------------------------------------------
  Total              6        11         7        11        24          31      90
                 0.067     0.122     0.078     0.122     0.267       0.344        
  ================================================================================
  ```
]

\

6. 상기 데이터프레임의 사번 변수에 대하여 쇼핑1월, 쇼핑2월, 쇼핑3월의 변수들을 이용한 다차원 분석을 수행하여 다차원 분석 그래프를 작성하시오.

#ans[
  #figure(image("assets/6-다차원분석그래프.png", width: 70%), caption: [다차원분석 그래프])

  \

  ```R
  mds_data <- data[, c("쇼핑1월", "쇼핑2월", "쇼핑3월")]
  dist_matrix <- dist(mds_data) # 유클리드 거리 계산
  mds_fit <- cmdscale(dist_matrix) # 다차원척도법
  plot(mds_fit, 
       pch = 19,
       col = "blue")
  text(mds_fit, labels=data$사번, cex=0.7)
  ```
]

\

7. 상기 데이터프레임을 이용한 그룹 분석을 수행하여 연령대별 평균 이용만족도 점수를 산출하시오.

#ans[
  #align(center)[
    #table(
      columns: (auto, auto),
      align: center + horizon,
      table.header(
        [*연령대*], [*이용만족도*]
      ),
      [25‑29세],   [5.333333],
      [30‑34세],   [4.818182],
      [35‑39세],   [5.428571],
      [40‑44세],   [5.090909],
      [45‑49세],   [5.250000],
      [50세 이상], [5.451613]
    )
  ]

  \
  
  ```R
  > group_mean <- aggregate(이용만족도 ~ 연령대, data = data, mean)
  > print(group_mean)
       연령대 이용만족도
  1   25-29세   5.333333
  2   30-34세   4.818182
  3   35-39세   5.428571
  4   40-44세   5.090909
  5   45-49세   5.250000
  6   50세 이상  5.451613
  ```
]

\

8. 상기 데이터프레임의 쇼핑액 변수를 `round()` 함수를 이용하여 소수점을 제거한 후 박스 플롯(Box Plot)을 작성하고 해석하시오.

#ans[
  #figure(image("assets/8-boxplot.png", width: 70%), caption: [박스플롯])
  
  \
  
  ```R
  data$쇼핑액_round <- round(data$쇼핑액)
  ```

  \

  ```R
  boxplot(data$쇼핑액_round, main="쇼핑액 박스 플롯", ylab="쇼핑액")
  ```
]

\

9. 상기 데이터프레임의 쇼핑액 변수를 `round()` 함수를 이용하여 소수점을 제거한 후 줄기 잎 도표(Stem-and-Leaf Plot)를 작성하고 해석하시오.

#ans[
  ```R
  > stem(data$쇼핑액_round)

  The decimal point is 1 digit(s) to the right of the |

   8 | 026
  10 | 22368
  12 | 64468
  14 | 35568814556
  16 | 00111111234688889000246668
  18 | 00111245555344466669
  20 | 0245805667
  22 | 160233889
  24 | 5
  ```
]

\

10. 상기 데이터프레임의 쇼핑액 변수를 `round()` 함수를 이용하여 소수점을 제거한 후 Q-Q 도표(Q-Q Plot)를 작성하고 해석하시오.

#ans[
  #figure(image("assets/10-qqplot.png", width: 70%), caption: [Q-Q 플롯])

  ```R
  qqnorm(data$쇼핑액_round)
  qqline(data$쇼핑액_round, col="red")
  ```
]
