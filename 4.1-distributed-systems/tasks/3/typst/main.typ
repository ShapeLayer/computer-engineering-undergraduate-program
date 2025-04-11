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

= 분산시스템 과제 \#3
\
박종현, 2025-04-10\
공과대학 컴퓨터정보통신공학과

== 과제 목표

1. 2-4 자료 :  14, 15쪽
2. 2-5 자료 :  9, 16, 17쪽
3. 2-6 자료 :  25, 26쪽
4. 2-7 자료 :  10, 13, 24쪽


== [Ch 2-4 p.14]

#img("assets/ch2-4_14_1-head.png", size: 70%)
#img("assets/ch2-4_14_1-tail.png", size: 70%)

== [Ch 2-4 p.15]
#img("assets/ch2-4_15_1.png", size: 70%)
#img("assets/ch2-4_15_2-head.png", size: 70%)
#img("assets/ch2-4_15_2-tail.png", size: 70%)

#pagebreak()

== [Ch 2-5 p.9]
#img("assets/ch2-5_9_1-head.png", size: 70%)
#img("assets/ch2-5_9_1-tail.png", size: 70%)
#img("assets/ch2-5_9_2.png", size: 70%)
#img("assets/ch2-5_9_3.png", size: 70%)

== [Ch 2-5 p.16-17]
#img("assets/ch2-5_16.png", size: 70%)
#img("assets/ch2-5_17.png", size: 70%)

#pagebreak()

== [Ch 2-6 p.25-26]
#img("assets/ch2-6_25.png", size: 70%)
#img("assets/ch2-6_26_1.png", size: 70%)
#img("assets/ch2-6_26_2.png", size: 70%)
#img("assets/ch2-6_26_3.png", size: 70%)

#pagebreak()

== [Ch 2-7 p.10]
#img("assets/ch2-7_10_1.png", size: 70%)
#img("assets/ch2-7_10_2.png", size: 70%)

== [Ch 2-7 p.13]
#img("assets/ch2-7_13_1.png", size: 70%)
#img("assets/ch2-7_13_2.png", size: 70%)

== [Ch 2-7 p.24]
#img("assets/ch2-7_24_1-head.png", size: 70%)
#img("assets/ch2-7_24_1-tail.png", size: 70%)
#img("assets/ch2-7_24_2-head.png", size: 70%)
#img("assets/ch2-7_24_2-tail.png", size: 70%)
#img("assets/ch2-7_24_3.png", size: 70%)
