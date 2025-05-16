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

= 분산시스템 과제 \#6
\
박종현, 2025-05-09\
공과대학 컴퓨터정보통신공학과

== 과제 목표

1. 3-5 자료 :  4,5,6,7,9,10,12,13쪽
2. 3-6 자료 :  7\~13쪽
3. 3-7 자료 :  3\~7쪽
4. 3-8 자료 :  3\~10쪽

#set align(horizon)

== [ch 3-9]
#img("./assets/3-9_3-1.png")
#img("./assets/3-9_3-2.png")
#img("./assets/3-9_4-1.png")
#img("./assets/3-9_4-2.png")
#img("./assets/3-9_4-3.png")

== [ch 3-11]
#img("./assets/3-11_1.png")
#img("./assets/3-11_2.png")
#img("./assets/3-11_3.png")
#img("./assets/3-11_4.png")
#img("./assets/3-11_5.png")
#img("./assets/3-11_6.png")
#img("./assets/3-11_7.png")

== [ch 3-12]
#img("./assets/3-12_1.png")
#img("./assets/3-12_2.png")
#img("./assets/3-12_3.png")
#img("./assets/3-12_4.png")
#img("./assets/3-12_5.png")
