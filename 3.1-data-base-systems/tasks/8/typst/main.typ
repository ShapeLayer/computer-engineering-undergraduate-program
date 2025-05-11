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

== [8-1]
#img("./assets/8-1_1-in.png")
#img("./assets/8-1_2-in.png")
#img("./assets/8-1_2-out-1.png")
#img("./assets/8-1_2-out-2.png")

== [8-2]
#img("./assets/8-2_1-in.png")
#img("./assets/8-2_1-out-1.png")
#img("./assets/8-2_1-out-2.png")
#img("./assets/8-2_2-in.png")
#img("./assets/8-2_2-out.png")

== [8-3]
#img("./assets/8-3_in.png")

== [8-4]
#img("./assets/8-4_1-in.png")
#img("./assets/8-4_1-out-1.png")
#img("./assets/8-4_1-out-2.png")
#img("./assets/8-4_2-in.png")
#img("./assets/8-4_2-out-1.png")
#img("./assets/8-4_2-out-2.png")
#img("./assets/8-4_2-out-3.png")
#img("./assets/8-4_2-out-4.png")
#img("./assets/8-4_3_in.png")
#img("./assets/8-4_3-out.png")
