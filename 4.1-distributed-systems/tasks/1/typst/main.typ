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

= 분산시스템 과제 \#1
\
박종현, 2025-03-19\
공과대학 컴퓨터정보통신공학과

== 과제 목표

1. 1-6 자료 : 3, 4, 6, 7, 8, 19, 20 쪽
2. 1-7 자료 : 4, 8, 9, 12 쪽
3. 1-8 자료 : 8, 9, 12, 13, 14 쪽

== [1-6, \#3]
#img("assets/ch1-6_3_in.png", size: 65%)

== [1-6, \#4]
#img("assets/ch1-6_4_in.png", size: 65%)

== [1-6, \#6]
#img("assets/ch1-6_6_in.png", size: 65%)

== [1-6, \#7]
#img("assets/ch1-6_7_in.png", size: 65%)

== [1-6, \#8]
#img("assets/ch1-6_8_in.png", size: 65%)

== [1-6, \#19]
#img("assets/ch1-6_19_in.png", size: 65%)

== [1-6, \#20]
#img("assets/ch1-6_20_in.png", size: 65%)

#pagebreak()

== [1-7, \#4]
#img("assets/ch1-7_4_in.png", size: 65%)
#img("assets/ch1-7_4_out-1.png", size: 65%)
#img("assets/ch1-7_4_out-2.png", size: 65%)
#img("assets/ch1-7_4_out-3.png", size: 65%)

== [1-7, \#8]
#img("assets/ch1-7_8_in.png", size: 65%)
#img("assets/ch1-7_8_out-1.png", size: 65%)
#img("assets/ch1-7_8_out-2.png", size: 65%)
#img("assets/ch1-7_8_out-3.png", size: 65%)
#img("assets/ch1-7_8_out-4.png", size: 65%)

== [1-7, \#9]
#img("assets/ch1-7_9_in.png", size: 65%)

== [1-7, \#12]
#img("assets/ch1-7_12_in.png", size: 65%)
#img("assets/ch1-7_12_out-1.png", size: 65%)
#img("assets/ch1-7_12_out-2.png", size: 65%)
#img("assets/ch1-7_12_out-3.png", size: 65%)

#pagebreak()

== [1-8, \#8]
#img("assets/ch1-8_8_in.png", size: 65%)
#img("assets/ch1-8_8_out-1.png", size: 65%)
#img("assets/ch1-8_8_out-2-4.png", size: 65%)

== [1-8, \#9]
#img("assets/ch1-8_9_in.png", size: 65%)
#img("assets/ch1-8_9_out.png", size: 65%)

#pagebreak()
== [1-8, \#12]
#img("assets/ch1-8_12_in.png", size: 65%)
#img("assets/ch1-8_12_out-1.png", size: 65%)
#img("assets/ch1-8_12_out-2.png", size: 65%)

== [1-8, \#13]
#img("assets/ch1-8_13.png", size: 65%)

== [1-8, \#14]
#img("assets/ch1-8_14_in.png", size: 65%)
#img("assets/ch1-8_14_out.png", size: 65%)
