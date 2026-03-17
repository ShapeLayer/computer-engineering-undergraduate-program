/**
 * このファイルをコンパイルするローカル環境では、
 * 下記で変数 `sans`、`serif`、`mono` として定義しているフォントファイルを
 * インストールしておく必要があります。
 *
 * フォントファイルは ./assets/fonts/ に配置します。
 * コンパイラや言語サーバーに対して特にフォントを適用する必要がある場合は、
 * そのパスを参照してください。
 *
 * 例:
 * .vscode/settings.json
 * ```json
 * {
 *   "tinymist.fontPaths": [
 *     "./assets/fonts/"
 *   ]
 * }
 *
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
      #align(left)[画像情報処理 レポート課題]
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
    Jonghyeon PARK,
    理工学部 特別聴講学生\
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
  [〈画像情報処理〉レポート課題],
  []
)

#outline(title: [概要])

\

= 課題 \#1: 画像のパワー／振幅スペクトル <sec-1>

== スペクトルの算出

#origin-quote[
  NIH ImageJ とプラグイン FFTJ を用いて、次のようなさまざまな画像に対し 2 次元 FFT を実行し、DC 成分を中心へ移動させるためのシフト（Shift）処理を行ったうえで、パワースペクトルまたは振幅スペクトル（2 次元画像の形）を求めなさい。（Teams に画像ファイルが用意されています。）
]

=== 縞の向きは同じで間隔が異なる画像 <sec-diff-gap>

#grid(
  columns: 3,
  inset: .3em,
  align: center,

  grid.cell(align: horizon, rowspan:2, [#figure(image("assets/sec-1/stripe_interval/Yokoshima1.png", width: 100%), caption: [間隔の広い横縞画像])<fig-yokoshima1>]),
  [#figure(image("assets/sec-1/stripe_interval/yokoshima1 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima1 の振幅スペクトル])<fig-yokoshima1-f>],
  [#figure(image("assets/sec-1/stripe_interval/(centercrop) yokoshima1 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima1 の振幅スペクトル（中心拡大）])<fig-yokoshima1-fc>],
  [#figure(image("assets/sec-1/stripe_interval/yokoshima1 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima1 のパワースペクトル])<fig-yokoshima1-p>],
  [#figure(image("assets/sec-1/stripe_interval/(centercrop) yokoshima1 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima1 のパワースペクトル（中心拡大）])<fig-yokoshima1-pc>],
)

#grid(
  columns: 3,
  inset: .3em,
  align: center,
  grid.cell(align: horizon, rowspan:2, [#figure(image("assets/sec-1/stripe_interval/Yokoshima2.png", width: 100%), caption: [中間の間隔の横縞画像])<fig-yokoshima2>]),
  [#figure(image("assets/sec-1/stripe_interval/yokoshima2 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima2 の振幅スペクトル])<fig-yokoshima2-f>],
  [#figure(image("assets/sec-1/stripe_interval/(centercrop) yokoshima2 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima2 の振幅スペクトル（中心拡大）])<fig-yokoshima2-fc>],
  [#figure(image("assets/sec-1/stripe_interval/yokoshima2 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima2 のパワースペクトル])<fig-yokoshima2-p>],
  [#figure(image("assets/sec-1/stripe_interval/(centercrop) yokoshima2 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima2 のパワースペクトル（中心拡大）])<fig-yokoshima2-pc>],
)

#grid(
  columns: 3,
  inset: .3em,
  align: center,
  grid.cell(align: horizon, rowspan:2, [#figure(image("assets/sec-1/stripe_interval/Yokoshima3.png", width: 100%), caption: [間隔の狭い横縞画像])<fig-yokoshima3>]),
  [#figure(image("assets/sec-1/stripe_interval/yokoshima3 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima3 の振幅スペクトル])<fig-yokoshima3-f>],
  [#figure(image("assets/sec-1/stripe_interval/(centercrop) yokoshima3 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima3 の振幅スペクトル（中心拡大）])<fig-yokoshima3-fc>],
  [#figure(image("assets/sec-1/stripe_interval/yokoshima3 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima3 のパワースペクトル])<fig-yokoshima3-p>],
  [#figure(image("assets/sec-1/stripe_interval/(centercrop) yokoshima3 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima3 のパワースペクトル（中心拡大）])<fig-yokoshima3-pc>],
)

=== 縞の向きが異なる画像 <sec-diff-dir>

#grid(
  columns: 3,
  inset: .3em,
  align: center,
  grid.cell(align: horizon, rowspan:2, [#figure(image("assets/sec-1/stripe_direction/Tateshima2.png", width: 100%), caption: [縦縞画像])<fig-tateshima2>]),
  [#figure(image("assets/sec-1/stripe_direction/tateshima2 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-tateshima2 の振幅スペクトル])<fig-tateshima2-f>],
  [#figure(image("assets/sec-1/stripe_direction/(centercrop) tateshima2 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-tateshima2 の振幅スペクトル（中心拡大）])<fig-tateshima2-fc>],
  [#figure(image("assets/sec-1/stripe_direction/tateshima2 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-tateshima2 のパワースペクトル])<fig-tateshima2-p>],
  [#figure(image("assets/sec-1/stripe_direction/(centercrop) tateshima2 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-tateshima2 のパワースペクトル（中心拡大）])<fig-tateshima2-pc>],
)

#grid(
  columns: 3,
  inset: .3em,
  align: center,
  grid.cell(align: horizon, rowspan:2, [#figure(image("assets/sec-1/stripe_interval/Yokoshima2.png", width: 100%), caption: [横縞画像])<fig-yokoshima2a>]),
  [#figure(image("assets/sec-1/stripe_interval/yokoshima2 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima2a の振幅スペクトル])<fig-yokoshima2a-f>],
  [#figure(image("assets/sec-1/stripe_interval/(centercrop) yokoshima2 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima2a の振幅スペクトル（中心拡大）])<fig-yokoshima2a-fc>],
  [#figure(image("assets/sec-1/stripe_interval/yokoshima2 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima2a のパワースペクトル])<fig-yokoshima2a-p>],
  [#figure(image("assets/sec-1/stripe_interval/(centercrop) yokoshima2 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-yokoshima2a のパワースペクトル（中心拡大）])<fig-yokoshima2a-pc>],
)

#grid(
  columns: 3,
  inset: .3em,
  align: center,
  grid.cell(align: horizon, rowspan:2, [#figure(image("assets/sec-1/stripe_direction/Nanameshima2A.png", width: 100%), caption: [@fig-tateshima2 を反時計回りに $45 degree$ 回転])<fig-naneshima2a>]),
  [#figure(image("assets/sec-1/stripe_direction/nanameshima2a Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-naneshima2a の振幅スペクトル])<fig-naneshima2a-f>],
  [#figure(image("assets/sec-1/stripe_direction/(centercrop) nanameshima2a Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-naneshima2a の振幅スペクトル（中心拡大）])<fig-naneshima2a-fc>],
  [#figure(image("assets/sec-1/stripe_direction/nanameshima2a Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-naneshima2a のパワースペクトル])<fig-naneshima2a-p>],
  [#figure(image("assets/sec-1/stripe_direction/(centercrop) nanameshima2a Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-naneshima2a のパワースペクトル（中心拡大）])<fig-naneshima2a-pc>],
)

#grid(
  columns: 3,
  inset: .3em,
  align: center,
  grid.cell(align: horizon, rowspan:2, [#figure(image("assets/sec-1/stripe_direction/Nanameshima2B.png", width: 100%), caption: [@fig-tateshima2 を時計回りに $45 degree$ 回転])<fig-naneshima2b>]),
  [#figure(image("assets/sec-1/stripe_direction/nanameshima2b Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-naneshima2b の振幅スペクトル])<fig-naneshima2b-f>],
  [#figure(image("assets/sec-1/stripe_direction/(centercrop) nanameshima2b Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-naneshima2b の振幅スペクトル（中心拡大）])<fig-naneshima2b-fc>],
  [#figure(image("assets/sec-1/stripe_direction/nanameshima2b Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-naneshima2b のパワースペクトル])<fig-naneshima2b-p>],
  [#figure(image("assets/sec-1/stripe_direction/(centercrop) nanameshima2b Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-naneshima2b のパワースペクトル（中心拡大）])<fig-naneshima2b-pc>],
)

=== 平均値が異なる画像 <sec-diff-avg>

#grid(
  columns: 3,
  inset: .3em,
  align: center,
  grid.cell(align: horizon, rowspan:2, [#figure(image("assets/sec-1/different_average/Average25percent.png", width: 100%), caption: [白黒比が 3:1 の画像])<fig-avg25>]),
  [#figure(image("assets/sec-1/different_average/avg25 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg25 の振幅スペクトル])<fig-avg25-f>],
  [#figure(image("assets/sec-1/different_average/(centercrop) avg25 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg25 の振幅スペクトル（中心拡大）])<fig-avg25-fc>],
  [#figure(image("assets/sec-1/different_average/avg25 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg25 のパワースペクトル])<fig-avg25-p>],
  [#figure(image("assets/sec-1/different_average/(centercrop) avg25 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg25 のパワースペクトル（中心拡大）])<fig-avg25-pc>],
)

#grid(
  columns: 3,
  inset: .3em,
  align: center,
  grid.cell(align: horizon, rowspan:2, [#figure(image("assets/sec-1/different_average/Average50percent.png", width: 100%), caption: [白黒比が 1:1 の画像])<fig-avg50>]),
  [#figure(image("assets/sec-1/different_average/avg50 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg50 の振幅スペクトル])<fig-avg50-f>],
  [#figure(image("assets/sec-1/different_average/(centercrop) avg50 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg50 の振幅スペクトル（中心拡大）])<fig-avg50-fc>],
  [#figure(image("assets/sec-1/different_average/avg50 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg50 のパワースペクトル])<fig-avg50-p>],
  [#figure(image("assets/sec-1/different_average/(centercrop) avg50 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg50 のパワースペクトル（中心拡大）])<fig-avg50-pc>],
)

#grid(
  columns: 3,
  inset: .3em,
  align: center,
  grid.cell(align: horizon, rowspan:2, [#figure(image("assets/sec-1/different_average/Average75percent.png", width: 100%), caption: [白黒比が 1:3 の画像])<fig-avg75>]),
  [#figure(image("assets/sec-1/different_average/avg75 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg75 の振幅スペクトル])<fig-avg75-f>],
  [#figure(image("assets/sec-1/different_average/(centercrop) avg75 Frequency Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg75 の振幅スペクトル（中心拡大）])<fig-avg75-fc>],
  [#figure(image("assets/sec-1/different_average/avg75 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg75 のパワースペクトル])<fig-avg75-p>],
  [#figure(image("assets/sec-1/different_average/(centercrop) avg75 Power Spectrum (logarithmic) With Origin At Volume-Center (Single Precision).png", width: 100%), caption: [@fig-avg75 のパワースペクトル（中心拡大）])<fig-avg75-pc>],
)

== スペクトルの解釈

#origin-quote[
  振幅スペクトルまたはパワースペクトル画像の各部分が何を表現しているのかを(1)の処理結果に基づいて説明しなさい。

  ① スペクトル中心（原点） \
  ② 原点に近いエリア \
  ③ 原点から遠いエリア \ 
  ④ 原点からの方向 \
]

1. スペクトル中心（原点）：DC成分（直流成分）

  #figure(
    $
    F(0,0) = sum_(x,y) f(x,y)
    $,
    caption: [DC成分の定義]
  )

  2次元離散フーリエ変換の定義に従い、スペクトルの中心は周波数が $(0, 0)$ の地点である。@sec-diff-avg 〈平均値が異なる画像の処理〉の結果から、振幅スペクトルの中心値は画像の平均輝度に対応することが確認できる。

  #figure($
    I_"avg25" &= 255 dot 0.25 = 63.75 \
    I_"avg50" &= 255 dot 0.50 = 127.5 \
    I_"avg75" &= 255 dot 0.75 = 191.25
  $,
  caption: [@fig-avg25, @fig-avg50, @fig-avg75 の中央ピクセル輝度 $I_"avg25"$, $I_"avg50"$, $I_"avg75"$ の期待値])<expr-avg>

  したがって、輝度0：輝度255の比率が 3:1 の画像 @fig-avg25、2:2 の画像 @fig-avg50、1:3 の画像 @fig-avg75 の中央ピクセル輝度 $I_"avg25"$, $I_"avg50"$, $I_"avg75"$ それぞれに対し、@expr-avg のように計算され、$I_"avg25" = 63.75$, $I_"avg50" = 127.5$, $I_"avg75" = 191.25$ となることが期待される。

  #grid(
    [#figure(image("assets/sec-1/different_average/center-fft-25p.png", width: 100%),
      caption: [輝度比 3:1 の画像 @fig-avg25 のFFT処理後の中央ピクセル輝度]
    )<fig-center-fft-25p>],
    [#figure(image("assets/sec-1/different_average/center-fft-50p.png", width: 100%),
      caption: [輝度比 2:2 の画像 @fig-avg50 のFFT処理後の中央ピクセル輝度]
    )<fig-center-fft-50p>],
    [#figure(image("assets/sec-1/different_average/center-fft-75p.png", width: 100%),
      caption: [輝度比 1:3 の画像 @fig-avg75 のFFT処理後の中央ピクセル輝度]
    )<fig-center-fft-75p>],
  )


  FFT処理を経た @fig-avg25 @fig-avg50 @fig-avg75 の中央ピクセルをImageJを用いて実際に測定した結果、@fig-center-fft-25p, @fig-center-fft-50p, @fig-center-fft-75p のように $I_"avg25"$, $I_"avg50"$, $I_"avg75"$ の期待値の計算 @expr-avg と一致することが分かった。
  
2. 原点に近いエリア：低周波成分 (Low Frequency components)

  画像内で輝度変化が緩やかに起こる部分を表現する。画像の背景、大きな形態、滑らかな明暗変化などがこの領域に現れる。
  
  @sec-diff-gap 〈縞の間隔が異なる画像〉の @fig-yokoshima1 「広間隔の横縞画像」は空間領域での変化が緩やかであるため、スペクトル上で中心（原点）に比較的近い位置に明るい点（ピーク）が現れる。

3. 原点から遠い領域: 高周波成分（High Frequency components）

  画像において輝度が急激に変化する部分を表す。物体の輪郭（Edge）、微細なテクスチャ（Texture）、ノイズなどがこの領域に現れる。

  @sec-diff-gap〈縞の向きは同じで間隔が異なる画像〉の「間隔の広い横縞画像」（@fig-yokoshima1）、「中間の間隔の横縞画像」（@fig-yokoshima2）、「間隔の狭い横縞画像」（@fig-yokoshima3）を比較すると、縞の間隔が狭くなるほどスペクトル上で原点からより離れた領域にピークが形成されることが確認できる。

  すなわち、空間周波数が高くなるほど DC 成分からより離れた領域にピークが形成された。

  \

  一方で、間隔の狭い横縞画像（@fig-yokoshima3）は輝度変化が頻繁で理論的には高周波領域にピークが形成されるはずであるにもかかわらず、@fig-yokoshima3-f などの可視化結果では DC 成分の過度な強度によりピークが明確に現れなかった。

  #figure(grid(
      columns: (1fr, 1fr),
      gutter: .5em,
      align(right, image("assets/sec-1/stripe_interval/yokoshima3 FREQUENCY_SPECTRUM_LOG With Origin AT_CENTER (DOUBLE) origin.png", width: 70%)),
      align(left, image("assets/sec-1/stripe_interval/(crop) FREQUENCY_SPECTRUM_LOG With Origin AT_CENTER (DOUBLE) log.png", width: 70%)),
    ),
    caption: [
      修正した計算式 @fftj-amplified により確認可能な @fig-yokoshima3 の周波数スペクトル（左）および中心拡大（右）
    ]
  ) <fig-yokoshima3-f-amplified>

  その後 @amplify-high-freq で述べる方法によりピークを可視化した結果、@fig-yokoshima3-f-amplified のような形を確認できた。

  @fig-yokoshima3 もこれまでの傾向と同様に、周波数スペクトルが異なる 2 つの画像 @fig-yokoshima1 @fig-yokoshima2 より中心からさらに離れており、ピーク間隔も疎に配置されるという一貫した傾向を確認できた。

4. 原点からの方向: 空間領域におけるパターンの方向性（Orientation）

  スペクトル画像において原点から特定方向へ伸びる成分は、その方向と直交（垂直）する方向に並ぶ空間領域のパターンを意味する。

  @sec-diff-dir〈縞の向きが異なる画像〉の @fig-yokoshima2a「横縞画像」は垂直方向に輝度変化が起こるため、可視化されたスペクトル @fig-yokoshima2a-f @fig-yokoshima2a-fc @fig-yokoshima2a-p @fig-yokoshima2a-pc では垂直線上にピークが形成された。

  空間領域での回転はフーリエ領域でも同じ回転として現れる。@fig-tateshima2「縦縞画像」のスペクトル（@fig-tateshima2-f など）は周波数成分が水平軸に分布する一方、これを $45 degree$ 回転させた @fig-naneshima2a および @fig-naneshima2b のスペクトル（@fig-naneshima2a-f など）は、原点を中心としてピーク位置が同様に $45 degree$ 回転して現れる。

=== 周波数スペクトルの歪みを利用した、隠れた周波数スペクトルの確認 <amplify-high-freq>

@fig-yokoshima3-f などのように極めて密な縞画像で周波数スペクトルが適切に表示されない状況について、追加調査を行った。

調査の結果、一般に高密度の縞の周波数成分を解釈する際には、デジタルサンプリングの限界であるナイキスト周波数（Nyquist Frequency）を考慮すべきであることが分かった。@gatan-nyquist-freq
デジタル画像で 1 周期を表現するには最低 2 ピクセルが必要であるため、縞間隔がこれに近づくほど周波数成分はスペクトル最外周に位置し、識別が困難になる。特に間隔が 2 ピクセル未満の場合、エイリアシングによるピーク歪みが発生しうる。

ただし本実験では、@fig-yokoshima3 のピークが明確に現れなかった原因はナイキスト限界に直接起因するというより、DC 成分の過度な強度と限られたダイナミックレンジにより高周波ピークが視覚的に隠れたためだと判断した。

これに対して FFTJ の基本計算式 @fftj-origin を修正し、原点からの正規化距離 $d_"norm"$、抑制半径 $R_"sup"$、最小倍率 $g_"min"$、重み回復の曲率 $gamma$、および上位 $n_t%$ 強度 $P_"target" (n_t)$ を導入した @fftj-amplified を用いた。#footnote[変形計算式 @fftj-amplified の実装については #underline[#link("https://github.com/ShapeLayer/fftj-kt")] で確認できる。]<fn-fftj-kt>

$W(d_"norm")$ は低周波を抑制するための重み、$M_"processed"$ は加工後データの大きさを意図して導入した。本課題では $R_"sup"=0.12$, $g_"min"=0.1$, $gamma=1.8$, $n_t=99.5$ を使用した。

#figure(
  $
  |F(u, v)| = sqrt(R(u, v)^2 + I(u, v)^2)\
  P_"linear" (u, v) = "clamp" ( |F(u, v)| dot frac(255, M_"max"), 0, 255 )
  $,
  caption: [FFTJ で使用した計算式]
) <fftj-origin>

#figure(
  $
  // 1. 低周波抑制の重み関数
  W(d_"norm") = cases(
    g_"min" + (1 - g_"min") dot (d_"norm" / R_"sup")^gamma & "if " d_"norm" < R_"sup",
    1 & "if " d_"norm" >= R_"sup"
  )

  \

  // 2. 加工後の大きさデータ
  M_"processed" (u, v) = ln(1 + |F(u, v)|) dot W(d_"norm")

  \

  // 3. パーセンタイルに基づく正規化（M_min は M_processed の最小値と仮定）
  P(u, v) = "clamp"((M_"processed" (u, v) - M_"min") / (P_"target" (n_t) - M_"min") dot 255, 0, 255)
  $,
  caption: [修正した計算式@fn-fftj-kt]
) <fftj-amplified>

= 課題 \#2: 画像フィルタ

== 課題 \#2 に用いる画像の前処理

#origin-quote[グレースケール画像を作成またはダウンロード等で準備（ＵＲＬ明記）しなさい。なお、作成する画像は、(4)で特徴抽出を行った際に、その効果がわかるものにすること。 ]

画像は自分で撮影した写真 @sec2-input の RGB チャンネルを分離し、グリーンチャンネルを使用した。

#figure(
  image("assets/sec-2/sec2-input.jpeg", width: 60%),
  caption: [
    課題 \#2 に使用する画像の原本
  ],
  placement: top
) <sec2-input>

#grid(
  columns: 3,
  gutter: .5em,
  figure(
    image("assets/sec-2/sec2-input.jpg (red).jpeg"),
    caption: [@sec2-input のレッドチャンネル]
  ),
  [#figure(
    image("assets/sec-2/sec2-input.jpg (green).jpeg"),
    caption: [@sec2-input のグリーンチャンネル]
  ) <sec2-input-green>],
  figure(
    image("assets/sec-2/sec2-input.jpg (blue).jpeg"),
    caption: [@sec2-input のブルーチャンネル]
  )
)

== Shape (3, 3) のエンボスフィルタ <sec-shape-3-3-emboss>

#origin-quote[授業の中で出てきたものやインターネット等を調べて、「ある特定の効果がある」フィルタ長３×３の空間フィルタを一つ選び、そのフィルタ係数と予想される効果を記述しなさい。 ]

本課題では「エンボスフィルタ（Emboss Filter）」を使用した。

このフィルタは画像に浮き彫り効果を適用して立体感を付与する。一方の方向の輪郭は明るく、反対側は暗く処理し、光が一方向から当たっているような 3D 効果を作る。@aspose-emboss-filter

#figure(
  $
    k = mat(
      delim: "[",
      -2, -1,  0;
      -1,  1,  1;
       0,  1,  2;
    )
  $,
  caption: [$3 times 3$ エンボスフィルタの定義]
) <eq-emboss-filter>

\

*フィルタ要素値の対称性*

フィルタ $k$ は中心を基準として左上が負（$-2$, $-1$）、右下が正（$1$, $2$）で構成されている。

これは画像全体にわたり左上側の輝度を下げて影を形成し、右下側の輝度を上げてハイライトを形成する。その結果、左上から右下へ光を当てるような効果が現れる。

言い換えると、$k$ 行列の要素を回転させればエンボス効果の方向性を調整できる。

\

*係数の和*

フィルタ $k$ の全要素を合計すると $sum k= -2 -1 + 0 - 1 + 1 + 1 + 0 +1 + 2 = 1$ である。これら係数の和は画像全体の平均輝度を表す。

$sum k = 1$ の場合は画像全体の平均輝度が原本に近い形で維持され、$sum k > 1$ ならより明るく、$sum k < 1$ ならより暗くなる。

特記事項として、$sum k = 0$ のフィルタは背景が黒くなり輪郭のみが現れるため輪郭抽出に用いられ、$sum k$ が $[0, 2]$ の範囲を外れると多くの情報が黒（$(-infinity, 0)$）または白（$(2, infinity)$）として失われる。

\

*各重みの強度*

フィルタは中心画素を基準に隣接画素の輝度に対して計算できる。$k$ の左上値 $-2$ と右下値 $2$ について、中心画素の左上画素の輝度 $b_p_1$ と右下画素の輝度 $b_p_2$ が等しければ、$-2 dot b_p_1 + 2 dot b_p_2 = 0$ となり、輝度変化のない平坦な点として処理される。

#figure(
  image("assets/sec-2/fig-emboss-filter-visualize.png"),
  caption: [エンボスフィルタ $k$（@eq-emboss-filter）について、各要素の位置を $x$, $y$、要素値を $z$ として可視化],
  placement: top,
)<fig-emboss-filter>

@fig-emboss-filter のように、フィルタ $k$ は重み差によって画像上に仮想的な勾配を形成する。このフィルタは左上から右下方向へ数値が高くなる構造を持つことで、その方向に沿って発生する輝度変化を検出し、立体的な斜面を作り出す。

このとき、フィルタ中心から遠い外周要素に絶対値の大きい重みを配置するほど画素変化量はより敏感に反映される。中心軸から距離の遠い画素間の輝度差に高い倍率を適用し、微小な濃淡差であっても数値的に大きく増幅するためである。結果として、重みが強く中心から遠いほど輪郭はより鋭くなり、出力のコントラストが最大化され、視覚的に深みのあるエンボス効果が得られる。

\

*フィルタ要素内の各重みが中心からさらに遠くなる場合*

しかし、中心からより遠ざけるためにフィルタサイズを大きくすると、輪郭が鋭くなるのとは逆の作用が起こりうる。

$5 times 5$, $7 times 7$ などより大きいフィルタは、より離れた画素を比較に用いるため、結果に現れる仮想的な斜面はより厚く緩やかに形成される。

小さいフィルタは画素一つ一つの変化に敏感で、画像内の微小ノイズさえ鋭い変化として認識し、結果を粗くする。一方、大きいフィルタは広い範囲の輝度変化を平均的に反映するため局所ノイズの影響は減り、全体の陰影の流れがより滑らかに表現されると同時に、ぼけ（ブラー）を伴う可能性がある。

== エンボスフィルタの周波数振幅スペクトル

#origin-quote[(2)のフィルタの２次元離散Fourier変換を行い、周波数振幅スペクトルを計算しなさい。なお、計算は手計算でもPythonでもよい。]

\

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

エンボスフィルタ $k$ に対する周波数振幅スペクトル $S$ は次のとおりである:

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
  caption: [$k$ に対する周波数スペクトル $S$ の算出]
)

== エンボスフィルタの適用結果

#figure(
  grid(
    columns: 2,
    gutter: 1em,
    image("assets/sec-2/sec2-input.jpg (green).jpeg", width: 80%),
    image("assets/sec-2/sec2-input.jpg (green) convolved.jpeg", width: 80%),
  ),
  caption: [
    @sec2-input-green（左）とフィルタ $k$ を適用した結果画像（右）
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
  caption: [@sec-emboss-k-applied-grid の拡大],
  placement: top
)<sec-emboss-k-applied-grid-center-cropped>

#origin-quote[NIH ImageJのConvolveフィルタを用いて、(2)のフィルタと(1)の画像との畳み込み(積分)計算を行い、結果の画像を示すとともに、結果画像のどこに(2)で予想した効果が現れているかどうかについて考察しなさい。]

@sec-emboss-k-applied-grid および @sec-emboss-k-applied-grid-center-cropped から分かるように、エンボスフィルタ $k$ を @sec2-input-green と畳み込み演算した結果、画素変化が際立つ浮き彫り（レリーフ）効果が画像に適用された。

続いて、@sec-shape-3-3-emboss で議論した内容が実際と一致するかを確認するため、次のように変形フィルタを定義して畳み込み演算を行った。

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
    $k$ を中心に関して反転したフィルタ $k_r$\
    $k$ の重みをさらに大きくしたフィルタ $k_p$\
    $k$ と同様の処理を行いながらサイズを大きくしたフィルタ $k_b$
  ]
)

\

*エンボスフィルタ $k$ と、原点対称のフィルタ $k_r$*

#grid(
  columns: 3,
  align: center + horizon,
  inset: (x: .3em, y: .5em),
  [#figure(image("assets/sec-2/sec2-input-green-cropped.jpeg"), caption: [原本])],
  [#figure(image("assets/sec-2/sec2-input-green-cropped-convolved.jpeg"), caption: [$k$ 適用])<input-green-k-kr-crop>],
  [#figure(image("assets/sec-2/input-green-cropped-k_r.jpeg"), caption: [$k_r$ 適用])<input-green-kr-crop>],
)

エンボスフィルタ $k$ および原点対称のフィルタ $k_r$ を画像に適用した結果、原本画像における画素のエッジが際立って現れた。フィルタ要素値を原点対称にしたことも結果に反映され、@input-green-k-kr-crop のエッジ表現と @input-green-kr-crop のエッジ表現が逆に現れることを確認できた。

\

*重みを大きくしたフィルタ $k_p$ と、$5 times 5$ フィルタ $k_b$*

#grid(
  columns: 3,
  align: center + horizon,
  inset: (x: .3em, y: .5em),
  [#figure(image("assets/sec-2/sec2-input-green-cropped-convolved.jpeg"), caption: [$k$ 適用])<input-green-k-kpb-crop>],
  [#figure(image("assets/sec-2/input-green-cropped-k_p.jpeg"), caption: [$k_p$ 適用])<input-green-kp-crop>],
  [#figure(image("assets/sec-2/input-green-cropped-k_b.jpeg"), caption: [$k_b$ 適用])<input-green-kb-crop>],
)

エンボスフィルタ $k$ の各値を任意に増幅したフィルタ $k_p$ を画像に適用した結果（@input-green-kp-crop）では、@input-green-k-kpb-crop と比べて画素変化がさらに際立ち、粗く表現されていることを確認できた。

@sec-shape-3-3-emboss における推測と実際の結果が異なった例は、フィルタ $k_b$ を適用した @input-green-kb-crop であった。@input-green-kb-crop では局所ノイズの影響が減り全体の陰影の流れがより滑らかに表現されると推測したが、適用結果の中で最も粗い表面テクスチャが表現されている。

これは入力画像の特徴が原因だと考えられる。画像内でテクスチャを形成する画素変化間の距離が $5 times 5$ サイズのフィルタ $k_b$ が減衰させるには十分に密ではなく、むしろ当該フィルタサイズが局所ノイズ成分を強調する逆効果を生んだと分析される。

@sec-shape-3-3-emboss の推測のような滑らかな陰影の流れとノイズ抑制効果を得るには、$5 times 5$ を上回るさらに大きなサイズのフィルタを適用する必要があると考えられる。

/*
#grid(
  columns: 3,
  align: center + horizon,
  inset: (x: .3em, y: .5em),
  grid.cell(rowspan: 2, figure(image("assets/sec-2/sec2-input-green-cropped.jpeg"), caption: [原本])),
  figure(image("assets/sec-2/sec2-input-green-cropped-convolved.jpeg"), caption: [$k$ 適用]),
  figure(image("assets/sec-2/input-green-cropped-k_r.jpeg"), caption: [$k_r$ 適用]),
  figure(image("assets/sec-2/input-green-cropped-k_p.jpeg"), caption: [$k_p$ 適用]),
  figure(image("assets/sec-2/input-green-cropped-k_b.jpeg"), caption: [$k_b$ 適用]),
)
*/

