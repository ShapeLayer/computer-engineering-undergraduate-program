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

#let img(path, size: 80%) = {
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

= 분산시스템 과제 \#9
\
박종현, 2025-05-23\
공과대학 컴퓨터정보통신공학과

== 과제 목표

1. 4-02 자료 :  16~18쪽
2. 4-03 자료 :  3~15쪽

#set align(horizon)

== [ch 4-1]
#img("./assets/4-1_1.png")
#img("./assets/4-1_2.png")

== [ch 4-2]
#img("./assets/4-2_1.png")
#img("./assets/4-2_2.png")
#img("./assets/4-2_3.png")
#img("./assets/4-2_4.png")
#img("./assets/4-2_5.png")
#img("./assets/4-2_6.png")
#img("./assets/4-2_7.png")
#img("./assets/4-2_8.png")
#img("./assets/4-2_9.png")
#img("./assets/4-2_10.png")
#img("./assets/4-2_11.png")
#img("./assets/4-2_12.png")
#img("./assets/4-2_13.png")
#img("./assets/4-2_14.png")
