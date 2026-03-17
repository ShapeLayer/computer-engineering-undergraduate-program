/**
 * A local machine that compiles this file would need to
 * install font files where defined at below as a variable
 * `sans`, `serif`, and `mono`.
 * 
 * Font files are placed at ./assets/fonts/.
 * If there is any need to apply font into compiler or 
 * language server particularly, refer that path.
 * 
 * example: 
 * .vscode/settings.json
 * ```json
 * {
 *   "tinymist.fontPaths": [
 *     "./assets/fonts/"
 *   ]
 * }

 * ```
 */

#set page(margin: (
  top: 15mm,
  bottom: 15mm,
  left: 15mm,
  right: 15mm,
),
  numbering: "1",
  header: [
    #text(size: .7em, fill: color.rgb("#505050"))[#columns(2)[
      #align(left)[화상정보처리 레포트 과제]
      #colbreak()
      #align(right)[Park Jonghyeon]
    ]
  ]]
)

#let sans = ("Noto Sans KR", "Noto Sans CJK KR", "Noto Sans JP", "Noto Sans CJK JP")
#let serif = ("Noto Serif KR", "Noto Serif CJK KR", "Noto Serif JP", "Noto Serif CJK JP")
#let mono = ("Noto Sans Mono", "D2Coding", "MonoplexKR")

// #show raw: it => text(font: mono)[#it]

#set text(font: serif, size: 8pt)

#set heading(numbering: "1.")
#show heading.where(level: 1): set text(size: 1.2em, weight: "semibold")
#show heading.where(level: 2): set text(size: 1.2em, weight: "semibold")
#show heading.where(level: 3): set text(size: 1.2em, weight: "regular")

#show figure.where(kind: image): set figure(supplement: [Fig.])

#show raw.where(block: false): it => box(fill: rgb("f5f5f5"), outset: (y: 5pt), inset: (x: 5pt), text(fill: red, it))
#show raw.where(block: true): it => block(fill: rgb("f5f5f5"), outset: (y: 10pt), inset: (x: 10pt), width: 100%, it)

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
    #block(width: 100%, align(center, text(size: 2em, [#title])))
    
    #align(center)[#text(size: 1.2em)[
      #subtitle
    ]]
    
    #align(center)[
    Jonghyeon Park, 
    이공학부 특별청강학생\
    25931028\@edu.cc.saga-u.ac.jp, jonghyeon\@jnu.ac.kr
    ]
  ]
]

#let url(s) = { underline[#link(s)] }

#let origin-quote(
  _stroke: "#38546e",
  _fill: "#eff0f355",
  content
) = {
  block(
    width: 100%,
    stroke: (left: 1.7pt + rgb(_stroke)),
    fill: (rgb(_fill)),
    inset: (x: .5em, y: 1.2em),
    text(size: .9em, quote(block: true, content))
  )
}

/**
 * Content Start
 */

#hero(
  [〈화상정보처리〉 레포트 과제],
  []
)

#outline(title: [개요])

\

= 과제 \#1: 이미지의 파워/진폭 스펙트럼 <sec-1>

== 스펙트럼 산출

#origin-quote[
  NIH ImageJ와 플러그인 FFTJ를 사용하여, 다음과 같은 다양한 이미지의 2차원 FFT와 DC 성분을 중심으로 이동시키기 위한 시프트(Shift) 처리를 수행하고, 파워 스펙트럼 또는 진폭 스펙트럼(2차원 이미지 형태)을 구하십시오. (Teams에 이미지 파일이 준비되어 있습니다.)

  - 줄무늬 방향은 동일하고 간격이 다른 이미지
  - 줄무늬 방향이 다른 이미지
  - 평균값이 다른 이미지
]
/**
 * 원문:
 * (1)NIH ImageJとプラグインFFTJを用いて、次のような様々な画像の2次元FFTと、DC成分を中心に移動するためのシフト処理を行い、パワースペクトルまたは振幅スペクトル（2次元画像になる）を求めなさい。（Teamsに画像ファイルは準備してあります）
 */

=== 줄무늬 방향은 동일하고 간격이 다른 이미지 <sec-diff-gap>

