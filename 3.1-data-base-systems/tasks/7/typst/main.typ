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

= 데이터베이스시스템 과제 \#7
\
박종현, 2025-05-08(지각)\
공과대학 컴퓨터정보통신공학과

== [실습 7-1]
#img("./assets/7-1_in.png")
#img("./assets/7-1_out_1.png")
#img("./assets/7-1_out_2.png")
#img("./assets/7-1_out_3.png")
#img("./assets/7-1_out_4.png")

== [실습 7-2]
#img("./assets/7-2_1_in.png")
#img("./assets/7-2_1_out_1.png")
#img("./assets/7-2_1_out_2.png")
#img("./assets/7-2_1_out_3.png")
#img("./assets/7-2_2_out.png")
#img("./assets/7-2_3_in.png")
#img("./assets/7-2_3_out_1.png")
#img("./assets/7-2_4_in.png")
#img("./assets/7-2_4_out_1.png")
#img("./assets/7-2_4_out_2.png")
