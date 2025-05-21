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

= 분산시스템 과제 \#8
\
박종현, 2025-05-22\
공과대학 컴퓨터정보통신공학과

== 과제 목표

1. 3-13 자료 :  9~11쪽
2. 3-14 자료 :  3,7쪽
3. 3-15 자료 :  8,9쪽
4. 3-16 자료 :  3,4쪽

#set align(horizon)

== [ch 3-13]
#img("./assets/3-13_9-1.png")
#img("./assets/3-13_9-2.png")
#img("./assets/3-13_10-1.png")
#img("./assets/3-13_10-2.png")
#img("./assets/3-13_11-1.png")
#img("./assets/3-13_11-2.png")
#img("./assets/3-13_11-3.png")
== [ch 3-14]
#img("./assets/3-14_1.png")
#img("./assets/3-14_2.png")
#img("./assets/3-14_3.png")
#img("./assets/3-14_4.png")
#img("./assets/3-14_5.png")
#img("./assets/3-14_6.png")
#img("./assets/3-14_7.png")
#img("./assets/3-14_8.png")
#img("./assets/3-14_9.png")
== [ch 3-15]
#img("./assets/3-15_2.png")
#img("./assets/3-15_3.png")
#img("./assets/3-15_4.png")
#img("./assets/3-15_5.png")
== [ch 3-16]
#img("./assets/3-16_1.png")
#img("./assets/3-16_2.png")
#img("./assets/3-16_3.png")
#img("./assets/3-16_4.png")
#img("./assets/3-16_5.png")
