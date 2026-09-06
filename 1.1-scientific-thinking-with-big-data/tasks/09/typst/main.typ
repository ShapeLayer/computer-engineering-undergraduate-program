#let sans = ("Noto Sans KR", "Noto Sans CJK KR", "Noto Sans JP", "Noto Sans CJK JP")
#let serif = ("Noto Serif KR", "Noto Serif CJK KR", "Noto Serif JP", "Noto Serif CJK JP")
#let mono = ("Noto Sans Mono", "D2Coding", "MonoplexKR")

#set text(font: serif, size: 10pt)

// Required: Cover

#set page(columns: 1)

#align(horizon + center)[#text(size: 1.5em)[
  = 〈빅데이터의과학적탐구〉제9차 리포트
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
      #align(left)[〈빅데이터의과학적탐구〉제9차 리포트]
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


#show raw.where(block: false): it => box(fill: rgb("f5f5f5"), outset: (y: 3pt), inset: (x: 2pt), text(fill: red, it))
#show raw.where(block: true): it => block(fill: rgb("f5f5f5"), inset: (x: 10pt, y: 10pt), width: 100%, it)

/*
 * Content Start
 */

#hero(
  [제9차 연습문제 답안],
  [〈빅데이터의과학적탐구〉 과제 \#9]
)

#let o1 = "①"
#let o2 = "②"
#let o3 = "③"
#let o4 = "④"


#set table(stroke: 0.5pt + gray,)

1. 데이터마이닝의 분석 유형인 분류 분석, 예측 분석, 군집 분석, 연관 분석에 대해 각각 설명하시오.

#ans[
  - 분류 분석 (Classification): 데이터가 속한 범주를 예측하는 기법입니다. 이미 정해진 클래스 레이블이 있는 학습 데이터를 사용하여 모델을 만든 뒤, 새로운 데이터가 들어왔을 때 어느 그룹에 속할지 결정합니다.
    - 예시: 스팸 메일 여부 판별(스팸/정상), 은행 대출 승인 여부(승인/거절), 질병 진단(양성/음성).
  - 예측 분석 (Prediction): 과거의 데이터를 바탕으로 현재 혹은 미래의 수치를 추정하는 기법입니다. (광의의 의미로 분류를 포함하기도 하지만, 일반적으로 회귀 분석을 뜻함) 시간의 흐름에 따른 트렌드나 변수 간의 상관관계를 분석하여 연속된 값을 예측합니다.
    - 예시: 내일의 기온 예측, 다음 달 주가 예상, 아파트 가격 추정.
  - 군집 분석 (Clustering): 명확한 기준(레이블)이 없는 상태에서 데이터 간의 유사성을 측정하여 비슷한 특성을 가진 것들끼리 그룹으로 묶는 기법입니다. 분류 분석과 달리 미리 정의된 그룹이 없으며, 데이터 자체의 구조를 파악하는 데 중점을 둡니다.
    - 예시: 고객 구매 패턴에 따른 시장 세분화, 유사한 뉴스 기사 그룹핑.
  - 연관 분석 (Association): 데이터 항목들 간에 존재하는 '만약 \~하면 \~한다' 형태의 연관 규칙을 찾아내는 기법입니다. 항목 간의 동시 발생 빈도를 분석하며, 흔히 '장바구니 분석'이라고 불립니다.
    - 예시: "맥주를 사는 사람은 기저귀도 함께 살 확률이 높다", 상품 추천 시스템.
]

\

2. 기계학습의 학습 방법인 지도 학습(supervised learning)과 비지도 학습(unsupervised learning)에 대해 설명하시오.

#ans[
  기계학습은 학습 데이터에 정답(Label)이 포함되어 있는지 여부에 따라 크게 지도 학습과 비지도 학습으로 구분됩니다.

  - 지도 학습 (Supervised Learning): 입력 데이터($X$)와 함께 그에 대한 정답(레이블, $Y$)을 컴퓨터에게 제공하여 학습시키는 방법입니다. 입력과 출력 사이의 매핑 함수를 학습하여, 정답이 없는 새로운 데이터가 들어왔을 때 정확한 결과를 출력하는 것입니다.
    - 주요 알고리즘: 회귀 분석(Regression), 의사결정나무(Decision Tree), 서포트 벡터 머신(SVM), 신경망(Neural Network), K-NN 등.

  - 비지도 학습 (Unsupervised Learning): 입력 데이터($X$)만 있고 정답(레이블)이 제공되지 않는 상태에서 학습하는 방법입니다. 데이터 내부에 숨겨진 특징, 구조, 패턴 또는 군집을 발견하는 것입니다.
    - 주요 알고리즘: 군집 분석(K-Means), 주성분 분석(PCA), 연관 규칙 학습 등.
]

\

