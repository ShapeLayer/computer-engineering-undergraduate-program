#set page(margin: (
  top: 15mm,
  bottom: 15mm,
  left: 20mm,
  right: 20mm,
),
  numbering: "1",
  header: [
    #text(size: .7em, fill: gray)[#columns(2)[
      #align(left)[분산시스템 과제]
      #colbreak()
      #align(right)[박종현]
    ]
  ]]
)
#set text(font: ("Noto Sans CJK KR"))
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
  #text(weight: "regular", size: 1.1em)[#it.body ---------]
]

#let img(path, size: 70%) = {
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

= 분산시스템 과제 \#2
\
박종현, 2025-03-19\
공과대학 컴퓨터정보통신공학과

== 과제 목표

1. 1-9 자료 :  4, 10, 11, 12, 13쪽
2. 1-10 자료 :  12, 13, 14, 22, 23, 24쪽
3. 1-11 자료 :  5, 6, 7, 8, 11, 12쪽

== [1-9, \#4]
#img("assets/ch1-9_4_in.png", size: 100%)
#img("assets/ch1-9_4_out_1.png", size: 65%)
#img("assets/ch1-9_4_out_2.png", size: 65%)
#img("assets/ch1-9_4_out_3.png", size: 65%)

== [1-9, \#10]
#table(
  stroke: none,
  columns: 2,
  [#img("assets/ch1-9_10_1a.png", size: 120%)],
  [#img("assets/ch1-9_10_1b.png", size: 120%)],
  [#img("assets/ch1-9_10_2a.png", size: 120%)],
  [#img("assets/ch1-9_10_2b.png", size: 120%)],

)

#pagebreak()

== [1-9, \#11]
#table(
  stroke: none,
  columns: 2,
  [#img("assets/ch1-9_11_1a.png", size: 120%)],
  [#img("assets/ch1-9_11_1b.png", size: 120%)],
  [#img("assets/ch1-9_11_2a.png", size: 120%)],
  [#img("assets/ch1-9_11_2b.png", size: 120%)],
)

#pagebreak()

== [1-9, \#12]
#img("assets/ch1-9_12_1.png", size: 65%)
#img("assets/ch1-9_12_2.png", size: 65%)
#img("assets/ch1-9_12_3.png", size: 65%)

== [1-9, \#13]
#img("assets/ch1-9_13_1.png", size: 65%)
#img("assets/ch1-9_13_2.png", size: 65%)

== [1-10, \#12]
#img("assets/ch1-10_12.png", size: 65%)

== [1-10, \#13]
#img("assets/ch1-10_13.png", size: 65%)

== [1-10, \#14]
#img("assets/ch1-10_14.png", size: 65%)

== [1-10, \#22]

#table(
  stroke: none,
  columns: 2,
  [#img("assets/ch1-10_22_1.png", size: 110%)],
  [#img("assets/ch1-10_22_2.png", size: 110%)],
)

== [1-10, \#23]
#img("assets/ch1-10_23_in.png", size: 75%)
#img("assets/ch1-10_23_out_in.png", size: 75%)
#img("assets/ch1-10_23_out_export.png", size: 120%)
#pagebreak()

== [1-10, \#24]
#img("assets/ch1-10_24_in.png", size: 75%)
#img("assets/ch1-10_24_out_in.png", size: 75%)
#img("assets/ch1-10_24_out_export.png", size: 120%)
#pagebreak()

== [1-11, \#5-\#6]
#img("assets/ch1-11_5-6.png", size: 65%)

== [1-11, \#7-\#8]
#img("assets/ch1-11_7-8.png", size: 65%)

== [1-11, \#11]
#img("assets/ch1-11_11.png", size: 65%)

== [1-11, \#12]
#img("assets/ch1-11_12.png", size: 65%)


