#import "@preview/charged-ieee:0.1.3": ieee


#show: ieee.with(
  title: [#text(font: ("noto serif cjk kr", ))[임베디드 소프트웨어: 사인파 모델 학습 과제]],
  abstract: [
    #text(font: "noto serif cjk kr")[사인파 학습 데이터와 모델 파라미터가 모델 성능에 끼치는 영향을 분석하고 그 결과를 정리하기 위해 3가지의 변형을 실험하고 그 결과를 정리했습니다.]
  ],
  authors: (
    (
      name: "Park Jonghyeon",
      department: [#text(font: ("noto serif cjk kr", ))[컴퓨터정보통신공학과]],
      organization: [#text(font: ("noto serif cjk kr", ))[전남대학교 공과대학]],
      email: "jonghyeon@jnu.ac.kr"
    ),
  ),
  index-terms: (),
  figure-supplement: [Fig.],
)
#set text(font: ("noto serif cjk kr", ))

= 모델 정의

실험은 두 개의 모델과 두 개의 데이터를 이용하여 총 세 개 유형으로 진행하였습니다. 두 개의 모델로 "기본형 모델"과 "깊은 모델"을 정의하였습니다. 기본형 모델은 사인파 학습 예제에 널리 사용되는 유형의, Dense 레이어가 적당한 수준으로 쌓여있는 구조입니다. 자세한 구조는 표 1을 참조하십시오.

깊은 모델은 기본형 모델보다 더 많은 은닉층을 가지고 있지만 여전히 Dense 레이어만으로 구성됩니다. Dense 레이어는 점점 넓어지다가 다시 축소되는 과정을 거칩니다. 자세한 구조는 표 2를 참조하십시오.

#figure(
  caption: [유형 a와 b에서 사용하는 기본형 모델의 구조],
  table(
    columns: (6em, auto, auto),
    align: (left, center, right),
    inset: (x: 8pt, y: 4pt),
    stroke: (x, y) => if y <= 1 { (top: 0.5pt) },
    fill: (x, y) => if y > 0 and calc.rem(y, 2) == 0  { rgb("#efefef") },

    table.header[Type][Activation Fn][Output Shape],
    [Dense], [ReLU], [32],
    [Dense], [ReLU], [64],
    [Dense], [ReLU], [16],
    [Dense], [ReLU], [1],
  )
) <tab:model-basic>

#figure(
  caption: [유형 c에서 사용하는 깊은 모델의 구조],
  table(
    columns: (6em, auto, auto),
    align: (left, center, right),
    inset: (x: 8pt, y: 4pt),
    stroke: (x, y) => if y <= 1 { (top: 0.5pt) },
    fill: (x, y) => if y > 0 and calc.rem(y, 2) == 0  { rgb("#efefef") },

    table.header[Type][Activation Fn][Output Shape],
    [Dense], [ReLU], [32],
    [Dense], [ReLU], [64],
    [Dense], [ReLU], [64],
    [Dense], [ReLU], [128],
    [Dense], [ReLU], [64],
    [Dense], [ReLU], [64],
    [Dense], [ReLU], [16],
    [Dense], [ReLU], [1],
  )
) <tab:model-deep>

= 학습

학습에 사용하는 데이터는 모두 $[0, 2pi]$ 범위에 분포됩니다. 하지만 실험군은 가운데에 데이터가 몰려 범위의 가장자리가 학습이 잘 되지 않도록 하였습니다. 실험군의 $x$ 좌표 분포는 $m=0, sigma=1$의 정규 분포를 생성한 후 $[0, 2pi]$ 구간으로 변환하였습니다. 따라서 실험군의 분포는 생성된 값의 이상치 분포에 따라 결정됩니다. 


#figure(
  caption: [실험군: 중앙에 몰린 데이터],
  placement: top,
  image("assets/dist-std-origin.png")
)

#figure(
  caption: [실험군: 중앙에 몰린 데이터(학습용 노이즈 추가)],
  placement: top,
  image("assets/dist-std.png")
)

이와 같이 구간 데이터를 엄밀하게 정의하지 않은 것은 이 실험군의 목적이 단순히 범위 가장자리의 데이터가 빈약할 때의 학습 결과를 확인하는 것이기 때문입니다. 따라서 설정한 시드값에 따라 구간 데이터가 변화할 수 있으며, 정의역이 비결정적으로 생성되는 것처럼 보일 수 있습니다.