= 課題 \#3: 間違い探し実装 <sec-3>

#origin-quote[
  次の図のような雑誌に掲載されていた間違い探し問題を、ディジカメやイメージスキャナでディジタル化し、コンピュータで自動的に解くにはどのような処理を行えば良いか、アルゴリズムを説明しなさい。

  - ディジカメで撮影した場合と、フラットベッドスキャナの場合で分けて説明すること
  - OpenCVなどの具体的な関数名ではなく、処理内容を記述すること
    - × : np.fft.fft2(A)を実行する
    - ○ : 画像Aに対して２次元FFTを実行する
  - 最後に必ず「相違箇所」を強調する処理を含めること
]

間違い探し問題をコンピュータで解くには、まず画像処理が容易になるように歪み等を補正し、整列させる必要がある。一連の補正・整列作業により入力画像の歪みを軽減した後、差が際立つ地点を算出し、間違い探しにおける誤り箇所と判断する。このように算出した地点は過度に小さく局所的であったり、個々の領域が近接または重なっている可能性がある。個々の領域が過度に小さい場合はノイズと判断して誤り箇所から除去し、互いに非常に近い、または重なっている領域は 1 つの大きな領域に統合する。

上記の一連の処理について、具体的な実装差があったとしても、処理の大枠としてはこの流れから逸脱しないと考えられる。

