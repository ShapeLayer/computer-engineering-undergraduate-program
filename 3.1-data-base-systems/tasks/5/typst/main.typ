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

= 데이터베이스시스템 과제 \#5
\
박종현, 2025-04-12\
공과대학 컴퓨터정보통신공학과

== 과제 목표

1. 실습자료 5 수행 후 캡쳐 제출

== [실습 5-1]
#img("assets/ch5-1_in.png")
#img("assets/ch5-1_out-1.png")
#img("assets/ch5-1_out-2.png")
#img("assets/ch5-1_out-3.png")
#img("assets/ch5-1_out-4.png")

== [실습 5-2]
#img("assets/ch5-2.png")

== [실습 5-3]
#img("assets/ch5-3_in.png")
#img("assets/ch5-3_out-1.png")
#img("assets/ch5-3_out-2.png")
