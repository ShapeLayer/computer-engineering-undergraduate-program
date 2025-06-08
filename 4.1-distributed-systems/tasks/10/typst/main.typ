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

= 분산시스템 과제 \#10
\
박종현, 2025-06-07\
공과대학 컴퓨터정보통신공학과

== 과제 목표

1. 4-04 자료 :  4,5,15\~21쪽
2. 4-05 자료 :  7\~13쪽
3. 4-06 자료 : 11, 17쪽
4. 6-01 자료 : 15, 20, 21쪽
5. 7-01 자료 : 15,16,17쪽
6. 7-02 자료 : 6,7,15,17쪽

#set align(horizon)

#img("./assets/4-4_p15-1.png")
#img("./assets/4-4_p15-2.png")
#img("./assets/4-4_p16.png")
#img("./assets/4-4_p18-1.png")
#img("./assets/4-4_p18-2.png")
#img("./assets/4-4_p20.png")
#img("./assets/4-4_p21.png")
#img("./assets/4-4_p4-1.png")
#img("./assets/4-4_p4-2.png")
#img("./assets/4-4_p5-1.png")
#img("./assets/4-4_p5-2.png")
#img("./assets/4-4_p5-3.png")
#img("./assets/4-5_p10-1.png")
#img("./assets/4-5_p11-1.png")
#img("./assets/4-5_p11-2.png")
#img("./assets/4-5_p12-1.png")
#img("./assets/4-5_p12-2.png")
#img("./assets/4-5_p12-3.png")
#img("./assets/4-5_p13-1.png")
#img("./assets/4-5_p13-2.png")
#img("./assets/4-5_p7.png")
#img("./assets/4-5_p8-1.png")
#img("./assets/4-5_p8-2.png")
#img("./assets/4-5_p9-1.png")
#img("./assets/4-5_p9-2.png")
#img("./assets/4-5_p9-3.png")
#img("./assets/4-6_p11-1.png")
#img("./assets/4-6_p11-2.png")
#img("./assets/4-6_p17-1.png")
#img("./assets/4-6_p17-2.png")
#img("./assets/4-6_p17-3.png")
#img("./assets/4-6_p9-1.png")
#img("./assets/4-6_p9-2.png")
#img("./assets/6-7_08.png")
#img("./assets/6-7_09.png")
#img("./assets/6-7_10.png")
#img("./assets/6-7_11.png")
#img("./assets/6-7_12.png")
#img("./assets/6-7_13.png")
#img("./assets/6-7_14.png")
#img("./assets/6-7_15.png")
#img("./assets/6-7_16.png")
#img("./assets/6-7_17.png")
#img("./assets/6-7_18.png")
#img("./assets/6-7_19.png")
#img("./assets/6-7_20.png")
#img("./assets/6-7_21.png")
#img("./assets/6-7_22.png")
#img("./assets/6-7_23.png")
