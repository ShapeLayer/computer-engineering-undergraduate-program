#let sans = ("Noto Sans KR", "Noto Sans CJK KR", "Noto Sans JP", "Noto Sans CJK JP")
#let serif = ("Noto Serif KR", "Noto Serif CJK KR", "Noto Serif JP", "Noto Serif CJK JP")
#let mono = ("Noto Sans Mono", "D2Coding", "MonoplexKR")

#set text(font: serif, size: 10pt)

// Required: Cover

#set page(columns: 1)

#align(horizon + center)[#text(size: 1.5em)[
  = 〈빅데이터의과학적탐구〉제8차 리포트
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
      #align(left)[〈빅데이터의과학적탐구〉제8차 리포트]
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
  [제8차 연습문제 답안],
  [〈빅데이터의과학적탐구〉 과제 \#8]
)

#let o1 = "①"
#let o2 = "②"
#let o3 = "③"
#let o4 = "④"


#set table(stroke: 0.5pt + gray,)

1. 추론통계 기법인 평균 차이 분석, 비율 차이 분석, 분산분석, 상관관계 분석, 회귀분석에 대하여 설명하시오.

#ans[
  - 평균 차이 분석 (t-검정): 두 집단 간의 평균이 통계적으로 유의미한 차이가 있는지 검정한다. 
  - 비율 차이 분석 (교차분석/$chi^2$-검정): 두 범주형 변수 간의 관련성이나 비율의 차이가 있는지 검정한다.
  - 분산분석 (ANOVA): 세 집단 이상의 평균을 비교할 때 사용하며, 집단 내 분산 대비 집단 간 분산의 크기를 비교하여 차이를 검정한다.
  - 상관관계 분석: 두 수치형 변수 간의 선형적 관련성, 강도와 방향을 분석한다. 이 때 사용되는 상관계수 $r$ 은 -1에서 1 사이의 값을 가진다.
  - 회귀분석: 독립변수가 종속변수에 미치는 영향력을 모델링하고 예측하는 기법이다. 변수 간의 인과관계를 파악하는 데 주로 사용된다.
]

\

2. http://ssra.or.kr.co.kr/bigdata/data.csv 에서 data.csv 파일을 다운로드하여 R로 불러들여 `data`라는 데이터프레임 변수로 만들고, 이 데이터프레임의 소득 변수에 대하여 성별 평균 차이 분석을 수행하고 결과를 해석하시오.

#ans[
  ```r
  data <- read.csv("data.csv")
  t.test(data$소득 ~ data$성별)
  ```
  \
  ```
  
          Welch Two Sample t-test
  
  
  data:  data$소득 by data$성별
  t = -0.28289, df = 80.512, p-value = 0.778
  alternative hypothesis: true difference in means between group 남자 and group 여자 is not equal to 0
  95 percent confidence interval:
   -891.0445  669.2263
  sample estimates:
  mean in group 남자 mean in group 여자 
            5159.091           5270.000 
  ```
  
  \

  소득과 성별 간 관계에 대해, p-value 0.778로 신뢰구간 95%에서 귀무가설을 기각할 수 없다. 따라서 두 변수는 독립이다.
]

\

3. 상기 데이터프레임에서 다음과 같이 만족 여부 변수를 생성한 후, 만족 여부에 대한 성별 비율 차이 분석을 수행하고 결과를 해석하시오.

  ```r
  data$만족여부 <- ifelse((data$쇼핑만족도 > 3), '만족', '불만족')
  ```

#ans[
  ```r
  data$만족여부 <- ifelse((data$쇼핑만족도 > 3), '만족', '불만족')
  table(data$만족여부, data$성별)
  ```
  \
  ```
          
           남자 여자
    만족     53   31
    불만족    2    4
  ```
  \
  ```r
  chisq.test(table(data$만족여부, data$성별))
  ```
  \
  ```
          Pearson's Chi-squared test with Yates' continuity correction
  
  data:  table(data$만족여부, data$성별)
  X-squared = 1.0227, df = 1, p-value = 0.3119
  
  Warning message:
  In chisq.test(table(data$만족여부, data$성별)) :
    Chi-squared approximation may be incorrect
  ```
  \
  만족 여부와 성별 간 관계에 대해, p-value 0.3119로 신뢰구간 95%에서 귀무가설을 기각할 수 없다. 따라서 두 변수는 독립이다.
]
  
