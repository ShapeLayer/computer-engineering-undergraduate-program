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

= 데이터베이스시스템 과제 \#2
\
박종현, 2025-03-19\
공과대학 컴퓨터정보통신공학과

== 과제 목표

1. 실습자료 2 수행 후 캡쳐 제출

== [실습 2-1]

#img("assets/ch02-1_2-2_in.png")
#img("assets/ch02-1_2-2_out.png")

#pagebreak()

== [실습 2-2]

#img("assets/ch02-2_4_in.png")
#img("assets/ch02-2_4_out-1.png", size: 65%)
#img("assets/ch02-2_4_out-2.png", size: 65%)

#pagebreak()

== [실습 2-3]

#img("assets/ch02-3_in.png")
#img("assets/ch02-3_out-1.png", size: 65%)
#img("assets/ch02-3_out-2.png", size: 65%)

#pagebreak()

== [실습 2-4]

#img("assets/ch02-4_2_in.png", size: 65%)
#img("assets/ch02-4_2_out-1.png", size: 65%)
#img("assets/ch02-4_2_out-2.png", size: 65%)
#img("assets/ch02-4_2_out-3.png", size: 65%)
#img("assets/ch02-4_3_inout.png")
#img("assets/ch02-4_4_inout.png")

#pagebreak()

== [실습 2-5]

#img("assets/ch02-5_1-2_in.png")
#img("assets/ch02-5_1-2_out.png")
#img("assets/ch02-5_2-2.png")
#img("assets/ch02-5_3-1.png")
#img("assets/ch02-5_3-3.png")

#pagebreak()

== [실습 2-6]

#img("assets/ch02-6_3_in.png")
#img("assets/ch02-6_3_out.png")

#pagebreak()

== [실습 2-7]

#img("assets/ch02-7_2_in.png")
#img("assets/ch02-7_2_out-1.png")
#img("assets/ch02-7_2_out-2.png")

#pagebreak()

== [실습 2-8]

#img("assets/ch02-8_2_in.png")
#img("assets/ch02-8_2_out-1.png")
#img("assets/ch02-8_2_out-2.png")
