#set page(margin: (
  top: 15mm,
  bottom: 15mm,
  left: 20mm,
  right: 20mm,
),
  numbering: "1",
  header: [
    #text(size: .7em, fill: gray)[#columns(2)[
      #align(left)[데이터베이스시스템 과제]
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

= 데이터베이스시스템 과제 \#4
\
박종현, 2025-04-07\
공과대학 컴퓨터정보통신공학과

== 과제 목표

1. 실습자료 4 수행 후 캡쳐 제출

== [실습 4-1]

#img("./assets/db4-1_1.png")
#img("./assets/db4-2_1-1.png")
#img("./assets/db4-2_1-2.png")
#img("./assets/db4-2_1-3.png")
#img("./assets/db4-2_1-4.png")
#img("./assets/db4-2_1-5_1.png")
#img("./assets/db4-2_1-5_2.png")

== [실습 4-2]

#img("./assets/db4-2_2-1.png")
#img("./assets/db4-2_2-2.png")
#img("./assets/db4-2_2-3.png")
#img("./assets/db4-2_3-1.png")
#img("./assets/db4-2_3-2.png")
#img("./assets/db4-2_3-3.png")
#img("./assets/db4-2_4.png")

== [실습 4-3]

#img("./assets/db4-3_10.png")
#img("./assets/db4-3_2-2.png")
#img("./assets/db4-3_2-3.png")
#img("./assets/db4-3_3-1.png")
#img("./assets/db4-3_3-2.png")
#img("./assets/db4-3_4_1.png")
#img("./assets/db4-3_4_2.png")
#img("./assets/db4-3_4_3.png")
#img("./assets/db4-3_5.png")
#img("./assets/db4-3_6.png")
#img("./assets/db4-3_7.png")
#img("./assets/db4-3_8.png")
#img("./assets/db4-3_9-1.png")
#img("./assets/db4-3_9-2.png")
#img("./assets/db4-3_9-3.png")

== [실습 4-4]

#img("./assets/db4-4_2-3.png")
#img("./assets/db4-4_2-4.png")
#img("./assets/db4-4_3-1.png")
#img("./assets/db4-4_4.png")
#img("./assets/db4-4_5-1.png")
#img("./assets/db4-4_5-4.png")
#img("./assets/db4-4_6-4.png")
#img("./assets/db4-4_6-5.png")
#img("./assets/db4-4_7-4.png")
#img("./assets/db4-4_7-5.png")

== [실습 4-5]
#img("./assets/db4-5_2-2_1.png")
#img("./assets/db4-5_2-2_2.png")
#img("./assets/db4-5_3.png")
#img("./assets/db4-5_4-2.png")
#img("./assets/db4-5_4-4.png")