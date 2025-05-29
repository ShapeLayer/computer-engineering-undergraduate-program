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

= 데이터베이스시스템 과제 \#10
\
박종현, 2025-05-29\
공과대학 컴퓨터정보통신공학과

#set align(horizon)

#img("./assets/10-1_1-1.png")
#img("./assets/10-1_1-2_in.png")
#img("./assets/10-1_1-2_out.png")
#img("./assets/10-1_1-3_in.png")
#img("./assets/10-1_1-3_out.png")
#img("./assets/10-1_1-4_in.png")
#img("./assets/10-1_1-4_out.png")
#img("./assets/10-1_1-5_in.png")
#img("./assets/10-1_1-5_out.png")
#img("./assets/10-1_1-6_in.png")
#img("./assets/10-1_1-6_out.png")
#img("./assets/10-1_2-1.png")
#img("./assets/10-1_2-2_in.png")
#img("./assets/10-1_2-2_out.png")
#img("./assets/10-1_2-3_in.png")
#img("./assets/10-1_2-3_out.png")
#img("./assets/10-2_1.png")
#img("./assets/10-2_2-1_in.png")
#img("./assets/10-2_2-1_out.png")
#img("./assets/10-2_2-2_out.png")
#img("./assets/10-2_2-3.png")
#img("./assets/10-2_2-4_in.png")
#img("./assets/10-2_2-4_out.png")
#img("./assets/10-2_2-5.png")
#img("./assets/10-2_2-6_in.png")
#img("./assets/10-2_2-6_out.png")
#img("./assets/10-2_2-7_in.png")
#img("./assets/10-2_2-8_in.png")
#img("./assets/10-2_2-8_out.png")
#img("./assets/10-2_2-9_in.png")
#img("./assets/10-2_2-9_out.png")