3. `http://ssra.or.kr/bigdata/job.csv` 파일을 R로 불러와 job이라는 데이터프레임으로 만드시오. 그리고 이 데이터프레임의 직무에 대해 아와활동성, 사고성, 보수성 값을 가지고 단순 베이즈 분류를 수행하고 그 결과를 해석하시오.

  #table(
    columns: (1fr, 1fr, 1fr, 1fr),
    align: center,
    [야외활동성], [사교성], [보수성], [직무],
    [10], [22], [5], [고객 서비스],
    [14], [17], [6], [관리 업무],
    [19], [33], [7], [생산 업무],
    [14], [29], [12], [생산 서비스],
    [14], [25], [7], [고객 서비스],
    [20], [25], [12], [관리 업무],
  )

#ans[
  ```R
  nb_model <- naiveBayes(직무 ~ ., data = job)
  ```

  ```R
  nb_pred <- predict(nb_model, job)
  table(actual = job$직무, predict = nb_pred)
  ```

  ```txt
                predict
  actual       고객서비스 관리업무 생산업무
    고객서비스         24        1        6
    관리업무            0       14        5
    생산업무            2        4       34
  ```
  
  #align(center)[ #table( columns: (auto, 1fr, 1fr, 1fr), align: center, stroke: 0.5pt + gray, [], [고객서비스 (P)], [관리업무 (P)], [생산업무 (P)], [고객서비스 (A)], [24], [1], [6], [관리업무 (A)], [0], [14], [5], [생산업무 (A)], [2], [4], [34] ) ]

  ```R
  print(nb_model)
  ```

  ```txt
  Naive Bayes Classifier for Discrete Predictors
  
  Call:
  naiveBayes.default(x = X, y = Y, laplace = laplace)
  
  A-priori probabilities:
  Y
  고객서비스   관리업무   생산업무 
   0.3444444  0.2111111  0.4444444 
  
  Conditional probabilities:
              야외활동성
  Y                [,1]     [,2]
    고객서비스 11.67742 5.081910
    관리업무   15.26316 4.919825
    생산업무   19.05000 2.917234
  
              사교성
  Y                [,1]     [,2]
    고객서비스 23.54839 4.380553
    관리업무   14.21053 3.521031
    생산업무   22.05000 4.489018
  
              보수성
  Y                 [,1]     [,2]
    고객서비스  8.709677 3.121896
    관리업무   12.526316 2.969632
    생산업무   10.475000 2.810124
  ```
]
  
  \
  
4. 상기 데이터에 대해 K-최근접 이웃 분류 분석을 수행하고 결과를 해석하시오.

#ans[
  ```R
  library(class)
  
  # 예측 변수와 타겟 변수 분리
  train_x <- job[, c("야외활동성", "사교성", "보수성")]
  train_y <- job$직무
  
  # K-NN 수행
  knn_pred <- knn(train = train_x, test = train_x, cl = train_y, k = 3)
  
  # 결과 확인
  table(actual = train_y, predict = knn_pred)
  ```
  ```txt
                predict
  actual       고객서비스 관리업무 생산업무
    고객서비스         24        2        5
    관리업무            0       16        3
    생산업무            0        2       38
  ```

  #align(center)[ #table( columns: (auto, 1fr, 1fr, 1fr), align: center, stroke: 0.5pt + gray, [], [고객서비스 (P)], [관리업무 (P)], [생산업무 (P)], [고객서비스 (A)], [24], [2], [5], [관리업무 (A)], [0], [16], [3], [생산업무 (A)], [0], [2], [38] ) ]
]

\

5. 상기 데이터에 대해 서포트 벡터 머신 분류 분석을 수행하고 결과를 해석하시오.

#ans[
  ```R
  library(e1071)

  job$직무 <- as.factor(job$직무)
  svm_model <- svm(직무 ~ ., data = job, kernel = "radial")
  svm_pred <- predict(svm_model, job)
  
  table(actual = job$직무, predict = svm_pred)
  ```

  ```txt
                predict
  actual       고객서비스 관리업무 생산업무
    고객서비스         23        0        8
    관리업무            1       14        4
    생산업무            2        1       37
  ```
  
  #align(center)[ #table( columns: (auto, 1fr, 1fr, 1fr), align: center, stroke: 0.5pt + gray, [], [고객서비스 (P)], [관리업무 (P)], [생산업무 (P)], [고객서비스 (A)], [23], [0], [8], [관리업무 (A)], [1], [14], [4], [생산업무 (A)], [2], [1], [37] ) ]
]

\

6. 상기 데이터에 대해 의사결정나무 분류 분석을 수행하고 결과를 해석하시오.