이와 달리 대조군은 $[0, 2pi]$ 구간에 고르게 퍼져있도록 하였습니다. 최종적으로, 생성한 실험군과 대조군은 $[0, .15]$ 수준의 노이즈를 덧셈하여 학습에 사용하였습니다.

#figure(
  caption: [대조군: 고르게 분포된 데이터],
  placement: top,
  image("assets/dist-normal.png")
)

= 실험 결과

== 모델의 깊이에 따른 정확도 변화

깊은 모델은 기본형 모델에 비해 학습 과정이 더 불안정했습니다. 학습 중 validation loss가 지속적으로 큰 폭으로 변동하며 튀는 현상이 관찰되었습니다. 이러한 현상으로 인해 학습이 진행되는 동안 모델이 중간중간 과적합된 것이 아닌지 우려되는 상황이 발생하였습니다.

#figure(
  caption: [기본형 모델의 학습/검증 로스],
  placement: top,
  image("assets/loss-normal.png")
)
#figure(
  caption: [깊은 모델의 학습/검증 로스],
  placement: top,
  image("assets/loss-deep.png")
)
두 모델이 예측한 사인파 그래프에서는 큰 차이를 확인할 수 없었습니다. 따라서 깊은 모델의 도입은 실질적으로 성능 개선에 기여하지 않았으며, 오히려 컴퓨팅 자원의 낭비와 과적합에 대한 우려만 남기는 결과를 가져왔습니다.

#figure(
  caption: [기본형 모델의 사인파],
  placement: top,
  image("assets/pred-normal.png")
)
#figure(
  caption: [깊은 모델의 사인파],
  placement: top,
  image("assets/pred-deep.png")
)

이는 설계한 깊은 모델이 사인파 추정 문제를 해결하기에는 지나치게 복잡한 구조를 가지고 있었기 때문인 것으로 보입니다. 사인파와 같이 단순한 패턴을 추정하는 데에는 기본형 모델만으로도 충분히 대응 가능한 것으로 보입니다.

\
== 데이터의 분포에 따른 정확도 변화

가운데가 조밀한 실험군은 데이터 분포가 범위의 가장자리에 거의 존재하지 않아 끝부분 학습이 사실상 불가능하게 되었습니다. 그 결과로 수행한 테스트에서, 모델은 사인파보다는 시그모이드 함수를 $y$축 대칭한 형태의 개형에 가깝게 그래프를 그렸습니다.

#figure(
  caption: [실험군으로 학습시킨 모델의 사인파],
  placement: top,
  image("assets/pred-std-dist.png")
)

추가 연구로서 이를 보완하기 위해 데이터 개수를 수 배 늘려서 생성하기도 하였으나, 표준편차를 변경하지 않았기 때문에 단순히 데이터 수를 증가시키는 것으로는 학습 데이터의 분포에 유의미한 변화를 가져오지 못했습니다.

#figure(
  caption: [입력 개수를 10배 증가시킨 실험군으로 학습시킨 모델의 사인파],
  placement: top,
  image("assets/pred-std-dist-oversized.png")
)

그럼에도 불구하고 그래프 자체는 훨씬 개선되어 사인파 곡선을 그려낼 수 있었습니다. 이것은 범위 가장자리의 데이터가 상대적으로 빈약함에도 불구하고, 원본 실험군과 달리 가장자리에서 사인파를 묘사할 수 있는 데이터가 포함되었기 때문으로 추정하고 있습니다.

= 부록
== 각 유형 별 Loss 값

#figure(
  table(
    columns: (auto, auto, auto, auto),
    align: center + horizon,
    inset: (x: 8pt, y: 4pt),
    stroke: (x, y) => if y <= 1 { (top: 0.5pt) },
    fill: (x, y) => if y > 0 and calc.rem(y, 2) == 0  { rgb("#efefef") },

    table.header[Type][$L$ Epoch.30][$L$ Epoch.50][$L$ Epoch.100],
    [기본형 +\ 대조군], [0.0575], [0.0367], [0.0302],
    [기본형 +\ 실험군], [0.0398], [0.0358], [0.0301],
    [기본형 +\ 실험군(10배)], [0.0259], [0.0251], [0.0246],
    [깊은 모델], [0.0427], [0.0386], [0.0333],
  )
) 