4. 상기 데이터프레임의 소득 변수에 대하여 주거지역에 대한 분산분석을 수행하고 결과를 해석하시오.

#ans[
  ```r
  data$주거지역 <- as.factor(data$주거지역)
  aov_result <- aov(data$소득 ~ data$주거지역)
  summary(aov_result)
  ```
  \
  ```
                Df    Sum Sq Mean Sq F value Pr(>F)
  data$주거지역  2   2593896 1296948   0.367  0.694
  Residuals     87 307840660 3538398  
  ```
  \
  주거지역과 소득 간 관계에 대해, p-value 0.694로 신뢰구간 95%에서 귀무가설을 기각할 수 없다. 따라서 두 변수는 독립이다.
]

\

5. 상기 데이터프레임의 쇼핑액과 쇼핑만족도 간의 상관관계 분석을 수행하고 결과를 해석하시오.

#ans[
  ```r
  cor.test(data$쇼핑액, data$쇼핑만족도)
  ```
  \
  ```
  
          Pearson's product-moment correlation
  
  data:  data$쇼핑액 and data$쇼핑만족도
  t = 0.041531, df = 88, p-value = 0.967
  alternative hypothesis: true correlation is not equal to 0
  95 percent confidence interval:
   -0.2028499  0.2113246
  sample estimates:
          cor 
  0.004427222 
  ```
  \
  쇼핑액과 쇼핑만족도 간 관계에 대해, p-value 0.967로 신뢰구간 95%에서 귀무가설을 기각할 수 없다. 따라서 두 변수는 독립이다.
]

\

6. 상기 데이터프레임의 쇼핑액에 대한 소득, 이용만족도가 쇼핑만족도의 영향 유무를 알아보기 위한 회귀분석을 수행하고 결과를 해석하시오.

#ans[
  ```r
  lm_result <- lm(data$쇼핑만족도 ~ data$소득 + data$이용만족도)
  summary(lm_result)
  ```
  \
  ```
  Call:
  lm(formula = data$쇼핑만족도 ~ data$소득 + data$이용만족도)
  
  Residuals:
      Min      1Q  Median      3Q     Max 
  -3.4518 -0.4372  0.2334  0.5949  2.5652 
  
  Coefficients:
                   Estimate Std. Error t value Pr(>|t|)    
  (Intercept)     1.667e+00  5.840e-01   2.854  0.00539 ** 
  data$소득       2.430e-05  6.345e-05   0.383  0.70267    
  data$이용만족도 6.617e-01  8.342e-02   7.932 6.81e-12 ***
  ---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
  
  Residual standard error: 1.114 on 87 degrees of freedom
  Multiple R-squared:   0.42,     Adjusted R-squared:  0.4067 
  F-statistic:  31.5 on 2 and 87 DF,  p-value: 5.108e-11
  ```
  \
  소득과 이용만족도가 쇼핑만족도에 미치는 영향에 대해, 소득의 p-value 0.70267로 신뢰구간 95%에서 귀무가설을 기각할 수 없다. 따라서 소득은 쇼핑만족도에 영향을 미치지 않는다.

  반면 이용만족도의 p-value 6.81e-12로 신뢰구간 95%에서 귀무가설을 기각할 수 있다. 따라서 이용만족도는 쇼핑만족도에 영향을 미친다. 회귀모형의 R-squared 값이 0.42로, 이 모형이 쇼핑만족도의 변동성의 42%를 설명한다. F-statistic의 p-value 5.108e-11로, 이 모형이 유의미하다고 할 수 있다.
]
