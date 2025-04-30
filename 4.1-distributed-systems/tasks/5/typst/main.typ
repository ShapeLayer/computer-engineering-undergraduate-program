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

= 분산시스템 과제 \#5
\
박종현, 2025-05-01\
공과대학 컴퓨터정보통신공학과

== 과제 목표

1. 3-2 자료 :  8, 12\~16쪽
2. 3-3 자료 :  5, 6, 9,10, 11 쪽
3. 3-4 자료 :  3\~10쪽

#set align(horizon)

== [Ch 3-2]

#img("./assets/ch3-2_8-1.png")
#img("./assets/ch3-2_8-2.png")
#img("./assets/ch3-2_8-3.png")
#img("./assets/ch3-2_8-4.png")
#img("./assets/ch3-2_8-5.png")
#img("./assets/ch3-2_8-6.png")
#img("./assets/ch3-2_8-7.png")
#img("./assets/ch3-2_8-8.png")

#img("./assets/ch3-2_12-1.png")
#img("./assets/ch3-2_12-2.png")
#img("./assets/ch3-2_12-3.png")
#img("./assets/ch3-2_12-4.png")
#img("./assets/ch3-2_12-5.png")
#img("./assets/ch3-2_12-6.png")
#img("./assets/ch3-2_12-7.png")
#img("./assets/ch3-2_12-8.png")

#pagebreak()

== [Ch 3-3]
#img("./assets/ch3-3_5-1.png")
#img("./assets/ch3-3_5-2.png")
#img("./assets/ch3-3_5-3.png")
#img("./assets/ch3-3_5-4.png")
#img("./assets/ch3-3_5-5.png")
#img("./assets/ch3-3_5-6.png")
#img("./assets/ch3-3_5-7.png")
#img("./assets/ch3-3_5-8.png")
#img("./assets/ch3-3_5-9.png")

#img("./assets/ch3-3_6-1.png")

#img("./assets/ch3-3_7-1.png")
#img("./assets/ch3-3_7-2.png")
#img("./assets/ch3-3_7-3.png")
#img("./assets/ch3-3_7-4.png")
#img("./assets/ch3-3_7-5.png")

#img("./assets/ch3-3_10-1.png")
#img("./assets/ch3-3_11-1.png")
#img("./assets/ch3-3_11-2.png")
#img("./assets/ch3-3_11-3.png")

#pagebreak()

== [Ch 3-4]
#img("./assets/ch3-4_4-1.png")
#img("./assets/ch3-4_4-2.png")
#img("./assets/ch3-4_4-3.png")

#img("./assets/ch3-4_5-1.png")
#img("./assets/ch3-4_5-2.png")

#img("./assets/ch3-4_6-1.png")

#img("./assets/ch3-4_7-1.png")
#img("./assets/ch3-4_7-2.png")

#img("./assets/ch3-4_8-1.png")
#img("./assets/ch3-4_8-2.png")
#img("./assets/ch3-4_8-3.png")
#img("./assets/ch3-4_8-4.png")
#img("./assets/ch3-4_8-5.png")
#img("./assets/ch3-4_8-6.png")

#img("./assets/ch3-4_9-1.png")
#img("./assets/ch3-4_9-2.png")
#img("./assets/ch3-4_9-3.png")
#img("./assets/ch3-4_9-10.png")
