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

= 데이터베이스시스템 과제 \#8
\
박종현, 2025-05-11\
공과대학 컴퓨터정보통신공학과

#set align(horizon)
== [실습 9-1]
#img("./assets/9-1_1.png")
#img("./assets/9-1_2-1.png")
#img("./assets/9-1_2-2.png")
#img("./assets/9-1_2-3.png")
#img("./assets/9-1_2-4.png")
#img("./assets/9-1_2-5.png")
#img("./assets/9-1_3-1.png")
#img("./assets/9-1_3-2.png")
#img("./assets/9-1_3-3.png")
== [실습 9-2]
#img("./assets/9-2_1.png")
#img("./assets/9-2_2.png")
== [실습 9-3]
#img("./assets/9-3_2-1-in.png")
#img("./assets/9-3_2-1-out-1.png")
#img("./assets/9-3_2-1-out-2.png")
#img("./assets/9-3_2-1-out-3.png")
#img("./assets/9-3_2-1-out-4.png")
#img("./assets/9-3_2-1-out-5.png")
#img("./assets/9-3_2-1-out-6.png")
#img("./assets/9-3_2-1-out-7.png")
== [실습 9-4]
#img("./assets/9-4_1-1.png")
#img("./assets/9-4_1-2.png")
#img("./assets/9-4_2.png")
#img("./assets/9-4_3-1.png")
#img("./assets/9-4_3-2.png")
#img("./assets/9-4_3-3.png")
#img("./assets/9-4_3-4.png")
#img("./assets/9-4_4-1.png")
#img("./assets/9-4_4-2.png")
#img("./assets/9-4_5-in-2.png")
#img("./assets/9-4_5-in.png")
#img("./assets/9-4_5-out-1.png")
#img("./assets/9-4_5-out-2.png")
#img("./assets/9-4_5-out-3.png")
== [실습 9-5]
#img("./assets/9-5_3-in.png")
#img("./assets/9-5_3-out.png")
#img("./assets/9-5_4-in.png")
#img("./assets/9-5_4-out-1.png")
#img("./assets/9-5_4-out-2.png")
#img("./assets/9-5_5.png")
#img("./assets/9-5_6-in.png")
#img("./assets/9-5_6-out-1.png")
#img("./assets/9-5_6-out-2.png")
#img("./assets/9-5_7-in.png")
#img("./assets/9-5_7-out-1.png")
#img("./assets/9-5_7-out-2.png")
#img("./assets/9-5_8.png")
#img("./assets/9-5_9-in-1.png")
#img("./assets/9-5_9-in-2.png")
#img("./assets/9-5_9-out.png")