\

#place(
  top,
  float: true,
  scope: "parent",
  clearance: 15pt,
)[
  #figure(
    image("assets/sec-3/spotdiff-py-pipeline.drawio.svg"),
    caption: [間違い探し処理器実装の処理パイプライン構成]
  ) <diagram-spotdiff-py-pipeline>
]

上記内容をもとに、@diagram-spotdiff-py-pipeline のような処理パイプラインを持つ間違い探し処理器を実装した。処理器の実装は Python と OpenCV を中心に記述した。本実装は入力に対して画像の歪みを補正し、前処理して整列した後、差分を算出して相違点を抽出する。これらの過程の途中では、入力画像または中間結果に含まれるノイズや不要データを除去する後処理が継続して実行される。

処理器は #underline[#link("https://github.com/shapelayer/spotdiff-py")] で確認できる。

== 画像前処理および正規化

画像処理の第一段階は、入力媒体の特性に合わせて解析に適した状態へデータを正規化することである。

\

*デジタルカメラを使用した場合*

デジタルカメラで撮影した場合、外部照明の影響により輝度の不均一や影が発生しやすい。多くの場合、このような色の歪みは重大には発生せず、輪郭検出などにも致命的ではないと判断したが、色歪み補正を省略した場合にどのような結果となるかの比較実験は行えなかった。

