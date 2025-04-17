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

= 분산시스템 과제 \#4
\
박종현, 2025-04-17\
공과대학 컴퓨터정보통신공학과

== 과제 목표

1. 2-8 자료 :  7, 8, 9, 14, 15쪽
2. 2-9 자료 :  11, 12, 19, 20쪽
3. 2-10 자료 :  8, 9, 17, 18쪽



== [Ch 2-8 p.7-9]

#img("./assets/2-8_7-1.png")
#img("./assets/2-8_7-2.png")
#img("./assets/2-8_7-3.png")

== [Ch 2-8 p.14-15]

#img("./assets/2-8_14-1.png")
#img("./assets/2-8_14-2.png")
#img("./assets/2-8_14-3.png")
#img("./assets/2-8_14-4.png")
#img("./assets/2-8_14-5.png")
#img("./assets/2-8_14-6.png")
#img("./assets/2-8_14-7.png")
#img("./assets/2-8_14-8.png")

== [Ch 2-9 p.11-12]
#img("./assets/2-9_11-1.png")
#img("./assets/2-9_11-2.png")
#img("./assets/2-9_11-3.png")

== [Ch 2-9 p.19-20]
#img("./assets/2-9_19-1.png")
#img("./assets/2-9_19-2.png")
#img("./assets/2-9_19-3.png")

== [Ch 2-10 p.8-9]
#img("./assets/2-10_8-1.png")
#img("./assets/2-10_8-2.png")

== [Ch 2-10 p.17-18]
#img("./assets/2-10_17-1.png")
#img("./assets/2-10_17-2.png")