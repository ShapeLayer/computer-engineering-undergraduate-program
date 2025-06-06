#set page(margin: (
  top: 15mm,
  bottom: 15mm,
  left: 20mm,
  right: 20mm,
),
  numbering: "1",
  header: [
    #text(size: .7em, fill: gray)[#columns(2)[
      #align(left)[IoT컴퓨팅 과제]
      #colbreak()
      #align(right)[박종현]
    ]
  ]]
)
#set text(font: ("Noto Serif CJK KR"))
#show heading.where(
  level: 1
): it => block(width: 100%)[
  #set align(center)
  #text(weight: "regular", size: 1.3em)[
    #it.body
  ]
]
#show heading.where(
  level: 2
): it => block(width: 100%)[
  #rect(fill: none, stroke: none, height: .1em)
  #text(weight: "regular", size: 1.3em)[
    #it.body
  ]
]
#show heading.where(
  level: 3
): it => block(width: 100%)[
  #text(weight: "regular", size: 1.2em)[#it.body ---------]
]

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

#let rc(content) = text(fill: rgb("#e74c3c"))[#content]
#let cb(content) = block(fill: rgb("#f0f0f0"), inset: 1em, width: 100%)[#content]

#let ul(s) = [#underline[#link(s)]]

#set page(columns: 2)

#place(
  top,
  float: true,
  scope: "parent",
  clearance: 30pt,
)[
  = 엣지 디바이스 및 저성능 환경에서 기계학습 컴퓨팅
  
  #align(center)[#text(size: 1.2em)[
    IoT컴퓨팅과 인공지능 기술을 중심으로\
    IoT컴퓨팅 보고서 과제
  ]]
  
  #align(center)[
  박종현, 
  공과대학 컴퓨터정보통신공학과\
  `jonghyeon@jnu.ac.kr`
  ]
]

== 도입
=== 인공지능과 비용
\
오늘날 인공지능 연구에 사용되는 컴퓨팅 자원은 매우 비싼 것들이다.

AI 연구용으로 데이터센터에서 널리 쓰이는 엔비디아의 A100 GPU는 수천을 호가하고, 일반 소비자용으로 발매된 게이밍 GPU 역시 폭등하는 그래픽 수요에 매우 높은 소비자가가 설정되었다. 엔비디아의 플래그십 그래픽 처리기인 GeForce RTX 5090은 1999달러가 시작가이기도 하다. @nvidiartx5090 

그조차도 폭발하는 AI 처리기 수요에 일반 소비자가 아닌 각종 연구기관으로 공급되어 더 비싼 가격을 형성하고 있다. 최근에는 인공지능 라이브러리의 지원이 덜한 AMD의 그래픽 장치에 일반 소비자의 수요가 증가한다는 의견도 대두될 정도이다.

오늘날 범용 목적으로 사용하는 거대 언어 모델(LLM) 중 가장 최적화된 모델인 DeepSeek R1, DeepSeek V3 역시 천만원대의 초고사양 맥 스튜디오를 사용하는 것이 가장 저렴한 비용으로 동작시키는 방법으로 알려져 있다.@hardwick2025macstudio

\

=== 인공지능은 세탁기보다 강하다
\
하지만 비싸다는 것은 단순히 연구에 투입되는 장비, 다시 말해 하드웨어 컴퓨팅 장비의 구입 단가에 대해서만 이야기하는 것이 아니다. 앞서 언급한 RTX 5090은 일반 소비자용 그래픽카드임에도 575W의 전력을 소모하고, 시스템 전체에 1000W의 전력을 요구한다.  

세탁기가 일반적으로 500W, 전자레인지가 700W 혹은 1000W의 전력을 소비@powerconsumption 하는 것과 비교하면 컴퓨팅 장치의 소모 전력이 매우 큰 것으로 파악할 수 있다.

또한 컴퓨팅 장치를 사용하는 시간은 위의 가전을 사용하는 시간에 비해 월등히 많은 시간을 소모한다. 특히 인공지능 학습의 경우, 컴퓨팅 자원을 풀로드 상태로 휴식 없이 연속적으로 수십 수백시간을 동작시키므로 실제로는 매우 많은 전력을 투입해야 한다.

\

실제로 데이터센터의 수백 메가와트, 기가와트 급 전력 소모량이 데이터센터 건설의 증가에 따라 점차 문제가 대두되고 있다.@cnbc2024datacenter 버지니아 주에서는 데이터센터가 기피시설화되는 듯한 모습이 보이거나@ma2025datacenter, 많은 데이터센터들이 신규 데이터센터 건설에 자체적인 전력 공급망 구축 계획을 포함하는 것을 고려할 정도이다.