#figure(
  image("assets/sec-3/omikuji-color.jpeg"),
  caption: [
    デジタルカメラで撮影すると、緑でハイライトした部分のように影が形成されることが多い。
  ],
) <fig-omikuji-color>

色歪みを補正するにあたっては、画像の輝度成分を抽出し、局所的コントラストを改善する適応的ヒストグラム平坦化（CLAHE; Contrast Limited Adaptive Histogram Equalization）処理を行った。

#figure(
  [
    #image("assets/sec-3/histogram-eq.png")#image("assets/sec-3/histogram-eq-clahe.png")
  ],
  caption: [ヒストグラム平坦化（上）、CLAHE（下）（source: @opencv-python-kr-tutorial-histogram-eq）],
  placement: top
)

ヒストグラム平坦化は画像全体の輝度分布を一括で計算して広げるため、外部要因で形成された影を除去するのに有効だった。@opencv-python-kr-tutorial-histogram-eq
特記すべき点として、単純なヒストグラム平坦化は全体的に暗い／明るい画像のコントラストを上げるのには効果的だが、写真の片側が明るく他方が影になっている場合、明るい側は白飛びし、暗い側はノイズを過度に増幅して@geek-for-geeks-clahe 逆効果を生む恐れがあった。

\

*スキャナを使用した場合*