#ans[
  ```R
  library(rpart)
  library(rpart.plot)
  
  dt_model <- rpart(직무 ~ ., data = job, method = "class")
  rpart.plot(dt_model) # 모델 시각화
  ```
  
  #align(center)[#image("images/rpart-plot-dtmodel.png", width: 70%)]
  
  ```R
  dt_pred <- predict(dt_model, job, type = "class")
  table(actual = job$직무, predict = dt_pred)
  ```

  ```txt
                predict
  actual       고객서비스 관리업무 생산업무
    고객서비스         26        1        4
    관리업무            2       15        2
    생산업무            5        5       30
  ```

  #align(center)[ #table( columns: (auto, 1fr, 1fr, 1fr), align: center, stroke: 0.5pt + gray, [], [고객서비스 (P)], [관리업무 (P)], [생산업무 (P)], [고객서비스 (A)], [26], [1], [4], [관리업무 (A)], [2], [15], [2], [생산업무 (A)], [5], [5], [30] ) ]
]

\

7. 상기 데이터에 대해 신경망 분류 분석을 수행하고 결과를 해석하시오.

#ans[
  ```R
  library(nnet)

  nn_model <- nnet(직무 ~ ., data = job, size = 5, maxit = 200)
  ```
  
  ```txt
  # weights:  38
  initial  value 93.997078 
  iter  10 value 54.572845
  iter  20 value 39.575600
  iter  30 value 36.631973
  iter  40 value 36.002543
  iter  50 value 34.546710
  iter  60 value 32.188704
  iter  70 value 28.474441
  iter  80 value 27.439885
  iter  90 value 27.044475
  iter 100 value 26.998810
  iter 110 value 26.924559
  iter 120 value 26.908108
  iter 130 value 26.901027
  iter 140 value 26.887557
  iter 150 value 26.868629
  iter 160 value 26.866413
  iter 170 value 26.865521
  iter 180 value 26.860892
  iter 190 value 26.860110
  iter 200 value 26.859354
  final  value 26.859354 
  stopped after 200 iterations
  ```

  ```R
  nn_pred <- predict(nn_model, job, type = "class")

  table(actual = job$직무, predict = nn_pred)
  ```

  ```txt
                predict
  actual       고객서비스 관리업무 생산업무
    고객서비스         25        0        6
    관리업무            0       15        4
    생산업무            1        0       39
  ```

  #align(center)[ #table( columns: (auto, 1fr, 1fr, 1fr), align: center, stroke: 0.5pt + gray, [], [고객서비스 (P)], [관리업무 (P)], [생산업무 (P)], [고객서비스 (A)], [25], [0], [6], [관리업무 (A)], [0], [15], [4], [생산업무 (A)], [1], [0], [39] ) ]
]

\

8. 상기 데이터에 대해 단순 베이즈 분류 분석을 수행하고 결과를 해석하시오.

#ans[
  3번 문제에서 수행했던 것과 같이 수행한다:

  ```R
  nb_model <- naiveBayes(직무 ~ ., data = job)

  nb_pred <- predict(nb_model, job)
  table(actual = job$직무, predict = nb_pred)
  
  print(nb_model)
  ```

  ```txt
                predict
  actual       고객서비스 관리업무 생산업무
    고객서비스         24        1        6
    관리업무            0       14        5
    생산업무            2        4       34
  ```
  
  #align(center)[ #table( columns: (auto, 1fr, 1fr, 1fr), align: center, stroke: 0.5pt + gray, [], [고객서비스 (P)], [관리업무 (P)], [생산업무 (P)], [고객서비스 (A)], [24], [1], [6], [관리업무 (A)], [0], [14], [5], [생산업무 (A)], [2], [4], [34] ) ]

  - 총 90개의 데이터 중 72개를 정확히 분류하여 약 80%의 정확도를 보인다.
  - 생산업무의 경우 타 직무에 비해 야외활동성 평균(19.05)이 높고 사교성(22.05)이 높은 특징을 잘 잡아내고 있다.
]

\

9. 상기 데이터에서 가장 높은 예측 적중률을 보인 기계학습 기법을 이용하여, 아와활동성 20점, 사고성 15점, 보수성 10점인 신입 사원의 직무를 부여해 보시오.

#ans[
  신경망 모델이 가장 높은 정확도를 보였다.

  #align(center)[
    #table(
      columns: (auto, 1fr, 1fr, 1fr),
      align: center,
      [], [고객서비스(P)], [관리업무(P)], [생산업무(P)],
      [고객서비스(A)], [25], [0], [6],
      [관리업무(A)], [0], [15], [4],
      [생산업무(A)], [1], [0], [39]
    )
  ]

  - 전체 정확도: $(25+15+39) / 90 approx 87.8%$

  이 모델을 사용하여 신입 사원(야외활동성 20, 사교성 15, 보수성 10)의 직무를 예측하면 아래와 같다:

  ```R
  new_emp <- data.frame(야외활동성 = 20, 사교성 = 15, 보수성 = 10)
  predict(nn_model, new_emp, type = "class")
  ```
  ```
  [1] "생산업무"
  ```
]