#grid(
  columns: 3,
  inset: .3em,
  align: center,
  
  grid.cell(align: horizon, rowspan:2, [#figure(image("assets/sec-1/stripe_interval/Yokoshima1.png", width: 100%), caption: [넓은 간격 가로 줄무늬 이미지])<fig-yokoshima1>]),
  [#figure(image("assets/sec-1/stripe_interval/yokoshima1 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima1 의 진폭 스펙트럼])<fig-yokoshima1-f>],
  [#figure(image("assets/sec-1/stripe_interval/(centercrop) yokoshima1 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima1 의 진폭 스펙트럼 (중심 확대)])<fig-yokoshima1-fc>],
  [#figure(image("assets/sec-1/stripe_interval/yokoshima1 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima1 의 파워 스펙트럼])<fig-yokoshima1-p>],
  [#figure(image("assets/sec-1/stripe_interval/(centercrop) yokoshima1 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima1 의 파워 스펙트럼 (중심 확대)])<fig-yokoshima1-pc>],
)

#grid(
  columns: 3,
  inset: .3em,
  align: center,
  grid.cell(align: horizon, rowspan:2, [#figure(image("assets/sec-1/stripe_interval/Yokoshima2.png", width: 100%), caption: [중간 간격 가로 줄무늬 이미지])<fig-yokoshima2>]),
  [#figure(image("assets/sec-1/stripe_interval/yokoshima2 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima2 의 진폭 스펙트럼])<fig-yokoshima2-f>],
  [#figure(image("assets/sec-1/stripe_interval/(centercrop) yokoshima2 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima2 의 진폭 스펙트럼 (중심 확대)])<fig-yokoshima2-fc>],
  [#figure(image("assets/sec-1/stripe_interval/yokoshima2 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima2 의 파워 스펙트럼])<fig-yokoshima2-p>],
  [#figure(image("assets/sec-1/stripe_interval/(centercrop) yokoshima2 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima2 의 파워 스펙트럼 (중심 확대)])<fig-yokoshima2-pc>],
)

#grid(
  columns: 3,
  inset: .3em,
  align: center,
  grid.cell(align: horizon, rowspan:2, [#figure(image("assets/sec-1/stripe_interval/Yokoshima3.png", width: 100%), caption: [좁은 간격 가로 줄무늬 이미지])<fig-yokoshima3>]),
  [#figure(image("assets/sec-1/stripe_interval/yokoshima3 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima3 의 진폭 스펙트럼])<fig-yokoshima3-f>],
  [#figure(image("assets/sec-1/stripe_interval/(centercrop) yokoshima3 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima3 의 진폭 스펙트럼 (중심 확대)])<fig-yokoshima3-fc>],
  [#figure(image("assets/sec-1/stripe_interval/yokoshima3 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima3 의 파워 스펙트럼])<fig-yokoshima3-p>],
  [#figure(image("assets/sec-1/stripe_interval/(centercrop) yokoshima3 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima3 의 파워 스펙트럼 (중심 확대)])<fig-yokoshima3-pc>],
)

=== 줄무늬 방향이 다른 이미지 <sec-diff-dir>

#grid(
  columns: 3,
  inset: .3em,
  align: center,
  grid.cell(align: horizon, rowspan:2, [#figure(image("assets/sec-1/stripe_direction/Tateshima2.png", width: 100%), caption: [세로 줄무늬 이미지])<fig-tateshima2>]),
  [#figure(image("assets/sec-1/stripe_direction/tateshima2 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-tateshima2 의 진폭 스펙트럼])<fig-tateshima2-f>],
  [#figure(image("assets/sec-1/stripe_direction/(centercrop) tateshima2 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-tateshima2 의 진폭 스펙트럼 (중심 확대)])<fig-tateshima2-fc>],
  [#figure(image("assets/sec-1/stripe_direction/tateshima2 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-tateshima2 의 파워 스펙트럼])<fig-tateshima2-p>],
  [#figure(image("assets/sec-1/stripe_direction/(centercrop) tateshima2 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-tateshima2 의 파워 스펙트럼 (중심 확대)])<fig-tateshima2-pc>],
)

#grid(
  columns: 3,
  inset: .3em,
  align: center,
  grid.cell(align: horizon, rowspan:2, [#figure(image("assets/sec-1/stripe_interval/Yokoshima2.png", width: 100%), caption: [가로 줄무늬 이미지])<fig-yokoshima2a>]),
  [#figure(image("assets/sec-1/stripe_interval/yokoshima2 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima2a 의 진폭 스펙트럼])<fig-yokoshima2a-f>],
  [#figure(image("assets/sec-1/stripe_interval/(centercrop) yokoshima2 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima2a 의 진폭 스펙트럼 (중심 확대)])<fig-yokoshima2a-fc>],
  [#figure(image("assets/sec-1/stripe_interval/yokoshima2 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima2a 의 파워 스펙트럼])<fig-yokoshima2a-p>],
  [#figure(image("assets/sec-1/stripe_interval/(centercrop) yokoshima2 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima2a 의 파워 스펙트럼 (중심 확대)])<fig-yokoshima2a-pc>],
)

#grid(
  columns: 3,
  inset: .3em,
  align: center,
  grid.cell(align: horizon, rowspan:2, [#figure(image("assets/sec-1/stripe_direction/Nanameshima2A.png", width: 100%), caption: [@fig-tateshima2 의 반시계 방향 $45 degree$ 회전])<fig-naneshima2a>]),
  [#figure(image("assets/sec-1/stripe_direction/nanameshima2a Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-naneshima2a 의 진폭 스펙트럼])<fig-naneshima2a-f>],
  [#figure(image("assets/sec-1/stripe_direction/(centercrop) nanameshima2a Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-naneshima2a 의 진폭 스펙트럼 (중심 확대)])<fig-naneshima2a-fc>],
  [#figure(image("assets/sec-1/stripe_direction/nanameshima2a Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-naneshima2a 의 파워 스펙트럼])<fig-naneshima2a-p>],
  [#figure(image("assets/sec-1/stripe_direction/(centercrop) nanameshima2a Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-naneshima2a 의 파워 스펙트럼 (중심 확대)])<fig-naneshima2a-pc>],
)

#grid(
  columns: 3,
  inset: .3em,
  align: center,
  grid.cell(align: horizon, rowspan:2, [#figure(image("assets/sec-1/stripe_direction/Nanameshima2B.png", width: 100%), caption: [@fig-tateshima2 의 시계 방향 $45 degree$ 회전])<fig-naneshima2b>]),
  [#figure(image("assets/sec-1/stripe_direction/nanameshima2b Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-naneshima2b 의 진폭 스펙트럼])<fig-naneshima2b-f>],
  [#figure(image("assets/sec-1/stripe_direction/(centercrop) nanameshima2b Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-naneshima2b 의 진폭 스펙트럼 (중심 확대)])<fig-naneshima2b-fc>],
  [#figure(image("assets/sec-1/stripe_direction/nanameshima2b Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-naneshima2b 의 파워 스펙트럼])<fig-naneshima2b-p>],
  [#figure(image("assets/sec-1/stripe_direction/(centercrop) nanameshima2b Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-naneshima2b 의 파워 스펙트럼 (중심 확대)])<fig-naneshima2b-pc>],
)

=== 평균값이 다른 이미지 <sec-diff-avg>

#grid(
  columns: 3,
  inset: .3em,
  align: center,
  grid.cell(align: horizon, rowspan:2, [#figure(image("assets/sec-1/different_average/Average25percent.png", width: 100%), caption: [흑백 비율 3:1인 이미지])<fig-avg25>]),
  [#figure(image("assets/sec-1/different_average/avg25 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg25 의 진폭 스펙트럼])<fig-avg25-f>],
  [#figure(image("assets/sec-1/different_average/(centercrop) avg25 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg25 의 진폭 스펙트럼 (중심 확대)])<fig-avg25-fc>],
  [#figure(image("assets/sec-1/different_average/avg25 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg25 의 파워 스펙트럼])<fig-avg25-p>],
  [#figure(image("assets/sec-1/different_average/(centercrop) avg25 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg25 의 파워 스펙트럼 (중심 확대)])<fig-avg25-pc>],
)


#grid(
  columns: 3,
  inset: .3em,
  align: center,
  grid.cell(align: horizon, rowspan:2, [#figure(image("assets/sec-1/different_average/Average50percent.png", width: 100%), caption: [흑백 비율 1:1인 이미지])<fig-avg50>]),
  [#figure(image("assets/sec-1/different_average/avg50 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg50 의 진폭 스펙트럼])<fig-avg50-f>],
  [#figure(image("assets/sec-1/different_average/(centercrop) avg50 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg50 의 진폭 스펙트럼 (중심 확대)])<fig-avg50-fc>],
  [#figure(image("assets/sec-1/different_average/avg50 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg50 의 파워 스펙트럼])<fig-avg50-p>],
  [#figure(image("assets/sec-1/different_average/(centercrop) avg50 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg50 의 파워 스펙트럼 (중심 확대)])<fig-avg50-pc>],
)


#grid(
  columns: 3,
  inset: .3em,
  align: center,
  grid.cell(align: horizon, rowspan:2, [#figure(image("assets/sec-1/different_average/Average75percent.png", width: 100%), caption: [흑백 비율 1:3인 이미지])<fig-avg75>]),
  [#figure(image("assets/sec-1/different_average/avg75 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg75 의 진폭 스펙트럼])<fig-avg75-f>],
  [#figure(image("assets/sec-1/different_average/(centercrop) avg75 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg75 의 진폭 스펙트럼 (중심 확대)])<fig-avg75-fc>],
  [#figure(image("assets/sec-1/different_average/avg75 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg75 의 파워 스펙트럼])<fig-avg75-p>],
  [#figure(image("assets/sec-1/different_average/(centercrop) avg75 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg75 의 파워 스펙트럼 (중심 확대)])<fig-avg75-pc>],
)

== 스펙트럼의 해석

#origin-quote[진폭 스펙트럼 또는 파워 스펙트럼 이미지의 각 부분이 무엇을 표현하는지 (1)의 처리 결과를 바탕으로 설명하십시오.]
/**
 * 원문:
 * (2)振幅スペクトルまたはパワースペクトル画像の各部分が何を表現しているのかを(1)の処理結果に基づいて説明しなさい。 
 * 
 * ① スペクトル中心（原点） 
 * ② 原点に近いエリア 
 * ③ 原点から遠いエリア 
 * ④ 原点からの方向
 */

1. 스펙트럼 중심 (원점): DC 성분 (Direct Current component)

  #figure(
    $
    F(0,0) = sum_(x,y) f(x,y)
    $,
    caption: [DC 성분의 정의]
  )

  2차원 이산 푸리에 변환의 정의에 따라, 스펙트럼의 중심은 주파수가 $(0, 0)$인 지점으로, @sec-diff-avg〈평균값이 다른 이미지 처리〉와 같이 진폭 스펙트럼의 중심값은 화상의 평균 밝기에 해당함을 확인할 수 있다.

  #figure($
    I_"avg25" &= 255 dot 0.25 = 63.75 \
    I_"avg50" &= 255 dot 0.50 = 127.5 \
    I_"avg75" &= 255 dot 0.75 = 191.25
  $,
  caption: [@fig-avg25, @fig-avg50, @fig-avg75 의 중앙 픽셀 밝기 $I_"avg25"$, $I_"avg50"$, $I_"avg75"$ 기댓값])<expr-avg>

  따라서 밝기0:밝기255의 비율이 3:1인 이미지 @fig-avg25, 2:2인 이미지 @fig-avg50, 1:3인 이미지 @fig-avg75 의 중앙 픽셀 밝기 $I_"avg25"$, $I_"avg50"$, $I_"avg75"$ 각각에 대해서, @expr-avg 과 같이 계산하여 $I_"avg25" = 63.75$, $I_"avg50" = 127.5$, $I_"avg75" = 191.25$를 기대할 수 있다.

  #grid(
    [#figure(image("assets/sec-1/different_average/center-fft-25p.png", width: 100%),
      caption: [밝기0:밝기255의 비율이 3:1인 이미지 @fig-avg25 의 FFT 처리분의 가운데 픽셀의 밝기]
    )<fig-center-fft-25p>],
    [#figure(image("assets/sec-1/different_average/center-fft-50p.png", width: 100%),
      caption: [밝기0:밝기255의 비율이 2:2인 이미지 @fig-avg50 의 FFT 처리분의 가운데 픽셀의 밝기]
    )<fig-center-fft-50p>],
    [#figure(image("assets/sec-1/different_average/center-fft-75p.png", width: 100%),
      caption: [밝기0:밝기255의 비율이 1:3인 이미지 @fig-avg75 의 FFT 처리분의 가운데 픽셀의 밝기]
    )<fig-center-fft-75p>],
  )


  FFT 처리를 거친 @fig-avg25 @fig-avg50 @fig-avg75 의 중앙 픽셀을 ImageJ를 사용해 실제로 측정한 결과, @fig-center-fft-25p, @fig-center-fft-50p, @fig-center-fft-75p 와 같이 $I_"avg25"$, $I_"avg50"$, $I_"avg75"$ 의 기댓값 계산 @expr-avg 와 동일함을 알 수 있었다.
  
2. 원점에 가까운 영역: 저주파 성분 (Low Frequency components)

  이미지에서 밝기 변화가 천천히 일어나는 부분을 표현한다. 이미지의 배경, 거대한 형태, 부드러운 명암 변화 등이 이 영역에서 나타난다.
  
  @sec-diff-gap〈줄무늬 방향은 동일하고 간격이 른 이미지〉의 @fig-yokoshima1 '넓은 간격 가로 줄무늬 이미지'는 공간 영역에서 변화가 완만하므로, 스펙트럼 상에서 중심(원점)에 상대적으로 가까운 위치에 밝은 점(피크)이 나타난다.

3. 원점에서 먼 영역: 고주파 성분 (High Frequency components)

  이미지에서 밝기가 급격하게 변하는 부분을 표현한다. 사물의 윤곽선(Edge), 세밀한 질감(Texture), 노이즈 등이 이 영역에서 나타난다.
  
  @sec-diff-gap 〈줄무늬 방향은 동일하고 간격이 다른 이미지〉 항목의 넓은 간격 가로 줄무늬 이미지(@fig-yokoshima1), 중간 간격 가로 줄무늬 이미지(@fig-yokoshima2), 좁은 간격 가로 줄무늬 이미지(@fig-yokoshima3)를 비교하면, 줄무늬의 간격이 좁아질수록 스펙트럼 상에서 원점으로부터 더 멀리 떨어진 영역에 피크가 형성되는 것을 확인할 수 있다.

  다시 말해 공간 주파수가 높아질수록, DC 성분으로부터 더 멀리 떨어진 영역에 피크가 형성되었다.

  \

  한편, 좁은 간격의 가로 줄무늬 이미지(@fig-yokoshima3)는 밝기 변화가 빈번하여 이론적으로 고주파 영역에 피크가 형성되어야 함에도 불구하고, @fig-yokoshima3-f 등의 시각화 결과에서는 DC 성분의 과도한 강도로 인해 피크가 명확히 드러나지 않았다.

  #figure(grid(
      columns: (1fr, 1fr),
      gutter: .5em,
      align(right, image("assets/sec-1/stripe_interval/yokoshima3 FREQUENCY_SPECTRUM_LOG With Origin AT_CENTER (DOUBLE) origin.png", width: 70%)),
      align(left, image("assets/sec-1/stripe_interval/(crop) FREQUENCY_SPECTRUM_LOG With Origin AT_CENTER (DOUBLE) log.png", width: 70%)),
    ),
    caption: [
      수정된 계산식 @fftj-amplified 에 의해 확인 가능한 @fig-yokoshima3 의 주파수 스펙트럼(좌) 및 중심 확대(우)
    ]
  ) <fig-yokoshima3-f-amplified>

  이후 @amplify-high-freq 에서 서술할 방법에 의해 피크를 드러낸 결과, @fig-yokoshima3-f-amplified 와 같은 형태를 확인할 수 있었다.
  
  @fig-yokoshima3 역시 지금까지의 경향성과 비슷하게 주파수 스펙트럼이 다른 두 이미지 @fig-yokoshima1 @fig-yokoshima2 보다 중심으로부터 더욱 멀리 떨어져있고, 피크 간의 간격 또한 성기게 배치되는 일관된 양상을 확인할 수 있었다.
  
4. 원점으로부터의 방향: 공간 영역 내 패턴의 방향성 (Orientation)

  스펙트럼 이미지에서 원점으로부터 특정 방향으로 뻗어 나가는 성분은, 그 방향과 직교(수직)하는 방향으로 놓인 공간 영역의 패턴을 의미한다.
  
  @sec-diff-dir 〈줄무늬 방향이 다른 이미지〉의 @fig-yokoshima2a '가로 줄무늬 이미지'는 수직 방향으로 밝기 변화가 일어나므로, 시각화된 스펙트럼 @fig-yokoshima2a-f @fig-yokoshima2a-fc @fig-yokoshima2a-p @fig-yokoshima2a-pc 에서는 수직선 상에 피크가 형성되었다.

  공간 영역에서의 회전은 푸리에 영역에서도 동일한 회전으로 나타난다. @fig-tateshima2 '세로 줄무늬 이미지'의 스펙트럼(@fig-tateshima2-f 등)은 주파수 성분이 수평축에 분포하는 반면, 이를 $45 degree$ 회전시킨 @fig-naneshima2a 와 @fig-naneshima2b 의 스펙트럼(@fig-naneshima2a-f 등)은 원점을 중심으로 피크의 위치가 동일하게 $45 degree$ 회전하여 나타난다.

=== 주파수 스펙트럼의 왜곡을 이용한 가려진 주파수 스펙트럼 확인 <amplify-high-freq>

@fig-yokoshima3-f 등과 같이 극도로 조밀한 줄무늬 이미지에서 주파수 스펙트럼이 제대로 표시되지 않는 상황에 대해서는 추가적인 조사를 수행하였다.

조사를 통해, 일반적으로 고밀도 줄무늬의 주파수 성분을 해석할 때는 디지털 샘플링의 한계인 나이퀴스트 주파수(Nyquist Frequency)를 고려해야 함을 알 수 있었다. @gatan-nyquist-freq 디지털 이미지에서 한 주기를 표현하는 데는 최소 2픽셀이 필요하므로, 줄무늬 간격이 이에 근접할수록 주파수 성분은 스펙트럼의 최외곽에 위치하여 식별이 어려워진다. 특히 간격이 2픽셀 미만일 경우 에일리어싱에 의한 피크 왜곡이 발생할 수 있었다.

다만 본 실험에서 @fig-yokoshima3 의 피크가 명확히 드러나지 않은 것은 나이퀴스트 한계에 직접적인 원인이 있는 것이 아닌, DC 성분의 과도한 강도와 제한된 동적 범위로 인해 고주파 피크가 시각적으로 가려졌기 때문으로 판단되었다.

이에 대하여 FFTJ의 기본 계산식 @fftj-origin 을 수정하여, 원점으로부터의 정규화된 거리 $d_"norm"$, 억제 반경 $R_"sup"$, 최소 배율 $g_"min"$, 가중치 회복 곡률 $gamma$, 그리고 상위 $n_t%$ 강도 $P_"target" (n_t)$를 도입한 @fftj-amplified 를 사용하였다. #footnote[변형 계산식 @fftj-amplified 의 구현에 대해서는 #underline[#link("https://github.com/ShapeLayer/fftj-kt")]에서 확인할 수 있다.]<fn-fftj-kt>

$W(d_"norm")$은 저주파를 억제하기 위한 가중치, $M_"processed"$는 가공된 데이터의 크기를 의도하여 도입하였다. 이번 과제에서는 $R_"sup"=0.12$, $g_"min"=0.1$, $gamma=1.8$, $n_t=99.5$을 사용하였다.

#figure(
  $
  |F(u, v)| = sqrt(R(u, v)^2 + I(u, v)^2)\
  P_"linear" (u, v) = "clamp" ( |F(u, v)| dot frac(255, M_"max"), 0, 255 )
  $,
  caption: [FFTJ에서 사용한 계산식]
) <fftj-origin>

#figure(
  $
  // 1. 저주파 억제 가중치 함수
  W(d_"norm") = cases(
    g_"min" + (1 - g_"min") dot (d_"norm" / R_"sup")^gamma & "if " d_"norm" < R_"sup",
    1 & "if " d_"norm" >= R_"sup"
  )

  \

  // 2. 가공된 크기 데이터
  M_"processed" (u, v) = ln(1 + |F(u, v)|) dot W(d_"norm")

  \
  
  // 3. 백분위수 기반 정규화 (M_min은 M_processed의 최솟값으로 가정)
  P(u, v) = "clamp"((M_"processed" (u, v) - M_"min") / (P_"target" (n_t) - M_"min") dot 255, 0, 255)
  $,
  caption: [수정한 계산식@fn-fftj-kt]
) <fftj-amplified>
  
= 과제 \#2: 이미지 필터

== 과제 \#2에 투입할 이미지의 전처리

#origin-quote[그레이스케일 이미지를 직접 작성하거나 다운로드 등을 통해 준비하십시오. (URL 명시 필수) 단, 이미지는 (4)에서 특징 추출을 수행했을 때 그 효과를 확인할 수 있는 것이어야 합니다.]
/**
 * 원문:
 * 
 * (1) グレースケール画像を作成またはダウンロード等で準備（ＵＲＬ明記）しなさい。なお、作成する画像は、(4)で特徴抽出を行った際に、その効果がわかるものにすること。 
 */

이미지는 직접 촬영한 사진 @sec2-input 의 RGB 채널을 분리하여, 그린 채널을 사용하였다.

#figure(
  image("assets/sec-2/sec2-input.jpeg", width: 60%),
  caption: [
    과제 \#2에 사용할 이미지의 원본
  ],
  placement: top
) <sec2-input>

#grid(
  columns: 3,
  gutter: .5em,
  figure(
    image("assets/sec-2/sec2-input.jpg (red).jpeg"),
    caption: [@sec2-input 의 레드 채널]
  ),
  [#figure(
    image("assets/sec-2/sec2-input.jpg (green).jpeg"),
    caption: [@sec2-input 의 그린 채널]
  ) <sec2-input-green>],
  figure(
    image("assets/sec-2/sec2-input.jpg (blue).jpeg"),
    caption: [@sec2-input 의 블루 채널]
  )
)


== Shape (3, 3) 의 엠보싱 필터 <sec-shape-3-3-emboss>

#origin-quote[수업 중에 배운 내용이나 인터넷 등을 조사하여, '특정한 효과가 있는' 필터 크기 3×3의 공간 필터를 하나 선택하고, 그 필터 계수와 예상되는 효과를 기술하십시오.]
/**
 * 원문:
 * (2)  授業の中で出てきたものやインターネット等を調べて、「ある特定の効果がある」フィルタ長３×３の空間フィルタを一つ選び、そのフィルタ係数と予想される効果を記述しなさい。 
 */

본 과제에서는 "엠보싱 필터 (Emboss Filter)"를 사용하였다.

이 필터는 이미지에 양각 효과를 적용하여 입체감을 부여한다. 한쪽 방향의 외곽선은 밝게, 반대쪽은 어둡게 처리해 빛이 한쪽에서 비추는 듯한 3D 효과를 만든다. @aspose-emboss-filter

#figure(
  $
    k = mat(
      delim: "[",
      -2, -1,  0;
      -1,  1,  1;
       0,  1,  2;
    )
  $,
  caption: [$3 times 3$ 엠보싱 필터의 정의]
) <eq-emboss-filter>

\

*필터 요소 값의 대칭성*

필터 $k$는 중심을 기준으로 좌측 상단은 음수 ($-2$, $-1$), 우측 하단은 양수($1$, $2$)로 구성되어있다.

이는 이미지 전 부분에 걸쳐 좌측 상단은 밝기를 낮춰 그림자를 형성하고, 우측 하단은 밝기를 높여 하이라이트를 형성하도록 한다. 그 결과로서 좌측 상단에서 우측 하단으로 빛을 비추는 효과가 나타난다.

다시 말해, $k$ 행렬의 요소들을 회전하면 엠보싱 효과의 방향성을 조정할 수 있다.

\

*계수의 합*

필터 $k$의 모든 요소를 합하면 $sum k= -2 -1 + 0 - 1 + 1 + 1 + 0 +1 + 2 = 1$이다. 이들 계수의 합은 이미지의 전체 평균 밝기를 표현한다.

$sum k = 1$인 경우에는 이미지 전체의 평균 밝기가 원본과 비슷하게 유지되고, $sum k > 1$이라면 더욱 밝게, $sum k < 1$이라면 더욱 어둡게 나타난다.

특기할 내용으로, $sum k = 0$인 필터는 배경이 검게 변하고 윤곽선만 나타내므로 윤곽선 추출에 사용되고, $sum k$ 가 $[0, 2]$ 범위를 벗어나는 경우에는 대부분의 정보가 검은색($(-infinity, 0)$ 범위) 혹은 흰색 ($(2, infinity)$ 범위)으로 소실된다.

\

*각 가중치의 강도*

필터는 중심 픽셀을 기준으로 인접한 픽셀의 밝기에 대해 계산할 수 있다. $k$의 좌측 상단 값인 $-2$와 우측 하단 값인 $2$에 대하여, 중심 픽셀의 좌측 상단 픽셀의 밝기 $b_p_1$과 우측 하단 픽셀의 밝기$b_p_2$가 같다면 $-2 dot b_p_1 + 2 dot b_p_2 = 0$으로 계산하여 픽셀 밝기의 변화가 없는 평탄한 지점으로 처리된다.

#figure(
  image("assets/sec-2/fig-emboss-filter-visualize.png"),
  caption: [엠보싱 필터 $k$ (@eq-emboss-filter) 에 대해 각 요소의 위치를 $x$, $y$, 요소 값을 $z$로 시각화],
  placement: top,
)<fig-emboss-filter>

@fig-emboss-filter 와 같이 필터 $k$는 가중치 차이를 통해 이미지 상에 가상의 기울기를 형성한다. 이 필터는 좌측 상단에서 우측 하단 방향으로 수치가 높아지는 구조를 가짐으로써, 해당 방향을 따라 발생하는 밝기 변화를 감지하고 입체적인 경사면을 만들어낸다.

이때 필터의 중심에서 멀어지는 외곽 요소에 절대값이 큰 가중치를 배치할수록 픽셀의 변화량은 더욱 민감하게 반영된다. 중심축을 기준으로 거리가 먼 픽셀 간의 밝기 차이에 더 높은 배율을 적용하여, 미세한 명암 차이조차 수치적으로 크게 증폭시키기 때문이다. 결과적으로 가중치의 강도가 높고 중심에서 멀리 배치될수록 이미지의 경계선은 더욱 날카로워지며, 출력값의 대비가 극대화되어 시각적으로 깊이감 있는 엠보싱 효과를 얻게 된다.

\

*필터 요소 내의 각 가중치가 중심에서 더 멀어질 경우*

하지만 필터 요소 내의 각 가중치를 중심에서 더 멀리 떨어뜨리기 위해 필터의 크기를 키운다면, 경계선이 날카로워지는 것과는 반대 작용이 발생할 수 있다.

$5 times 5$, $7 times 7$ 필터 등 크기가 더 큰 필터는 더 먼 거리의 픽셀들을 비교에 사용하므로, 결과물에서 나타나는 가상의 경사면이 더 두껍고 완만하게 형성된다. 

작은 필터는 픽셀 하나하나의 변화에 민감하여 이미지 내의 미세한 노이즈조차 날카로운 변화로 인식하여 결과물을 거칠게 만든다. 반면 큰 필터는 넓은 범위의 밝기 변화를 평균적으로 반영하게 되므로, 국소적인 노이즈의 영향은 줄어들고 전반적인 명암의 흐름이 더 부드럽게 표현함과 동시에, 블러 현상을 동반할 수 있다.

== 엠보싱 필터의 주파수 진폭 스펙트럼

#origin-quote[2에서 선택한 필터의 2차원 이산 푸리에 변환(DFT)을 수행하여 주파수 진폭 스펙트럼을 계산하십시오. (계산은 수기 또는 Python 모두 가능)]
/**
 * 원문:
 * 
 * (3)  (2)のフィルタの２次元離散Fourier変換を行い、周波数振幅スペクトルを計算しなさい。なお、計算は手計算でもPythonでもよい。 
 */
  
```py
>>> import numpy as np
>>> k = np.array([[-2, -1,  0],
...               [-1,  1,  1],
...               [ 0,  1,  2]])
>>> k_f = np.fft.fftshift(np.fft.fft2(k))
>>> k_f
array([[-0.5-0.8660254j , -5. -1.73205081j,  1. +0.j        ],
       [-5. -1.73205081j,  1. +0.j        , -5. +1.73205081j],
       [ 1. +0.j        , -5. +1.73205081j, -0.5+0.8660254j ]])
>>> s = abs(k_f)
>>> s
array([[1.        , 5.29150262, 1.        ],
       [5.29150262, 1.        , 5.29150262],
       [1.        , 5.29150262, 1.        ]])
```

\

엠보싱 필터 $k$에 대한 주파수 진폭 스펙트럼 $S$는 다음과 같다:

#figure($
  k_f &= "DFT"(k)\
  S &= abs( k_f ) \
    &= mat(
      delim: "[",
      1.0,    5.2915, 1.0;
      5.2915, 1.0,    5.2915;
      1.0,    5.2915, 1.0
    )
$,
  caption: [$k$에 대한 주파수 스펙트럼 $S$의 산출]
)

== 엠보싱 필터의 적용 결과

#figure(
  grid(
    columns: 2,
    gutter: 1em,
    image("assets/sec-2/sec2-input.jpg (green).jpeg", width: 80%),
    image("assets/sec-2/sec2-input.jpg (green) convolved.jpeg", width: 80%),
  ),
  caption: [
    @sec2-input-green (좌)과 필터 $k$를 적용한 결과 이미지 (우)
  ],
  placement: top
)<sec-emboss-k-applied-grid>

#figure(
  grid(
    columns: 2,
    gutter: 1em,
    image("assets/sec-2/sec2-input-green-cropped.jpeg"),
    image("assets/sec-2/sec2-input-green-cropped-convolved.jpeg"),
  ),
  caption: [@sec-emboss-k-applied-grid 의 확대],
  placement: top
)<sec-emboss-k-applied-grid-center-cropped>

#origin-quote[NIH ImageJ의 Convolve 필터를 사용하여, (2)의 필터와 (1)의 이미지를 합성곱(Convolution) 연산하고, 결과 이미지를 제시함과 동시에 결과 이미지의 어느 부분에 (2)에서 예상한 효과가 나타났는지 고찰하십시오.]
/**
 * 원문:
 * 
 * 
 * (4)   NIH ImageJのConvolveフィルタを用いて、(2)のフィルタと(1)の画像との畳み込み(積分)計算を行い、結果の画像を示すとともに、結果画像のどこに(2)で予想した効果が現れているかどうかについて考察しなさい。
 */

@sec-emboss-k-applied-grid 과 @sec-emboss-k-applied-grid-center-cropped 를 통해 확인할 수 있듯, 엠보싱 필터 $k$를 @sec2-input-green 와 합성곱 연산한 결과, 이미지에 픽셀의 변화가 두드러지게 나타나는 양각 효과가 적용되었다.  

이어서 @sec-shape-3-3-emboss 에서 논의한 내용이 실제와 부합하는지 확인하기 위해 다음과 같이 변형 필터를 정의하고 합성곱 연산을 수행하였다.  

#figure(
  grid(
    columns: 3,
    align: center + horizon,
    inset: .3em,
    $
      k_r = mat(
        delim: "[",
         2,  1,  0;
         1,  1, -1;
         0, -1, -2;
      )
    $,
    $
      k_p = mat(
        delim: "[",
        -5, -2,  0;
        -2,  1,  2;
         0,  2,  5;
      )
    $,
    $
      k_b = mat(
      delim: "[",
        -2, -2, -1, -1,  0;
        -2, -1, -1,  0,  1;
        -1, -1,  1,  1,  1;
        -1,  0,  1,  1,  2;
         0,  1,  1,  2,  2;
      )
    $
  ),
  caption: [
    $k$를 중심을 기준으로 반전한 필터 $k_r$\
    $k$의 가중치를 더 크게 만든 필터 $k_p$\
    $k$와 비슷한 처리를 수행하면서 크기가 더 큰 필터 $k_b$
  ]
)

\

*엠보싱 필터 $k$ 및 원점 대칭한 필터 $k_r$*

#grid(
  columns: 3,
  align: center + horizon,
  inset: (x: .3em, y: .5em),
  [#figure(image("assets/sec-2/sec2-input-green-cropped.jpeg"), caption: [원본])],
  [#figure(image("assets/sec-2/sec2-input-green-cropped-convolved.jpeg"), caption: [$k$ 적용])<input-green-k-kr-crop>],
  [#figure(image("assets/sec-2/input-green-cropped-k_r.jpeg"), caption: [$k_r$ 적용])<input-green-kr-crop>],
)

엠보싱 필터 $k$ 및 원점 대칭한 필터 $k_r$을 이미지에 적용한 결과, 원본 이미지 상에서의 픽셀 가장자리가 두드러지게 나타나게 되었다. 필터 요소 값을 원점 대칭한 것 역시 결과에 반영되어, @input-green-k-kr-crop 의 가장자리 표현과 @input-green-kr-crop 의 가장자리 표현이 반대로 나타나는 것을 확인할 수 있었다.

\

*가중치를 키운 필터 $k_p$ 및 $5 times 5$ 필터 $k_b$*

#grid(
  columns: 3,
  align: center + horizon,
  inset: (x: .3em, y: .5em),
  [#figure(image("assets/sec-2/sec2-input-green-cropped-convolved.jpeg"), caption: [$k$ 적용])<input-green-k-kpb-crop>],
  [#figure(image("assets/sec-2/input-green-cropped-k_p.jpeg"), caption: [$k_p$ 적용])<input-green-kp-crop>],
  [#figure(image("assets/sec-2/input-green-cropped-k_b.jpeg"), caption: [$k_b$ 적용])<input-green-kb-crop>],
)

엠보싱 필터 $k$의 개별 값을 임의로 증폭시킨 필터 $k_p$를 이미지에 적용한 결과인 @input-green-kp-crop 에서는 @input-green-k-kpb-crop 과 비교하여 픽셀의 변화가 더욱 두드러지게 나타나, 거칠게 표현되고 있음을 확인할 수 있었다.

@sec-shape-3-3-emboss 에서의 추측과 실제 결과물이 다른 사례는 필터 $k_b$ 를 적용한 @input-green-kb-crop 이었다. @input-green-kb-crop 국소적인 노이즈의 영향은 줄어들고 전반적인 명암의 흐름이 더 부드럽게 표현될 것으로 추측했지만, 필터 적용 결과 중 가장 거친 표면 질감을 표현하고 있다.

이것은 입력 이미지의 특징이 이러한 결과의 원인으로 보인다. 이미지 내 질감을 형성하는 픽셀 변화 간의 거리가 $5 times 5$ 크기의 필터 $k_b$가 감쇄시키기에 충분히 조밀하지 않았으며, 오히려 해당 필터 크기가 국소적인 노이즈 성분을 강조하는 역효과를 낸 것으로 분석된다.

@sec-shape-3-3-emboss 의 추측과 같은 부드러운 명암 흐름과 노이즈 억제 효과를 얻기 위해서는 $5 times 5$ 크기를 상회하는 훨씬 더 큰 크기의 필터를 적용하여야 할 것으로 보인다.

/*
#grid(
  columns: 3,
  align: center + horizon,
  inset: (x: .3em, y: .5em),
  grid.cell(rowspan: 2, figure(image("assets/sec-2/sec2-input-green-cropped.jpeg"), caption: [원본])),
  figure(image("assets/sec-2/sec2-input-green-cropped-convolved.jpeg"), caption: [$k$ 적용]),
  figure(image("assets/sec-2/input-green-cropped-k_r.jpeg"), caption: [$k_r$ 적용]),
  figure(image("assets/sec-2/input-green-cropped-k_p.jpeg"), caption: [$k_p$ 적용]),
  figure(image("assets/sec-2/input-green-cropped-k_b.jpeg"), caption: [$k_b$ 적용]),
)
*/


= 과제 \#3: 틀린그림 찾기 구현 <sec-3>

#origin-quote[
  잡지 등에 게재되는 '틀린 그림 찾기' 문제를 디지털카메라나 이미지 스캐너로 디지털화하여, 컴퓨터로 자동 해결하려면 어떤 처리를 하면 좋을지 그 알고리즘을 설명하십시오.
  
  - 디지털 카메라로 촬영한 경우와 플랫베드 스캐너를 사용한 경우로 나누어 설명할 것
  - OpenCV 등 구체적인 함수명이 아니라, 처리 내용을 기술할 것
    - (잘못된 예) np.fft.fft2(A)를 실행한다
    - (올바른 예) 이미지 A에 대해 2차원 FFT(고속 푸리에 변환)를 실행한다
  - 마지막에는 반드시 '차이점(상이한 부분)'을 강조하는 처리를 포함할 것
]
/**
 * 원문:
 * 
 * 次の図のような雑誌に掲載されていた間違い探し問題を、ディジカメやイメージスキャナでディジタル化し、コンピュータで自動的に解くにはどのような処理を行えば良いか、アルゴリズムを説明しなさい。
 * 
 * - ディジカメで撮影した場合と、フラットベッドスキャナの場合で分けて説明すること
 * - OpenCVなどの具体的な関数名ではなく、処理内容を記述すること
 *   - × : np.fft.fft2(A)を実行する
 *   - ○ : 画像Aに対して２次元FFTを実行する
 * - 最後に必ず「相違箇所」を強調する処理を含めること
 */

틀린그림 찾기 문제를 컴퓨터로 해결하기 위해서는, 우선 이미지 처리가 용이하게 왜곡 등을 보정, 정렬하여야 한다. 일련의 보정, 정렬 작업을 통해 입력 이미지의 왜곡을 완화한 후, 차이가 두드러지는 지점을 산출하여 틀린 그림 찾기 상의 틀린 부분으로 판단한다. 이렇게 산출한 지점들은 지나치게 작고 지엽적이거나, 개별 영역들이 가깝거나 겹쳐져 있을 수 있다. 개별 영역이 지나치게 작다면 이를 노이즈로 판단하여 틀린 부분에서 제거, 서로 매우 가깝거나 겹쳐져 있는 영역은 하나의 큰 영역으로 병합한다.

위와 같은 일련의 처리에 대해 구체적인 구현 상 차이는 있더라도 위 처리 과정을 큰 틀에서 벗어나지는 않을 것으로 보인다.

\

#place(
  top,
  float: true,
  scope: "parent",
  clearance: 15pt,
)[
  #figure(
    block(
      fill: color.white,
      image(
        "assets/sec-3/spotdiff-py-pipeline.drawio.svg"
      ),
    ),
    caption: [틀린그림 찾기 처리기 구현체의 처리 파이프라인 구성]
  ) <diagram-spotdiff-py-pipeline>
]

위 내용을 근거로 @diagram-spotdiff-py-pipeline 과 같은 처리 파이프라인을 갖는 틀린그림 찾기 처리기를 구현하였다. 처리기 구현체는 Python과 OpenCV를 중심으로 작성되었다. 이 구현체는 입력에 대해 이미지의 왜곡을 보정, 전처리하여 정렬한 후, 차이점을 산출하여 차이점을 산출한다. 이들 과정 중간에는 계속해서 입력 이미지 혹은 중간 처리 과정에서 발생한 노이즈나 불필요한 데이터를 제거하는 후처리 작업이 수행된다.  

처리기는 #underline[#link("https://github.com/shapelayer/spotdiff-py")]에서 확인할 수 있다.

구체적인 처리 알고리즘은 다음과 같다:

== 이미지 전처리 및 정규화

이미지 처리의 첫 단계는 입력 매체의 특성에 맞춰 분석에 적합한 상태로 데이터를 정규화하는 것이다.

\

*디지털카메라를 사용한 경우*

디지털카메라로 촬영한 경우에는 외부 조명의 영향으로 밝기 불균형, 그림자가 쉽게 발생한다. 대부분 이러한 색상 왜곡은 중대하게 발생하지는 않고, 외곽선 검출 등에도 치명적이지 않을 것으로 판단하였으나, 색상 왜곡의 정정 과정을 건너뛰었을 경우에 어떤 결과가 유도될지는 비교실험하지 못했다.

#figure(
  image("assets/sec-3/omikuji-color.jpeg"),
  caption: [
    디지털 카메라로 촬영하면 녹색으로 하이라이트 한 것과 같이 그림자가 형성되는 경우가 잦다.
  ],
) <fig-omikuji-color>

색상 왜곡을 정정하는데 있어서는 이미지의 밝기 성분을 추출하여 국부적인 대비를 개선하는 적응형 히스토그램 균일화(CLAHE; Contrast Limited Adaptive Histogram Equalization) 처리를 수행하였다. 

#figure(
  [
    #image("assets/sec-3/histogram-eq.png")#image("assets/sec-3/histogram-eq-clahe.png")
  ],
  caption: [히스토그램 균일화 (상), CLAHE (하) (source: @opencv-python-kr-tutorial-histogram-eq)],
  placement: top
)

히스토그램 균일화는 이미지 전체의 밝기 분포를 하나로 계산하여 넓게 펼치므로, 외부 요인에 의해 형성된 그림자를 제거하는 데 유효했다.@opencv-python-kr-tutorial-histogram-eq 특기할 점으로 단순 히스토그램 균일화는 전체적으로 어둡거나 밝은 이미지의 대비를 높이는 데는 효과적이지만, 사진의 한쪽은 밝고 다른 쪽은 그림자가 져 있다면, 밝은 곳은 너무 하얗게 날려버리고 어두운 곳은 노이즈를 과하게 증폭시켜@geek-for-geeks-clahe 오히려 역효과 유발할 우려가 있었다. 

\

*스캐너를 사용한 경우*

반면 플랫베드 스캐너를 사용한 경우에는 조명이 비교적 일정하므로 주목할만한 처리를 거칠 필요가 없다고 판단하였다.

다만 플랫베드 스캐너의 결과물에는 디지털 카메라 수준까지는 아니어도, 미세한 먼지나 다소의 잡음이 섞이는 경향이 관찰되므로, 미디언 필터를 사용해 점 잡음을 제거했다.

== 이미지 정렬 및 왜곡 보정

#figure(
  grid(
    columns: 2,
    image("assets/sec-3/omikuji-flatted.jpg"),
    image("assets/sec-3/omikuji-overlayed.jpg")
  ),
  caption: [
    @fig-omikuji-color 에서 촬영한 대상을 왜곡이 덜하게 재촬영 (좌)\
    @fig-omikuji-color 와 좌측의 이미지를 겹침 (우)
  ]
) <fig-omikuji-flat-overlay>

서로 다른 환경에서 획득된 두 이미지를 픽셀 단위로 비교하기 위해서는 두 이미지의 좌표계를 일치시켜야 했다. 특히 디지털 카메라로 대상을 촬영한 경우, 같은 구도로 촬영하였더라도 대개는 @fig-omikuji-flat-overlay 과 같이 왜곡이 발생하여 이미지의 좌표계가 불일치가 발생했다.

\

이들의 공간 왜곡을 정정하고 입력 이미지들의 좌표계를 일치시키기 위해, 각 이미지의 특징점을 검출해 서로 매칭하였다. 이와 같이 매칭한 특징점 정보를 이용해 변환 행렬을 산출하고 이미지를 워핑하여 두 이미지가 동일한 좌표계 위에 겹치도록 재배치하였다.

특징점 정보는 ORB를 사용하여 추출하였고, Brute-Force Matcher를 사용하여 이들 점을 매칭하였다.@opencv-docs-feature-matching 매칭 처리 도중에 잘못 매칭된 점들을 RANSAC 알고리즘을 사용하여 제거, 남은 점들을 사용해 이미지를 워핑하였다.@opencv-docs-feature-homography 

#figure(
  image("assets/sec-3/camera-captured-monitor-procfailed.png", width: 60%),
  caption: [모니터 화면을 촬영한 이미지를 입력으로 사용했을 때의 정렬 실패 사례],
) <fig-camera-captured-monitor-procfailed>

특기할 사항으로 구현체를 테스트하는 과정에서 입력 이미지를 표시하는 모니터 화면을 디지털 카메라로 촬영해 구현체에 입력한 사례에서, @fig-camera-captured-monitor-procfailed 과 같이 이미지 정렬에 실패하는 현상을 관찰하였다. 이는 모니터 화면을 촬영할 때 발생하는 미세한 격자 무늬가 특징점 검출 단계에서 다수 검출되어, 이들 점이 잘못 매칭된 결과로 보인다. 이러한 문제를 해결하기 위해서는 특징점 검출 전 단계에서 블러 필터를 적용하거나 그 외의 전처리가 필요할 것으로 판단된다. 하지만 모니터 화면을 촬영한 이미지를 입력으로 사용하는 시나리오는 이 구현체에 혹독한 환경이고, 본 과제 요구사항에 제시되지 않았으므로 이후의 개선 과제로 남겨두기로 하였다.  

== 차이점 추출 및 후처리

차이점 추출 단계에서는 비교할 두 이미지에 대하여 픽셀 변화를 산출, 그룹화하여 서로 다른 영역을 찾는다.  

픽셀 변화는 절대 차분을 사용했는데, 디지털 카메라를 사용한 이미지를 입력한 경우에는 소금-후추 노이즈가 나타나는 사례가 보고되어 @alajlan2004detail@wikipedia-salt-and-pepper-noise Median Blurring를 후처리에 사용해 증상 완화를 도모하였다. @opencv-tutorial-py-filtering-salt-pepper

이렇게 획득한 차분 마스크에 대해 이진화를 적용해 틀린 부분의 후보 영역에 대한 흑백 마스크로 변환, 모폴로지 닫힘 연산을 수행하여 지금까지의 처리 과정에서 발생한 마스크 상의 작은 구멍, 노이즈 등을 정리하도록 했다. @opencv-forum-ignoring-background-in-binarization@opencv-tutorial-py-morphological-ops

이 이진 마스크는 차이점이 발생한 영역의 외곽선을 추출하는데 사용하였다. 외곽선 추출은 Suzuki et al.의 외곽선 검출 알고리즘을 사용해 구현, @suzuki1985topological@opencv-docs-py-findcontours 검출된 각 객체들을 감싸는 바운딩 박스를 산출, 중첩되거나 인접한 바운딩 박스를 병합하여 틀린 영역을 확정하였다.

== 실험 및 결론

구현체의 성능을 파악하기 위해 @wikimedia-jp-muband-machigai 를 수정 없이 구현체에 입력하였다. 그 결과는 @fig-muband-spotdiff-result 와 같다. 구현체에서는 위양성이 발생하지는 않았지만, 총 15개@wikimedia-jp-muband-spotdiff-result 중 10개만을 찾아내어 66.66%의 높지 않은 정답률을 보였다.

#figure(
  image("assets/sec-3/muband-spotdiff-result.png"),
  caption: [디지털 그래픽에 대해 처리 시도 (@wikimedia-jp-muband-machigai 사용; CC BY-SA 3.0)]
) <fig-muband-spotdiff-result>

감지하지 못한 변화는 "벽시계의 시계 바늘", "고양이 뒤의 접시에 그려진 얼굴 모양", "우측 하단 프레임에 의해 잘린 화분의 꽃의 개수"와 같이 그래픽 상에서 상대적으로 작게 표시된 것들이었다. 이에 근거하여 노이즈를 제거하기 위해 파이프라인 중간에 삽입한 필터와 개별 처리들이 차이점 검출 성능에 부정적인 영향을 미친 것으로 추정되어, 이들 처리의 구성 설정을 조정하였으나 뚜렷한 개선 효과는 관찰되지 않았다. 

성능 실험에 투입한 이미지가 카메라를 이용해 촬영하거나 플랫베드 스캐너로 스캔한 것이 아닌, 디지털 그래픽의 원본 파일임을 고려하면, 실제 사용 시나리오 상에서는 더욱 하회하는 성능을 보일 것으로 예상된다.

이 구현체의 파이프라인 구성과 그 구성 설정에 있어 개선 과제가 명확히 남아있으나, 본 과제의 범위 내에서는 획기적인 개선을 도모할 수 없다고 판단, 이후의 개선 과제로 남겨두기로 하였다.

/*
 시각화 관련 내용은 결과물 사진을 첨부하는 것으로 간단히 서술
 */

= 과제 \#4: 이미지 처리 응용 시스템 사례조사

#origin-quote[
  최근 이미지를 이용한 시스템이 많이 활용되고 있습니다. 예를 들어:
  
  - 공항에서의 얼굴 인증을 통한 출입국 심사
  - 열화상 카메라(서모그래피)를 통한 입국 예정자의 건강 상태 파악
  - 스마트폰이나 은행 ATM에서의 지문 인증을 통한 본인 확인
  - 어라운드 뷰 모니터로 대표되는 자동차 주변 조망
  
  등 다양한 업종과 용도로 이용되고 있습니다. 현재 상품화되어 있는 이러한 시스템 중 한 종류를 선택하여, 인터넷 등을 통해 그 원리와 장점, 그리고 여러분이 생각하는 문제점(단점)을 설명하십시오. (참고한 웹페이지 URL 등은 반드시 명시하십시오. 무단 인용 시 저작권 침해가 될 수 있으니 주의하십시오.)
]

/**
 * 원문:
 * 
 * 近年、画像を利用したシステムが多く利用されている。例を挙げると、 
 * - 空港での顔認証による入出国審査 
 * - サーモグラフィによる入国予定者の健康把握 
 * - スマートフォンや銀行ATMでの指紋認証による本人確認 
 * - アラウンドビューモニタを代表とする自動車周辺の俯瞰 
 * など、様々な業種や用途で利用されているが、現在商品化されているこうしたシステムを１種類選択して、インターネット等を用いてしくみや長所、皆さんが考えられる問題点（短所）を説明しなさい。（参考にしたWebページのURLなどは必ず明記すること。明記せずに無断で引用した場合は著作権や版権の侵害になりますのでご注意ください。）
 */

== 상용화된 안면인식 결제와 그 구현

#figure(
  image("assets/sec-4/sbs-toss-facial-payment.jpeg"),
  caption: [토스의 안면인식 결제 단말 및 안면인식 결제 @sbs-toss-facial-payment (01:33)]
)

한국의 핀테크 기업인 토스는 한국에서 안면인식 결제를 서비스하고 있다. 이 결제 방법은 신용카드, 스마트폰 등 다른 신원인증 수단을 일체 사용하지 않고 얼굴만으로 개인을 식별해 결제를 승인한다. 다시 말해 개인의 얼굴을 키, 개별 신원 정보를 값으로 갖는 일종의 매핑 시스템을 구현하고 상용화한 것이다. 이 시스템은 "토스 프론트"라고 명명된, 토스에서 개발하여 보급하고 있는 전용 결제 장치를 통해 구현되었다.

\

한국에서는 대부분의 결제에 신용카드를 사용함에도 불구하고, 널리 보급된 카드 결제 기기는 EMV 컨택리스(Contactless) 규격을 지원하지 않아 "IC 칩 신용카드를 꽂아서 결제"하는 방법만을 사용할 수밖에 없었다.@dginclusion-emv-contactless 한국 금융권에 따르면, 지난 2025년 한국에서의 컨택리스 활용 비중은 10% 미만으로 추정되고 있다.@mt-emv-contactless

때문에 이들 규격을 이용하는 애플페이의 가맹점 역시 빠르게 늘지 못했고, 일본의 PayPay 결제와 비슷한 위치를 갖는 한국의 "네이버페이", "카카오페이" 간편결제 서비스 역시 화면상에 바코드와 QR코드를 표시하는 방식으로 결제를 구현하여 카메라나 코드 스캐너가 마련된 업장에서만 이들 결제 수단을 사용할 수 있었다.


이러한 배경에서, 토스 프론트는 컨택리스 결제를 추가하여 애플페이를 사용 가능한 차세대 결제 단말기로서 널리 보급되었다. 이 기기는 안드로이드를 운영체제로 사용, 사실상 저사양의 스마트폰과 동일한 스펙, 미려한 디자인과 회사의 프로모션 정책으로 한국에 널리 퍼지게 되었다.

토스는 이와 같이 강한 경쟁력으로 한국 내 결제 인프라에 합류한 후, 이미 결제 기기에 포함되어있던 카메라 하드웨어를 이용해 안면인식 결제를 상용화했다.

#figure(
  text(size: .8em, table(
    columns: 2,
    align: horizon,
    [프로세서], [듀얼코어 2.4GHz + 쿼드코어 1.9GHz],
    [운영체제], [안드로이드 11#footnote[최초 출시 당시, 현재와는 상이할 수 있음]],
    [메모리], [3GB RAM],
    [디스플레이 & 터치], [7인치 LCD(1280x800), 정전식 터치],
    [사운드], [2W 스피커],
    [카메라], [RGB 카메라 5MP (2개)],
    [결제 방식], [IC, MSR, NFC],
    [연결 단자], [시리얼포트, USB-C, 랜],
    [무선 통신], [Wi-Fi(2.4GHz, 5GHz), 근거리무선통신(2.4GHz), RFID],
    [인증], [EMV 컨택 L1/L2, 컨택리스 L1/L2, KC, 단말기 보안인증],
    [ 
      컨택리스 카드\
      브랜드사 인증
    ], [Master(Paypass), Visa(Paywave), DPAS, JCB, CUP]
  )),
  caption: [토스 프론트2의 하드웨어 스펙@toss-oopy-toss-front2],
  placement: top,
) <table-toss-front2-spec>

== 예상 가능한 문제점, 공격 시나리오와 대응

안면인식 기술은 이에 전적 의존해 결제를 승인할만큼은 아직 신뢰도가 높지 않았다는 것이 일반적으로 널리 퍼진 인식이다.

\

적외선 도트 프로젝터와 3차원 안면 데이터, 그리고 전용 가속기인 Neural Engine까지 동원해 입체적인 생체 정보를 분석하는 애플의 FaceID조차 정교하게 제작된 3D 마스크나@bkav-beats-face-id 생물학적 유사성이 높은 쌍둥이에 의해 무력화된 사례가 보고된 바@quora-my-twin-brother-can-easily-fool@tiktok-thegreen_twins-unlock-iphone 있고, 애플도 공식적으로 "사용자와 닮은 형제자매 및 쌍둥이, 그리고 만 13세 미만 어린이의 경우 인식 오류가 발생할 통계적 확률이 더 높다"고 인정하고 있다.@apple-about-faceid

토스의 안면인식 결제에 사용하는 카메라는 일반적인 RGB 카메라임을, 안면인식 결제가 처리해야 할 문제가 FaceID와 같이 참/거짓의 이분 분류가 아니라 수많은 사용자 사이에서 대상자를 식별해야 하는 분류 문제임을 고려하면, 대중적으로도 안면인식 결제의 시스템 실패와 금융 사고의 발생을 우려할 수밖에 없다.

\

이러한 우려에 따라 언론사 SBS에서는 이 안면인식 결제 시스템에 시스템 실패를 유도하는 실험을 몇 가지 수행하였다. @sbs-toss-facial-payment

\

*실험: 얼굴 사진을 종이에 출력*

#figure(
  image("assets/sec-4/sbs-fail-test-paper-printing.jpeg"),
  caption: [얼굴 사진을 종이에 출력하여 결제 시도 @sbs-toss-facial-payment (05:16)]
) <fig-sbs-fail-test-paper-printing>

@fig-sbs-fail-test-paper-printing 와 같이 얼굴 사진을 종이에 출력하여 결제를 시도하는 방식으로는 결제에 성공할 수 없었다. 모든 결제 기기에는 카메라가 2대 포함되어 있어, FaceID의 TrueDepth와 유사하게 얼굴의 깊이를 측정해 이러한 유형의 공격을 방어하는 것으로 보인다.

다만 FaceID를 성공적으로 공격한 3D 마스크 공격에 대해서는 실험되지 않았다. 사측에서는 실시간 얼굴 생체 판단 기술을 사용하여 3D 마스크 공격을 방어한다고 밝혔으나@toss-facepay-press-en, 구체적인 기술적인 사양은 공개된 내용이 없었다.@yozm-toss-facepay

\

*실험: 마스크와 모자 착용*

#figure(
  image("assets/sec-4/sbs-fail-test-hide-with-mask.jpeg"),
  caption: [
    얼굴 전면을 의료용 마스크로 가리고 결제 시도 @sbs-toss-facial-payment (07:59)\
    결제가 승인되지 않고, "눈썹과 입이 잘 보이게 해주세요"라는 안내 문구가 표시되었다.
  ],
)

헤어스타일, 모자, 액세서리 등은 일상 생활 중에 쉽게 변화하는 부분에 대해서는, 최초 등록시로부터 변화가 있어도 동일인임을 판별할 수 있었다. 이어지는 실험에서, 의료용 마스크와 같이 얼굴 상당 부분, 혹은 전면을 가려 얼굴 인식 처리를 수행할 수 없는 경우가 아니라면 결제가 진행되는 것으로 파악되었다.

\

*실험: 여러명이 한 번에 결제를 시도할 경우*

#figure(
  image("assets/sec-4/sbs-fail-test-multiple-people.jpeg"),
  caption: [
    여러명이 한 번에 결제를 시도 @sbs-toss-facial-payment (09:57)
  ]
)

이 실험은 여러명이 한 번에 결제를 시도하는 것보다, 사람이 몰린 시간대에 공격자가 자신의 뒤에서 순번을 대기하고 있는 사람의 얼굴로 결제를 시도하는 시나리오에서의 흐름을 파악하기 위해 시도되었다.

이와 같이 여러명이 한 번에 카메라 프레임 안에 등장한 경우에는, 비정상 사용으로 판단하지 않고 프레임 상에서 가장 얼굴이 크게 나온 사람을 기준으로 인증 처리를 수행하였다.

\

*시스템 실패 대책: 2차 인증*

#figure(
  image("assets/sec-4/sbs-fail-test-mfa.jpeg"),
  caption: [
    안면인식 결제에 2차 인증을 설정한 경우 @sbs-toss-facial-payment (10:36)\
    거래가 즉시 승인되지 않고 "내 번호를 입력해주세요"라는 안내 문구가 표시된다.
    // 번역시: 내 번호를 입력해 주세요는 자신의 번호를 입력해주세요. 로서 해석해야함
  ],
)

이 서비스가 구현하는 안면인식 결제의 기술적 본질은 단말 기반의 생체 보안인증(Biometric Authentication)보다는, 사용자의 안면 데이터를 인덱스 키(Index Key)로 치환하여 중앙 데이터베이스로부터 사용자 정보를 추출하는 식별(Identification) 프로세스에 집중되어 있다. 이러한 기술적 특성은 마케팅 전략에서도 일관되게 나타나는데, 생체 보안인증 수단으로서 강조하기보다 신용카드나 모바일 기기 등 물리적 매체가 불필요한 비매체 결제(Cardless/Phoneless Payment)의 편의성을 주요한 특징으로 설정하고 있다.

이러한 식별 중심 시스템에서 발생할 수 있는 잠재적 금융 사고 및 시스템적 취약성을 보완하기 위해, 서비스 제공자는 2차 인증을 리스크 완화 기제로 활용하고 있다. 가입자 휴대전화 번호의 부분 입력 혹은 별도 비밀번호 인증 등의 다중 인증 절차를 병행함으로써, 오인식이나 명의 도용에 따른 부정 거래 가능성을 기술적으로 차단하고 결제 보안의 신뢰성을 제고하고 있는 것으로 분석된다.

\

*시스템 실패 대책: 비정상 인증 시도 차단 및 안심보상제*

#figure(
  image("assets/sec-4/sbs-fail-test-service-blocked.jpeg"),
  caption: [
    FDS에 의해 차단된 경우 @sbs-toss-facial-payment (06:18)\
    안면인식 결제가 비활성화되고 다른 방법으로 결제하기 버튼과 함께 "토스 고객 센터로 문의해주세요 (전화번호)"라는 안내 문구가 표시되었다.
  ],
  placement: top
) <fig-sbs-fail-test-blocked>

부정 거래 시도에 대응하기 위해 이상거래탐지시스템(Fraud Detection System; FDS)을 운용하고 있으며, 이를 통해 비정상적 인증 시도를 탐지 및 차단함으로써 거래의 안전성을 도모하고 있다. 실제로 실험 과정 중 잘못된 시도가 이어지자 @fig-sbs-fail-test-blocked FDS에 의해 악의적인 시도가 차단되고, 결제가 비활성화 처리되는 모습을 확인할 수 있었다.

또한, 기술적 방어망의 한계로 인해 부정 거래가 실현될 경우에 대비하여, 피해 금액 전액을 보전하는 소비자 보상 제도를 명문화하고 있다.@toss-facepay 이러한 보상 정책의 명시적 표방은 시스템적 결함으로 인한 소비자 피해를 서비스 제공자가 귀책하는 당연한 내용이나, 일반적으로는 부정적 정보를 은폐하려고 하거나 소비자 분쟁 혹은 소송으로 이어진 후에 결론이 나는 것과는 대조적이다.

이는 시스템의 안정성에 대해 높은 신뢰감을 표현하는 수단으로서 활용하고, 소비자의 신뢰를 유도하여 신규 사용자를 확보하려는 전략으로서 이해할 수 있을 것으로 보인다.


= 과제 \#5: 화상정보처리 시스템 개발 <sec-5>

#origin-quote[
  정지 영상이나 동영상을 사용하여 오리지널 작품을 만드십시오.

  《예시》
  - 자체 제작 또는 공개된 모핑(Morphing) 소프트웨어를 사용하여(가능한 한 크로스 디졸브뿐만 아니라 워핑도 포함), 이미지 A에서 이미지 B로 부드럽게 변화하는 모핑 이미지 제작. (zip 압축 후 전용 사이트에 제출)
  - Python이나 OpenCV를 이용한 이미지 응용 시스템 제작. 소스 파일을 제출하고 시스템 개요 등을 설명하십시오. (예: 카메라 속 얼굴 표정에 맞춰 캐릭터의 표정도 변하는 Vtuber 스타일 시스템 등)
  - 크로마키 작품 제작 (그린 스크린 대여 가능)
  - 수 초 정도의 테마가 있는 사이런트(무음) 동영상 작품 제작.
]
/**
 * 静止画像や動画像を使って、オリジナル作品を作りなさい。 
 * 《例》 
 * ● 自作または公開されているモーフィングソフト（可能な限りクロスディゾルブだけではなくワーピングも）を用いた、画像 A から画像 B へ滑らかに変化するモーフィング画像の作成。（ zipで圧縮後、専用サイトから提出のこと） 
 * ● pythonやOpenCVを用いた、画像応用システムの作成。ソースファイルを提出するとともに、システムの概要などを説明しなさい。（カメラの顔の表情に合わせてキャラクターの表情も変化するVtuber的システムなど） 
 * ● クロマキー作品の制作（グリーンスクリーン貸し出し可能） 
 * ● 数秒程度のテーマ性のサイレント(無音)動画作品の制作ファイル形式は原則として mp4、mkv、アニメーション GIF かアニメーション PNG のいずれかにすること。（zipで圧縮後、アップロードサイトから提出のこと）
  */

화상정보처리 시스템으로서, 카메라 속 얼굴 표정과 얼굴 방향에 맞춰 2D 캐릭터 모델의 표정과 시선 방향을 변화시키는 Vtuber 시스템을 @fig-lite2d-vtuber-heading-left @fig-lite2d-vtuber-heading-right 과 같이 구현하였다. 

#origin-quote(
  _stroke: "#015958",
  _fill: "#0FC2C003"
)[
  참고

  이 작업에는 Live2D가 저작한 샘플 캐릭터 모델 Mao를 #underline[#link("https://www.live2d.com/eula/live2d-free-material-license-agreement_en.html")[『무상 제공 소재의 소프트웨어 라이선스 계약서』]] #underline[#link("https://www.live2d.com/eula/live2d-sample-model-terms_en.html")[『Live2D Cubism 샘플 데이터 이용 조건』]]에 근거하여 사용하였다. 
]

#figure(
  image("assets/sec-5/lite2d-vtuber-heading-left.png"),
  caption: [구현체 상에서 고개를 좌측으로 기울인 모습],
  placement: top,
) <fig-lite2d-vtuber-heading-left>

#figure(
  image("assets/sec-5/lite2d-vtuber-heading-right.png"),
  caption: [구현체 상에서 고개를 우측으로 기울인 모습],
  placement: top,
) <fig-lite2d-vtuber-heading-right>

이를 달성하기 위해, Live2D Cubism SDK를 이용한 렌더링 애플리케이션과, 캐릭터의 렌더링 설정을 미세 조정하는 유틸리티 소프트웨어를 새로 작성하였다. 이들 소프트웨어군에서 캐릭터 렌더링에 관여하는 프로그램은 C/C++을 사용하여, 유틸리티 소프트웨어어는 Svelte를 기반으로 한 GUI 웹 애플리케이션으로 작성하였다. 이렇게 준비한 렌더링 시스템과 OpenCV의 얼굴 검출, 랜드마크 검출 기능을 결합하여, 카메라 속 얼굴의 방향과 표정에 맞춰 2D 캐릭터 모델의 시선과 표정을 변화시키는 Vtuber 시스템을 구현하였다.  

\

구체적으로는 다음과 같은 구현체로 구성하였다: cubism_vtuber, lite2d-editor, lite2d-editor-ui, moc32json. 이 시스템 구현은 #underline[#link("https://github.com/ShapeLayer/cubism-sdk-realtime-facial-representation")]과 #underline[#link("https://github.com/shapelayer/lite2d")]에서 확인할 수 있다.

\

이들 구현체에서 핵심 구현은 cubism_vtuber이다. cubism_vtuber는 Live2D의 Cubism Native Framework에 의존하는데, 이들 프레임워크를 활용하여 OpenGL을 사용하여 2D 캐릭터 모델을 렌더링하는 것을 목표로 한다. 

lite2d-editor와 lite2d-editor-ui는 렌더링 설정을 미세 조정하는 데 사용하기 위해 작성한 웹 애플리케이션이다. 로드하려는 캐릭터 모델에 대해, 모델이 미세하게 어떻게 움직이는지, 각 텍스쳐 부위가 올바른 순서에 맞게 로드되는지 확인하면서 설정 값을 수정할 수 있어야 했는데, 이것을 텍스트 에디터로 확인하기에는 어려운 점이 있었다. 그래서 이들 설정 값에 의한 렌더링 결과를 실시간으로 확인하면서 설정 값을 조정할 수 있는 GUI 애플리케이션이 필요했다.  

== cubism_vtuber

#figure(
  image("assets/sec-5/cubism-vtuber-closing-eye.png", width: 80%),
  caption: [기준이 되는 인물이 눈을 감는 상황을 인식해 시스템이 캐릭터의 눈이 감기게 하고 있다.]
)

이들 시스템을 표시하는 cubism_vtuber는 OpenCV와 OpenCV 내장 haarcascade 분류기를 사용해 카메라 속 인물과 얼굴을 검출하여 랜드마크를 추출한다. 이들 랜드마크 정보를 사용해 얼굴의 방향과 표정을 추정, 이들 정보를 Live2D Cubism SDK에 전달하여 2D 캐릭터 모델의 시선과 표정을 변화시키도록 구현하였다.  

하지만 haarcascade 분류기의 민감도를 조정하는 것으로는 상용 VTuber 시스템 수준을 만족할 수는 없었다. 함께 첨부한 시연 영상에서 확인할 수 있듯, 이들 분류기는 미간의 앞머리 부분을 입으로 오인식하는 경우가 잦아, 캐릭터 모델이 입을 쉽게 움직이지 않았다. 또한 얼굴의 y축 회전에 있어서도 잘 인식하지 못해, 고개를 좌우로 꺾는 동작 외에는 얼굴의 회전이 눈에 띄게 반영되지는 않았다.  

이들 문제에 대해서는 이후에 얼굴 검출 프로세스에 딥러닝 모델을 사용하는 것으로 개선할 수 있을 것으로 보인다. 하지만 haarcascade 분류기가 수업에서 소개되었고, mediapipe 등의 모델을 이 구현체와 함께 사용하기 위해서는 FFI를 구현하거나 C/C++ 라이브러리만 부분적으로 컴파일해야하므로, 본 과제의 범위를 벗어났다고 판단하여 이후의 개선 과제로 남겨두기로 하였다.

== moc32json, lite2d-editor, lite2d-editor-ui

#figure(
  image("assets/sec-5/mao_pro_default.png", width: 80%),
  caption: [데모 캐릭터 Mao의 렌더링 기본값],
  placement: top,
) <fig-mao-pro-default>

Live2D에서 공식적으로 제공하는 데모 캐릭터는 다채로운 동작을 표현할 수 있도록, 다양한 텍스쳐의 변형 데이터를 포함하고 있다. 이들 데이터는 @fig-mao-pro-default 와 같이 한 번에 표시되어, 캐릭터에 따라서는 팔이나 다리가 네 개 이상 그려지는 모습을 보였다.  

Live2D Cubism Editor를 사용해 각 부분의 렌더링 설정을 조정하여 캐릭터가 자연스럽게 보이도록 할 수 있다. 하지만 무료판의 제한 사항으로 데모 캐릭터의 설정을 저장하거나 적용하는 데 한계가 있었고, 에디터는 애니메이팅, 모델링 등 이 과제에 필요하지 않은 기능이 다수 포함되어 있어 사용에 어려움이 있었다.  

#figure(
  image("assets/sec-5/lite2d-editor-demo.png"),
  caption: [lite2d-editor에 변환된 Live2D 데모 모델 로드],
  placement: top,
) <fig-lite2d-editor-demo>

이에 @fig-lite2d-editor-demo 와 같이, 자체적인 렌더링 설정 조정 도구로서 에디터 본체인 lite2d-editor와 에디터의 UI시스템 lite2d-editor-ui를 작성하였다. 이들 도구를 사용하여, 데모 캐릭터의 각 부분이 올바른 순서로 렌더링되는지를 실시간으로 확인하면서 설정 값을 조정할 수 있었다.

lite2d-editor는 렌더링 데이터를 시각화하는 것 뿐 아니라 렌더링 설정 값을 조정해야 하므로, 편의성 측면에서 일종의 GUI 편집기로서 동작하여야 했다. 이러한 배경에서, 포토샵과 파워포인트와 비슷한 그래픽 툴의 동작을 다소 모방하도록 작성하게 되었다. 마우스 휠 클릭으로 화면을 드래그하면 렌더링 화면이 평행 이동하거나, 레이어 순서의 조정 시 표시 반영, 각 레이어의 렌더 결과를 미리보기에서 클릭하였을 때 실제로 이들 레이어가 선택되는 등의 그래픽 도구로서의 기능을 구현하였다.

lite2d-editor가 GUI 그래픽 툴로서 고도화되면서, 코드베이스는 UI 시스템 구현과 그래픽 툴 구현이 혼재되어 작업을 더 이어나가기 어려울 정도가 되었다. 이에 대응하여 UI 시스템을 lite2d-editor-ui로서 분리하여 일반 GUI 프로그램의 UI 시스템으로 사용 가능한 수준으로 모듈화한 다음, 이를 lite2d-editor가 로드하는 방식으로 처리하였다.

#figure(
  image("assets/sec-5/mao_texture_00.png", width: 80%),
  caption: [데모 캐릭터 Mao의 텍스쳐 아틀라스],
  placement: top,
) <fig-mao-texture-atlas>

캐릭터 모델은 @fig-mao-texture-atlas 와 같이 각 파트들을 한 데 모아 하나의 큰 텍스쳐 아틀라스로 다루고 있다. 프로그램에 의해 병합 처리, 자동 생성된 아틀라스에서 수동으로 각 파트를 올바르게 잘라내어 인덱스하는 작업으로는 주어진 기간 안에 수행하기에는 소모적이라고 판단, 아틀라스 인덱스 데이터를 moc3에서 불러오는 도구로서 moc32json을 작성해 사용하였다.

== 추가 정보: Cubism Native Framework에 의존하지 않는 자체 엔진 라이브러리

cubism_vtuber를 구현하기 전, Cubism Native Framework에 의존하지 않는 자체적인 렌더링 엔진의 작성을 시도하였다. 이 엔진은 liblite2d로 패키지하여 Vtuber 시스템의 렌더링 엔진으로 사용하려고 했다. liblite2d는 캐릭터 렌더링에 요구되는 Mesh 계산, 셰이딩, 텍스쳐 로드, 모델 로드 처리를 수행하도록 구현하였다.  

하지만 캐릭터 각 부분의 연결을 적절히 유지하면서 그래픽을 변형하는 방법을 찾지 못했다. 항상 얼굴에 부착된 상태가 유지되는 입과 눈의 조작은 용이했으나, 고개를 회전하거나 목을 위로 빼는 동작에서는 얼굴이 분리되는 문제가 있었다.

구현에 사용한 그래픽 라이브러리는 이번 과제에서 처음 사용해보았기 때문에, 기간 내에 이 문제를 해결하지 못할 것으로 전망되었다. 이에 따라 #underline[#link("https://github.com/shapelayer/lite2d")]의 lite2d 디렉토리에 이들 렌더링 엔진을 아카이브하고, Cubism Native Framework에 의존하는 cubism_vtuber를 구현하는 것으로 과제 수행 방향을 변경하였다.

= 본 보고서를 목적으로 작성한 구현체

\

*fftj-kt*

@sec-1 에서 주파수 스펙트럼을 왜곡해 가려진 스펙트럼을 드러내기 위해 fftj를 변형 구현하였다.

#url("https://github.com/shapelayer/fftj-kt")

\

*spotdiff-py*

@sec-3 에서 틀린그림 찾기 문제를 컴퓨터로 자동 해결하기 위한 알고리즘의 개념증명으로서 구현하였다.

#url("https://github.com/shapelayer/spotdiff-py")

\

*cubism_vtuber*, *lite2d-editor*, *lite2d-editor-ui*, *moc32json*

@sec-5 에서 카메라 속 얼굴 표정과 얼굴 방향에 맞춰 2D 캐릭터 모델의 표정과 시선 방향을 변화시키는 Vtuber 시스템의 구현을 위해 작성하였다.

#url("https://github.com/shapelayer/cubism-sdk-realtime-facial-representation")

#url("https://github.com/shapelayer/lite2d")

/**
 * References
 */

#set page(columns: 1)
#bibliography("refs.bib", title: [References], full: true)