一方、フラットベッドスキャナを使用した場合は照明が比較的一定であるため、目立った処理を施す必要はないと判断した。

ただし、フラットベッドスキャナの結果にはデジタルカメラほどではないが、微細な埃や多少のノイズが混入する傾向が観察されたため、メディアンフィルタを用いて点ノイズを除去した。

== 画像整列および歪み補正

#figure(
  grid(
    columns: 2,
    image("assets/sec-3/omikuji-flatted.jpg"),
    image("assets/sec-3/omikuji-overlayed.jpg")
  ),
  caption: [
    @fig-omikuji-color の対象を歪みが少なくなるよう再撮影（左）\
    @fig-omikuji-color と左の画像を重ね合わせ（右）
  ]
) <fig-omikuji-flat-overlay>

異なる環境で取得された 2 枚の画像を画素単位で比較するには、2 枚の座標系を一致させる必要があった。特にデジタルカメラで対象を撮影した場合、同じ構図で撮影しても通常は @fig-omikuji-flat-overlay のように歪みが生じ、座標系の不一致が発生した。

\

これらの空間歪みを補正し入力画像の座標系を一致させるため、各画像の特徴点を検出して相互にマッチングした。このようにマッチングした特徴点情報を用いて変換行列を算出し、画像をワーピングして 2 枚の画像が同一座標系上で重なるように再配置した。

特徴点情報は ORB を用いて抽出し、Brute-Force Matcher を用いて対応付けを行った。@opencv-docs-feature-matching
マッチング中に誤対応した点は RANSAC アルゴリズムで除去し、残った点を用いて画像をワーピングした。@opencv-docs-feature-homography

#figure(
  image("assets/sec-3/camera-captured-monitor-procfailed.png", width: 60%),
  caption: [モニタ画面を撮影した画像を入力に用いた場合の整列失敗例],
) <fig-camera-captured-monitor-procfailed>

特記事項として、実装のテスト過程で入力画像を表示するモニタ画面をデジタルカメラで撮影して入力した例では、@fig-camera-captured-monitor-procfailed のように画像整列が失敗する現象を観察した。これはモニタ撮影時に生じる微細な格子模様が特徴点検出段階で多数検出され、それらが誤マッチングした結果だと考えられる。この問題を解決するには特徴点検出前にブラーを適用するなど追加の前処理が必要だと判断した。しかし、モニタ画面の撮影画像を入力とするシナリオは本実装にとって過酷であり、本課題要件にも提示されていないため、今後の改善課題として残すことにした。

== 差分抽出および後処理

差分抽出段階では、比較する 2 枚の画像に対し画素変化を算出・グループ化し、異なる領域を検出する。

