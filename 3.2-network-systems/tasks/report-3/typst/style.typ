// Fonts
#let font-family = (
  "M PLUS 1p",  // JP
  "Gothic A1", "Pretendard", // KR
  "Noto Sans CJK KR", "Noto Sans CJK JP", "Noto Sans KR", "Noto Sans JP", // CJK
  "Noto Sans" // Fallback
)

// Colors
#let __ucpc_color_named = (
  brown: (
    rgb("#9d4900"),
    rgb("#a54f00"),
    rgb("#ad5600"),
    rgb("#b55d0a"),
    rgb("#c67739"),
  ),
  bluegray: (
    rgb("#38546e"),
    rgb("#3d5a74"),
    rgb("#435f7a"),
    rgb("#496580"),
    rgb("#4e6a86"),
  ),
  yellow: (
    rgb("#d28500"),
    rgb("#df8f00"),
    rgb("#ec9a00"),
    rgb("#f9a518"),
    rgb("#ffb028"),
  ),
  cyan: (
    rgb("#00c78b"),
    rgb("#00d497"),
    rgb("#27e2a4"),
    rgb("#3ef0b1"),
    rgb("#51fdbd"),
  ),
  skyblue: (
    rgb("#009ee5"),
    rgb("#00a9f0"),
    rgb("#00b4fc"),
    rgb("#2bbfff"),
    rgb("#41caff"),
  ),
  cherry: (
    rgb("#e0004c"),
    rgb("#ea0053"),
    rgb("#f5005a"),
    rgb("#ff0062"),
    rgb("#ff3071"),
  ),
)
#let pallete = (
  brown: __ucpc_color_named.brown,
  bluegray: __ucpc_color_named.bluegray,
  yellow: __ucpc_color_named.yellow,
  cyan: __ucpc_color_named.cyan,
  skyblue: __ucpc_color_named.skyblue,
  cherry: __ucpc_color_named.cherry,
  bronze: (
    V: __ucpc_color_named.brown.at(0),
    IV: __ucpc_color_named.brown.at(1),
    III: __ucpc_color_named.brown.at(2),
    II: __ucpc_color_named.brown.at(3),
    I: __ucpc_color_named.brown.at(4),
  ),
  silver: (
    V: __ucpc_color_named.bluegray.at(0),
    IV: __ucpc_color_named.bluegray.at(1),
    III: __ucpc_color_named.bluegray.at(2),
    II: __ucpc_color_named.bluegray.at(3),
    I: __ucpc_color_named.bluegray.at(4),
  ),
  gold: (
    V: __ucpc_color_named.yellow.at(0),
    IV: __ucpc_color_named.yellow.at(1),
    III: __ucpc_color_named.yellow.at(2),
    II: __ucpc_color_named.yellow.at(3),
    I: __ucpc_color_named.yellow.at(4),
  ),
  platinum: (
    V: __ucpc_color_named.cyan.at(0),
    IV: __ucpc_color_named.cyan.at(1),
    III: __ucpc_color_named.cyan.at(2),
    II: __ucpc_color_named.cyan.at(3),
    I: __ucpc_color_named.cyan.at(4),
  ),
  diamond: (
    V: __ucpc_color_named.skyblue.at(0),
    IV: __ucpc_color_named.skyblue.at(1),
    III: __ucpc_color_named.skyblue.at(2),
    II: __ucpc_color_named.skyblue.at(3),
    I: __ucpc_color_named.skyblue.at(4),
  ),
  ruby: (
    V: __ucpc_color_named.cherry.at(0),
    IV: __ucpc_color_named.cherry.at(1),
    III: __ucpc_color_named.cherry.at(2),
    II: __ucpc_color_named.cherry.at(3),
    I: __ucpc_color_named.cherry.at(4),
  ),
  misc: (
    ghudegy: rgb("#8769af"),
    unrated: rgb("#2d2d2d"),
  ),
)

