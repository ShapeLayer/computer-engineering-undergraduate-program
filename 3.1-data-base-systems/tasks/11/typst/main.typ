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

= 데이터베이스시스템 과제 \#11
\
박종현, 2025-06-03\
공과대학 컴퓨터정보통신공학과

#set align(horizon)

== CH 12-1
=== \#1
#img("assets/12-1_1-1.png")
#img("assets/12-1_1-2.png")

=== \#2
#img("assets/12-1_2-1.png")
#img("assets/12-1_2-2.png")
#img("assets/12-1_2-3_in.png")
#img("assets/12-1_2-3_out.png")

=== \#3
#img("assets/12-1_3_in.png")
#img("assets/12-1_3_out-1.png")
#img("assets/12-1_3_out-2.png")

=== \#4
#img("assets/12-1_4_out-2.png")
#img("assets/12-1_4-0_in.png")
#img("assets/12-1_4-1_out.png")
#img("assets/12-1_4-3_out.png")
#img("assets/12-1_4-4_in.png")
#img("assets/12-1_4-4_out.png")
#img("assets/12-1_4-5_in.png")
#img("assets/12-1_4-5_out.png")

=== \#5
#img("assets/12-1_5-1_in.png")
#img("assets/12-1_5-1_out.png")
#img("assets/12-1_5-2.png")
#img("assets/12-1_5-3.png")
#img("assets/12-1_5-4.png")
#img("assets/12-1_5-5_in.png")
#img("assets/12-1_5-5_out.png")
#img("assets/12-1_5-6_in.png")
#img("assets/12-1_5-7_in.png")
#img("assets/12-1_5-7_out.png")

#pagebreak()
== CH 12-2
=== \#1
#img("assets/12-2_1.png")

=== \#2
#img("assets/12-2_2-1.png")
#img("assets/12-2_2-2_in.png")
#img("assets/12-2_2-3_in.png")
#img("assets/12-2_2-3_out.png")

=== \#3
#img("assets/12-2_3-1_in.png")
#img("assets/12-2_3-1_out.png")
#img("assets/12-2_3-2_in.png")
#img("assets/12-2_3-2_out.png")
#img("assets/12-2_3-3_in.png")
#img("assets/12-2_3-3_out.png")
#img("assets/12-2_3-4_in.png")
#img("assets/12-2_3-4_out.png")

=== \#4
#img("assets/12-2_4-1_in.png")
#img("assets/12-2_4-1_out.png")
#img("assets/12-2_4-2_in.png")
#img("assets/12-2_4-2_out.png")
#img("assets/12-2_4-3_in.png")
#img("assets/12-2_4-3_out.png")
#img("assets/12-2_4-4_in.png")
#img("assets/12-2_4-4_out.png")
#img("assets/12-2_4-5_in.png")
#img("assets/12-2_4-5_out.png")
#img("assets/12-2_4-6.png")