画素変化には絶対差分を用いたが、デジタルカメラの入力ではソルト・ペッパーノイズが現れる例が報告されているため@alajlan2004detail@wikipedia-salt-and-pepper-noise、後処理としてメディアンブラーを用いて症状緩和を図った。@opencv-tutorial-py-filtering-salt-pepper

得られた差分マスクに二値化を適用し、誤り箇所候補領域の白黒マスクへ変換したうえで、モルフォロジーの閉処理を行い、これまでの処理過程で生じた小さな穴やノイズなどを整理するようにした。@opencv-forum-ignoring-background-in-binarization@opencv-tutorial-py-morphological-ops

この二値マスクは差分領域の輪郭抽出に用いた。輪郭抽出は Suzuki らの輪郭検出アルゴリズムで実装し@suzuki1985topological@opencv-docs-py-findcontours、検出された各オブジェクトを囲むバウンディングボックスを算出し、重複または隣接するバウンディングボックスを統合して誤り領域を確定した。

== 実験および結論

実装の性能把握のため、@wikimedia-jp-muband-machigai を改変せずに入力した。その結果は @fig-muband-spotdiff-result のとおりである。実装では偽陽性は発生しなかったが、全 15 個@wikimedia-jp-muband-machigai のうち 10 個のみを検出し、66.66% と高くない正答率を示した。

#figure(
  image("assets/sec-3/muband-spotdiff-result.png"),
  caption: [デジタルグラフィックに対する処理の試み（@wikimedia-jp-muband-machigai 使用; CC BY-SA 3.0）]
) <fig-muband-spotdiff-result>

検出できなかった変化は、「壁時計の針」「猫の後ろの皿に描かれた顔模様」「右下フレームにより切られた鉢植えの花の数」など、グラフィック上で比較的小さく描かれているものだった。これに基づき、ノイズ除去のためにパイプライン中間に挿入したフィルタや各処理が差分検出性能に悪影響を与えた可能性があると推定し設定を調整したが、顕著な改善は観察されなかった。

性能実験に用いた画像がカメラ撮影やフラットベッドスキャンではなくデジタルグラフィックの原本ファイルであることを踏まえると、実運用シナリオではさらに低い性能となる可能性がある。

パイプライン構成および設定には明確な改善課題が残るが、本課題の範囲内では抜本的改善は困難と判断し、今後の課題として残すことにした。

/*
 可視化に関する内容は結果写真の添付で簡単に記述
 */

= 課題 \#4: 画像処理応用システムの事例調査

#origin-quote[
  近年、画像を利用したシステムが多く利用されている。例を挙げると、 
  - 空港での顔認証による入出国審査 
  - サーモグラフィによる入国予定者の健康把握 
  - スマートフォンや銀行ATMでの指紋認証による本人確認 
  - アラウンドビューモニタを代表とする自動車周辺の俯瞰 
  など、様々な業種や用途で利用されているが、現在商品化されているこうしたシステムを１種類選択して、インターネット等を用いてしくみや長所、皆さんが考えられる問題点（短所）を説明しなさい。（参考にしたWebページのURLなどは必ず明記すること。明記せずに無断で引用した場合は著作権や版権の侵害になりますのでご注意ください。）
]

== 商用化された顔認証決済とその実装

#figure(
  image("assets/sec-4/sbs-toss-facial-payment.jpeg"),
  caption: [Toss の顔認証決済端末および顔認証決済 @sbs-toss-facial-payment (01:33)]
)

韓国のフィンテック企業である Toss は、韓国で顔認証決済を提供している。この決済方法はクレジットカードやスマートフォンなど他の本人確認手段を一切用いず、顔だけで個人を識別して決済を承認する。言い換えれば、個人の顔をキー、個別の身元情報を値とする一種のマッピングシステムを実装し商用化したものである。このシステムは「Toss Front」と名付けられた、Toss が開発・普及している専用決済端末によって実装された。

\

韓国では決済の大半にクレジットカードが用いられているにもかかわらず、広く普及しているカード決済端末が EMV のコンタクトレス（Contactless）規格に対応しておらず、「IC チップカードを差し込んで決済」する方法しか使えなかった。@dginclusion-emv-contactless
韓国の金融業界によれば、2025 年時点の韓国におけるコンタクトレス利用比率は 10% 未満と推定されている。@mt-emv-contactless

そのため、これら規格を利用する Apple Pay の加盟店も急増できず、日本の PayPay 決済に近い位置付けの韓国の「Naver Pay」「Kakao Pay」などの簡便決済サービスも、画面にバーコード／QR コードを表示して決済する方式を採用し、カメラやコードスキャナが設置された店舗でのみ利用可能だった。

このような背景のもと、Toss Front はコンタクトレス決済を追加し Apple Pay を利用可能な次世代決済端末として広く普及した。本端末は Android を OS として採用し、実質的に低スペックのスマートフォンと同等の仕様であり、洗練されたデザインと同社のプロモーション施策により韓国で広く普及するに至った。

Toss はこのように強い競争力をもって韓国の決済インフラに参入した後、既に端末に搭載されていたカメラハードウェアを利用して顔認証決済を商用化した。

#figure(
  text(size: .8em, table(
    columns: 2,
    align: horizon,
    [プロセッサ], [デュアルコア 2.4GHz + クアッドコア 1.9GHz],
    [OS], [Android 11#footnote[初回発売時点。現行と異なる可能性がある]],
    [メモリ], [3GB RAM],
    [ディスプレイ & タッチ], [7インチ LCD（1280x800）、静電容量式タッチ],
    [サウンド], [2W スピーカー],
    [カメラ], [RGB カメラ 5MP（2台）],
    [決済方式], [IC, MSR, NFC],
    [接続端子], [シリアルポート, USB-C, LAN],
    [無線通信], [Wi-Fi（2.4GHz, 5GHz）, 近距離無線通信（2.4GHz）, RFID],
    [認証], [EMV コンタクト L1/L2, コンタクトレス L1/L2, KC, 端末セキュリティ認証],
    [
      コンタクトレスカード\
      ブランド認証
    ], [Master（Paypass）, Visa（Paywave）, DPAS, JCB, CUP]
  )),
  caption: [Toss Front2 のハードウェア仕様@toss-oopy-toss-front2],
  placement: top,
) <table-toss-front2-spec>

== 想定される問題点、攻撃シナリオと対策

顔認証技術は、それのみに全面的に依存して決済を承認できるほどには、まだ信頼性が高くないという認識が一般に広く存在する。

\

赤外線ドットプロジェクタと 3 次元顔データ、さらに専用アクセラレータである Neural Engine まで動員して立体的な生体情報を解析する Apple の Face ID ですら、精巧に作られた 3D マスク@bkav-beats-face-id や、生物学的類似性が高い双子によって無効化された事例が報告されており@quora-my-twin-brother-can-easily-fool@tiktok-thegreen_twins-unlock-iphone、Apple も公式に「利用者に似た兄弟姉妹や双子、そして 13 歳未満の子どもの場合は認識エラーが発生する統計的確率が高い」と認めている。@apple-about-faceid

Toss の顔認証決済で用いられるカメラが一般的な RGB カメラであること、そして顔認証決済が Face ID のような真偽の二値分類ではなく多数ユーザの中から対象者を同定する分類問題であることを踏まえると、大衆がシステム失敗や金融事故の発生を懸念せざるを得ない。

\

こうした懸念を受けて、メディア（SBS）は当該顔認証決済システムにシステム失敗を誘発する実験をいくつか行った。@sbs-toss-facial-payment

\

*実験: 顔写真を紙に印刷*