일부 주장에 따르면 이 추세대로라면 2035년에는 일본 전체의 전력 소모량을 능가할 것으로 추정하기도 하고, @carboncredits2025datacenter 최근 도널드 트럼프 행정부의 사우디 아라비아로의 AI 데이터센터 투자 발표@whitehouse2025saudi 도 전력 수급 관련한 고려 사항이 있을 것으로 추정하는 의견도 제시되고 있다.

\
== 비용 최적화와 엣지 컴퓨팅
=== 빅테크의 비용 최적화 연구
\
이와 같이 AI가 요구하는 비용이 보여주듯, 대부분의 인공지능은 매우 높은 비용을 요구한다. 하지만 동시에 계속해서 중앙에 집중된 초고사양의 서버에 의존하지 않는 방법도 연구되고 있다.

2019년 Pete Warden과 Daniel Situnayake에 따르면@warden2020tinyml, 유명 기계학습 라이브러리 TensorFlow를 개발한 구글에서는 매우 오래전부터 인공지능 모델을 최적화하고 저성능 환경에서 동작시키는 것에 대한 연구를 수행해왔다.

구글의 사례 뿐 아니라 이제 온디바이스 환경에서 인공지능 모델을 동작시키려는 시도는 꽤 흔해졌다. Apple Intelligence와 갤럭시 AI는 제한적이지만 휴대폰 기기 위에서 인공지능 모델을 사용한다.

애플의 경우 맥의 칩을 ARM 아키텍처 기반의 애플 실리콘으로 전환하면서 최초 버전인 M1 칩부터 이미 인공지능 전용 하드웨어 가속기(NPU)를 칩 다이에 통합@apple2020m1 하고 있고, 엔비디아는 임베디드 인공지능 환경 개발 보드 Jetson@nvidia2025jetson 을 출시하기도 했다.

\
=== 충분히 연구된 모델은 장난감으로도 활용된다
\

#figure(
  caption: [게임 내장 명령어로 AI 모델 구현@marple2024youtube]
)[#image("assets/marple2024youtube.png")]

수 년 전 구글은 QuickDraw라는 게임을 출시해 이목을 끌었다. 사용자들의 낙서를 CNN 모델이 맞추는 웹 게임이고, 모델은 사용자들의 낙서를 재학습하여 성능을 개선하였다.@quickdraw

QuickDraw는 공개된 데이터가 매우 많고 오랫동안 연구되어, 상용 게임의 내장 명령어만으로 QuickDraw 모델을 재구현@ensha2024mcdraw 되기도 하였다.

이 구현체는 마인크래프트를 클라이언트 수정 없이 월드맵 데이터와 기본 내장 명령어 데이터팩을 이용하였음에도 매우 뛰어난 성능을 보여주었다.@marple2024youtube

\

이 사례는 충분히 오랫동안 잘 연구된 인공지능 모델은 저성능의 엣지 디바이스 뿐 아니라, 사칙연산이 가능한 그 어떤 계산 기계 환경에서든 동작이 가능함을 직접적으로 보여주는 사례로 볼 수 있을 것이다.

== 마무리

오늘날 인공지능 기술은 뛰어난 성능과 혁신적인 가능성을 가지고 있지만, 막대한 전력 소비와 높은 하드웨어 비용이라는 과제를 안고 있다. 고성능 GPU와 대규모 데이터센터는 에너지 수요를 가중시키고 전력 인프라와 환경에 점점 더 많은 부담을 주고 있다.

그러나 AI 기술을 전적으로 중앙 집중적인 고성능 인프라에 의존할 필요는 없다. 휴대폰, 임베디드 보드, 저전력 마이크로컨트롤러 등의 엣지 디바이스 환경에서 동작 가능한 경량화 모델과 최적화 기법은 실용 수준에서도 사용되고 있다.

심지어는 마인크래프트와 같은 게임 환경에서도 구현이 가능할 만큼 연산 처리를 최적화할 수 있었다. 이미 공개되어 오랜 연구를 걸쳐 경량화된 AI 모델은 연산 자원이 극히 제한적인 환경에서도 의미 있는 성능을 발휘하였다.

이 사례가 시사하듯, 앞으로 더 다양한 모델이 IoT컴퓨팅 환경에서 동작할 수 있을 것이다. 다양한 최적화 기법이 지속적으로 발전하고 있으며, 하드웨어 제조사 역시 저전력 엣지 AI 칩셋을 적극적으로 선보이고 있다. 이러한 노력이 결합된다면, 가까운 미래에는 스마트 팩토리, 자율 주행, 원격 의료 등 다양한 분야에서 엣지 디바이스 중심의 AI 솔루션이 보편화될 것으로 기대된다.


#pagebreak()
#set page(columns: 1)
#bibliography("refs.bib", title: [참고 문헌])