#let theme(
  title: "",
  author: "",
  hero: none,
  fill: pallete.bluegray.at(2),
  body
) = {
  set document(title: title, author: author)
  set page(margin: 0%, paper: "presentation-16-9")
  set text(font: font-family)

  if (hero != none) [
    #hero
  ]
  
  set page(
    margin: (
      top: 2em, bottom: 2em, left: 2.5em, right: 2.5em
    ),
    footer: text(size: 10pt, fill: fill)[
      #columns(3)[
        #align(left)[#title]
        #colbreak()
        #align(center)[#context { counter(page).display("1") }]
        #colbreak()
        #align(right)[#author]
      ]
    ]
  )

  show raw.where(block: false): it => box(fill: rgb("f5f5f5"), outset: (y: 5pt), inset: (x: 5pt), text(fill: red, it))
  show raw.where(block: true): it => box(fill: rgb("f5f5f5"), outset: (y: 10pt), inset: (x: 10pt), width: 100%, it)
  
  show bibliography: it => {
    // 1. 시작 페이지 마킹 (헤더 숨김 로직용)
    [#metadata("bib-start") <bib-start>]
    
    // 2. 페이지 설정 (첫 페이지 헤더 숨김)
    set page(
      margin: (
        top: 2em, bottom: 2em, left: 2.5em, right: 2.5em
      ),
      header: context {
        let page-num = counter(page).get().first()
        let start-locs = query(<bib-start>)
        if start-locs.len() > 0 {
          let start-page = start-locs.first().location().page()
          if page-num == start-page {
            none // 첫 페이지는 헤더 없음
          } else {
            // 그 외 페이지는 헤더 표시
            text(size: .8em)[
              #text(fill: pallete.bluegray.at(2))[
                #it.title
              ]
            ]
          }
        } else {
          // 예외 처리
          text(size: .8em, fill: pallete.bluegray.at(2))[#it.title]
        }
      }
    )
  
    // 4. [중복 해결 핵심] 제목을 새로 만드는 대신, 기존 제목(heading)의 스타일을 변경합니다.
    show heading: set text(fill: pallete.bluegray.at(2), size: 28.8pt)
    
    // 5. 참고 문헌 출력 (이제 스타일이 적용된 제목 하나만 나옵니다)
    set text(size: 24pt)
    text(size: 12pt)[#it]
  }

  set text(size: 24pt)
  body
}

#let section(
  title: none,
  hero: [],
  header: none,
  primary-color: pallete.bluegray.at(2),
  body
) = {
  set page(margin: (top: 1.7em))
  set text(size: 24pt)
  set list(marker: [#text(font: "inter", fill: primary-color)[✓]])
  show footnote: set text(fill: black, weight: 400)
  show footnote.entry: set text(size: .7em)
  [= #text(fill: primary-color, size: 1.2em)[#title]]
  align(horizon)[#hero]
  set page(
    header: text(
      size: .8em
    )[
      #text(fill: primary-color)[
        #if (header == none) {
          title
        } else {
          header
        }
      ]
    ]
  )
  set page(margin: (top: 2.5em))
  set align(horizon)
  show figure: set text(size: .6em, fill: pallete.silver.V)
  body
}

// Constructor
#let _vulnerability-color(value) = {
  if (value <= 25%) { pallete.diamond.II }
  else if (value <= 50%) { pallete.platinum.IV }
  else if (value <= 75%) { pallete.gold.I }
  else { pallete.ruby.I }
}
#let vulnerability-chart(data) = {
  table(
    columns: (auto, auto, 1fr),
    stroke: none,
    align: horizon,
    inset: (y: 5pt, x: 6pt),
    ..data.map(row => {
      let (label, symbol, percent) = row
      let _color = _vulnerability-color(percent)
      (
        label, 
        text(fill: _color)[*#symbol*], 
        block(width: percent, height: 1.5em, fill: _color)
      )
    }).flatten()
  )
}

#let url(_url) = underline[#link(_url)]