#figure(
  image("assets/sec-4/sbs-fail-test-paper-printing.jpeg"),
  caption: [顔写真を紙に印刷して決済を試行 @sbs-toss-facial-payment (05:16)]
) <fig-sbs-fail-test-paper-printing>

@fig-sbs-fail-test-paper-printing のように顔写真を紙に印刷して決済を試みる方法では決済に成功しなかった。すべての端末にはカメラが 2 台搭載されており、Face ID の TrueDepth に類似して顔の奥行きを測定し、この種の攻撃を防いでいるように見える。

ただし、Face ID を成功裏に攻撃した 3D マスク攻撃については実験されていない。同社はリアルタイムの顔生体判定技術で 3D マスク攻撃を防ぐと述べているが@toss-facepay-press-en、具体的な技術仕様は公開されていない。@yozm-toss-facepay

\

*実験: マスクと帽子の着用*

#figure(
  image("assets/sec-4/sbs-fail-test-hide-with-mask.jpeg"),
  caption: [
    顔全体を医療用マスクで覆って決済を試行 @sbs-toss-facial-payment (07:59)\
    決済は承認されず、「眉と口がよく見えるようにしてください」という案内文が表示された。
  ],
)

ヘアスタイル、帽子、アクセサリーなど日常で変化しやすい部分については、初回登録以降に変化があっても同一人物であると判定できた。続く実験では、医療用マスクのように顔の 相当部分、あるいは全面を覆って顔認証処理ができない場合でなければ、決済が進行することが確認された。

\

*実験: 複数人が同時に決済を試みた場合*

#figure(
  image("assets/sec-4/sbs-fail-test-multiple-people.jpeg"),
  caption: [
    複数人が同時に決済を試行 @sbs-toss-facial-payment (09:57)
  ]
)

この実験は、複数人が同時に決済を試みる状況というより、混雑時に攻撃者が自分の後ろで順番待ちしている人物の顔で決済を試みるシナリオでの挙動把握を目的に実施された。

このように複数人が同時にカメラフレーム内に入った場合でも異常利用とは判断せず、フレーム内で最も顔が大きく写った人物を基準に認証処理を行った。

\

*システム失敗対策: 二要素認証*

#figure(
  image("assets/sec-4/sbs-fail-test-mfa.jpeg"),
  caption: [
    顔認証決済に二要素認証を設定した場合 @sbs-toss-facial-payment (10:36)\
    取引は即時承認されず、「私の番号を入力してください」という案内文が表示される。
  ],
)

本サービスが実装する顔認証決済の技術的本質は、端末ベースの生体認証（Biometric Authentication）というより、利用者の顔データをインデックスキー（Index Key）に置き換えて中央データベースから利用者情報を取得する「識別（Identification）」プロセスに重心がある。この技術的特性はマーケティング戦略にも一貫して現れており、生体認証手段として強調するより、クレジットカードやモバイル端末など物理媒体が不要なカードレス／フォンレス決済（Cardless/Phoneless Payment）の利便性を主要特徴としている。

このような識別中心システムで起こり得る潜在的な金融事故やシステム脆弱性を補うため、提供者は二要素認証をリスク低減の仕組みとして活用している。加入者の携帯電話番号の一部入力や別途パスワード認証などの多要素認証手続きを併用することで、誤認識やなりすましによる不正取引の可能性を技術的に遮断し、決済セキュリティの信頼性を高めていると分析できる。

\

*システム失敗対策: 異常な認証試行の遮断および安心補償制度*

#figure(
  image("assets/sec-4/sbs-fail-test-service-blocked.jpeg"),
  caption: [
    FDS により遮断された場合 @sbs-toss-facial-payment (06:18)\
    顔認証決済が無効化され、別の方法で支払うボタンとともに「Toss カスタマーセンターへお問い合わせください（電話番号）」という案内文が表示された。
  ]
) <fig-sbs-fail-test-blocked>

不正取引への対応として異常取引検知システム（Fraud Detection System; FDS）を運用し、異常な認証試行を検知・遮断することで取引の安全性を確保している。実際、実験中に誤った試行が続くと、@fig-sbs-fail-test-blocked のように FDS により悪意ある試行が遮断され、決済が無効化される様子を確認できた。

また、技術的防御の限界により不正取引が成立した場合に備え、被害金額を全額補償する消費者補償制度を明文化している。@toss-facepay
この補償方針の明示は、システム欠陥による消費者被害を提供者が負担するという当然の内容ではあるが、一般には不利な情報を隠蔽したり、消費者紛争や訴訟の末に結論が出ることと対照的である。

これはシステムの安定性に対する高い信頼を示す手段として活用し、消費者の信頼を誘導して新規利用者を獲得する戦略として理解できる。

= 課題 \#5: 画像情報処理システムの開発 <sec-5>

#origin-quote[
  静止画像や動画像を使って、オリジナル作品を作りなさい。 
  
  《例》
  #list(marker: "● ",
    [自作または公開されているモーフィングソフト（可能な限りクロスディゾルブだけではなくワーピングも）を用いた、画像 A から画像 B へ滑らかに変化するモーフィング画像の作成。（ zipで圧縮後、専用サイトから提出のこと） ],
    [pythonやOpenCVを用いた、画像応用システムの作成。ソースファイルを提出するとともに、システムの概要などを説明しなさい。（カメラの顔の表情に合わせてキャラクターの表情も変化するVtuber的システムなど） ],
    [クロマキー作品の制作（グリーンスクリーン貸し出し可能） ],
    [数秒程度のテーマ性のサイレント(無音)動画作品の制作ファイル形式は原則として mp4、mkv、アニメーション GIF かアニメーション PNG のいずれかにすること。（zipで圧縮後、アップロードサイトから提出のこと）],
  )
]

画像情報処理システムとして、カメラ映像内の顔の表情や向きに合わせて2Dキャラクターモデルの表情や視線の方向を変化させるVTuberシステムを、@fig-lite2d-vtuber-heading-left, @fig-lite2d-vtuber-heading-right のように実装した。

#origin-quote(
  _stroke: "#015958",
  _fill: "#0FC2C003"
)[
  備考

  この作業には、Live2Dが著作したサンプルキャラクターモデル「Mao」を、#underline[#link("https://www.live2d.com/eula/live2d-free-material-license-agreement_en.html")[『無償提供マテリアルの使用許諾契約書』]] #underline[#link("https://www.live2d.com/eula/live2d-sample-model-terms_en.html")[『Live2D Cubism サンプルデータ利用条件』]]に基づいて使用した。 
]

#figure(
  image("assets/sec-5/lite2d-vtuber-heading-left.png"),
  caption: [実装体上で首を左側に傾けた様子],
  placement: top,
) <fig-lite2d-vtuber-heading-left>

#figure(
  image("assets/sec-5/lite2d-vtuber-heading-right.png"),
  caption: [実装体上で首を右側に傾けた様子],
  placement: top,
) <fig-lite2d-vtuber-heading-right>

これを達成するために、Live2D Cubism SDKを利用したレンダリングアプリケーションと、キャラクターのレンダリング設定を微調整するユーティリティソフトウェアを新たに作成した。これらのソフトウェア群においてキャラクター描画に関与するプログラムはC/C++を使用し、ユーティリティソフトウェアはSvelteをベースとしたGUIウェブアプリケーションとして作成した。このように準備したレンダリングシステムとOpenCVの顔検出、ランドマーク検出機能を組み合わせ、カメラ内の顔の向きと表情に合わせて2Dキャラクターモデルの視線と表情を変化させるVtuberシステムを実装した。  

\

具体的には、次のような実装体で構成した：cubism_vtuber, lite2d-editor, lite2d-editor-ui, moc32json。このシステム実装は #underline[#link("https://github.com/ShapeLayer/cubism-sdk-realtime-facial-representation")] と #underline[#link("https://github.com/shapelayer/lite2d")] で確認できる。

\

これらの実装体において核心となる実装は cubism_vtuber である。cubism_vtuber は Live2D の Cubism Native Framework に依存しており、これらのフレームワークを活用して OpenGL を使用し 2D キャラクターモデルをレンダリングすることを目標とする。 

lite2d-editor と lite2d-editor-ui は、レンダリング設定を微調整するために作成したウェブアプリケーションである。ロードしようとするキャラクターモデルに対し、モデルが微細にどのように動くか、各テクスチャ部位が正しい順序でロードされるかを確認しながら設定値を修正する必要があったが、これをテキストエディタで確認することには困難な点があった。そのため、これらの設定値によるレンダリング結果をリアルタイムで確認しながら設定値を調整できる GUI アプリケーションが必要だった。  

== cubism_vtuber

#figure(
  image("assets/sec-5/cubism-vtuber-closing-eye.png", width: 80%),
  caption: [基準となる人物が目を閉じる状況を認識し、システムがキャラクターの目を閉じさせている。]
)

本システムであるcubism_vtuberは、OpenCVおよびOpenCV内蔵のhaarcascade分類器を用いて、カメラ映像内の人物と顔を検出し、ランドマークを抽出する。これらのランドマーク情報を用いて顔の向きや表情を推定し、その情報をLive2D Cubism SDKに渡すことで、2Dキャラクターモデルの視線や表情を変化させるよう実装した。

しかし、haarcascade分類器の感度を調整するだけでは、商用のVTuberシステムの水準を満たすことは困難であった。添付のデモ映像で確認できるように、これらの分類器は眉間の前髪部分を口と誤認識することが多く、キャラクターモデルの口がスムーズに動かない場面が見られた。また、顔のy軸回転についても認識精度が低く、首を左右に傾ける動作以外、顔の回転が顕著に反映されることはなかった。

これらの問題については、今後、顔検出プロセスにディープラーニングモデルを導入することで改善が可能であると考えられる。しかし、haarcascade分類器が授業で紹介された手法であること、またMediaPipeなどのモデルを本実装に組み込むにはFFIの実装やC/C++ライブラリの部分的なコンパイルが必要となり、本課題の範囲を超えると判断したため、今後の改善課題として残すこととした。

== moc32json, lite2d-editor, lite2d-editor-ui

#figure(
  image("assets/sec-5/mao_pro_default.png", width: 80%),
  caption: [デモキャラクター Mao のレンダリング初期値],
  placement: top,
) <fig-mao-pro-default>

Live2Dから公式に提供されているデモキャラクターは、多彩な動作を表現できるよう、様々なテクスチャの変形データを含んでいる。これらのデータは @fig-mao-pro-default のように一度に表示され、キャラクターによっては腕や足が4本以上描画される様子が見られた。  

Live2D Cubism Editor を使用して各部分のレンダリング設定を調整し、キャラクターが自然に見えるようにすることができる。しかし、無料版の制限事項によりデモキャラクターの設定を保存したり適用したりすることに限界があり、エディタはアニメーティング、モデリングなど、この課題に必要のない機能が多数含まれており、使用に難しさがあった。  

#figure(
  image("assets/sec-5/lite2d-editor-demo.png"),
  caption: [lite2d-editor に変換された Live2D デモモデルをロードした様子],
  placement: top,
) <fig-lite2d-editor-demo>

そこで @fig-lite2d-editor-demo のように、独自のレンダリング設定調整ツールとしてエディタ本体である lite2d-editor とエディタの UI システム lite2d-editor-ui を作成した。これらのツールを使用して、デモキャラクターの各部分が正しい順序でレンダリングされるかをリアルタイムで確認しながら設定値を調整することができた。

lite2d-editor はレンダリングデータを視覚化するだけでなく、レンダリング設定値を調整しなければならないため、利便性の側面から一種の GUI エディタとして動作しなければならなかった。このような背景から、PhotoshopやPowerPointに似たグラフィックツールの動作を多少模倣するように作成することになった。マウスホイールクリックで画面をドラッグするとレンダリング画面が平行移動したり、レイヤー順序の調整時に表示が反映されたり、各レイヤーの描画結果をプレビューでクリックした際に実際にこれらのレイヤーが選択されるなどのグラフィックツールとしての機能を実装した。

lite2d-editor が GUI グラフィックツールとして高度化するにつれ、コードベースは UI システムの実装とグラフィックツールの実装が混在し、作業を継続することが困難なほどになった。これに対応して UI システムを lite2d-editor-ui として分離し、一般的な GUI プログラムの UI システムとして使用可能なレベルまでモジュール化した後、これを lite2d-editor がロードする方式で処理した。

#figure(
  image("assets/sec-5/mao_texture_00.png", width: 80%),
  caption: [デモキャラクター Mao のテクスチャアトラス],
  placement: top,
) <fig-mao-texture-atlas>

キャラクターモデルは @fig-mao-texture-atlas のように各パーツを一箇所に集め、一つの大きなテクスチャアトラスとして扱っている。プログラムによってマージ処理、自動生成されたアトラスから手動で各パーツを正しく切り出してインデックス化する作業は、与えられた期間内に行うには消耗的であると判断し、アトラスインデックスデータを moc3 から読み込むツールとして moc32json を作成して使用した。

== 追加情報: Cubism Native Framework に依存しない独自のエンジンライブラリ

cubism_vtuber を実装する前、Cubism Native Framework に依存しない独自のレンダリングエンジンの作成を試みた。このエンジンは liblite2d としてパッケージ化し、Vtuber システムのレンダリングエンジンとして使用しようとした。liblite2d はキャラクター描画に要求される Mesh 計算、シェーディング、テクスチャロード、モデルロード処理を行うように実装した。  

しかし、キャラクターの各部分の連結を適切に維持しながらグラフィックスを変形する方法を見つけることができなかった。常に顔に付着された状態が維持される口や目の操作は容易だったが、首を回転させたり首を上に伸ばす動作では顔が分離される問題があった。

実装に使用したグラフィックライブラリは今回の課題で初めて使用したため、期間内にこの問題を解決できないと見込まれた。これに伴い #underline[#link("https://github.com/shapelayer/lite2d")] の lite2d ディレクトリにこれらのレンダリングエンジンをアーカイブし、Cubism Native Framework に依存する cubism_vtuber を実装することで課題遂行の方向を変更した。

= 本報告書を目的として作成した実装体

\

*fftj-kt*

@sec-1 で周波数スペクトルを歪ませ、隠されたスペクトルを明らかにするために fftj を変形実装した。

#url("https://github.com/shapelayer/fftj-kt")

\

*spotdiff-py*

@sec-3 で間違い探し問題をコンピュータで自動解決するためのアルゴリズムの概念実証（PoC）として実装した。

#url("https://github.com/shapelayer/spotdiff-py")

\

*cubism_vtuber*, *lite2d-editor*, *lite2d-editor-ui*, *moc32json*

@sec-5 でカメラ内の顔の表情と顔の向きに合わせて 2D キャラクターモデルの表情と視線の方向を変化させる Vtuber システムの実装のために作成した。

#url("https://github.com/shapelayer/cubism-sdk-realtime-facial-representation")

#url("https://github.com/shapelayer/lite2d")

/**
 * References
 */

#set page(columns: 1)
#bibliography("refs.bib", title: [References], full: true)
