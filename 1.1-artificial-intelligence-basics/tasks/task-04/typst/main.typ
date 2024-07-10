#let layout(body) = {
  set page("a4",
    margin: (x: 3em, y: 4em)
  )
  set text(
    font: ("Noto Sans CJK KR", "Noto Sans KR"),
    size: .9em,
  )
  align(horizon)[
    #body
  ]
}
#show: body => layout(body)

#let wf = 70%
#let ws2 = 100%

#show heading.where(level: 2): it => text(size: 1.4em, it.body + v(.5em))

Homework 04
\

\
이름: 박종현\
학번: 214823

\

[1] 7-1. 16~17 쪽

#figure(
  image("images/out-01.png", width: wf)
)

[2] 7-1. 21~22 쪽

#figure(
  image("images/out-02.png", width: wf)
)

#pagebreak()

[3] 7-2. 9~10 쪽

#figure(
  image("images/out-03-1.png", width: wf)
)

#figure(
  image("images/out-03-2.png", width: wf)
)

#pagebreak()

[4] 7-2. 16~17 쪽

#figure(
  image("images/out-04.png", width: wf)
)


[5] 7-2. 25,27~30 쪽

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-05-1.png", width: ws2)
    )
  ],
  [
    #figure(
      image("images/out-05-2.png", width: ws2)
    )
  ], 
  [
    #figure(
      image("images/out-05-3.png", width: ws2)
    )
  ],
  [
    #figure(
      image("images/out-05-4.png", width: ws2)
    )
  ]
)

[6] 7-2. 31~32 쪽

#figure(
  image("images/out-06.png", width: wf)
)

#pagebreak()

[7] 7-3. 6 쪽

#figure(
  image("images/out-07.png", width: wf)
)

[8] 7-3. 12~13 쪽

#figure(
  image("images/out-08.png", width: wf)
)

#pagebreak()

[9] 7-3. 19~22 쪽

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-09-1.png", width: ws2)
    )
  ],
  [
    #figure(
      image("images/out-09-2.png", width: ws2)
    )
  ]
)

[10] 9-1. 19 쪽

#figure(
  image("images/out-10.png", width: wf)
)

#pagebreak()

[11] 9-1. 21 쪽

#figure(
  image("images/out-11.png", width: wf)
)

[12] 9-1. 25~27 쪽

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-12-1.png", width: ws2)
    )
  ],
  [
    #figure(
      image("images/out-12-2.png", width: ws2)
    )
  ], 
  [
    #figure(
      image("images/out-12-3-1.png", width: ws2)
    )
  ],
  [
    #figure(
      image("images/out-12-3-2.png", width: ws2)
    )
  ], 
  [
    #figure(
      image("images/out-12-3-3.png", width: ws2)
    )
  ],
  [
    #figure(
      image("images/out-12-3-4.png", width: ws2)
    )
  ]
)

[13] 9-2. 10~12 쪽

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-13-1-1.png", width: ws2)
    )
  ],
  [
    #figure(
      image("images/out-13-1-2.png", width: ws2)
    )
  ], 
  [
    #figure(
      image("images/out-13-1-3.png", width: ws2)
    )
  ],
  [
    #figure(
      image("images/out-13-1-4.png", width: ws2)
    )
  ], 
  [
    #figure(
      image("images/out-13-1.png", width: ws2)
    )
  ],
  [
    #figure(
      image("images/out-13-2.png", width: ws2)
    )
  ]
)

[14] 9-2. 15~19 쪽

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-14-1-1.png", width: ws2)
    )
  ],
  [
    #figure(
      image("images/out-14-1-2.png", width: ws2)
    )
  ], 
  [
    #figure(
      image("images/out-14-2-1.png", width: ws2)
    )
  ],
  [
    #figure(
      image("images/out-14-2-2.png", width: ws2)
    )
  ], 
  [
    #figure(
      image("images/out-14-3.png", width: ws2)
    )
  ],
  [
    #figure(
      image("images/out-14-4-1.png", width: ws2)
    )
  ],
  [
    #figure(
      image("images/out-14-4-2.png", width: ws2)
    )
  ],
  [
    #figure(
      image("images/out-14-5.png", width: ws2)
    )
  ]
)
#pagebreak()
[15] 9-2. 21~24 쪽

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-15-1.png", width: wf)
    )
  ],
  [
    #figure(
      image("images/out-15-2.png", width: wf)
    )
  ],
  [
    #figure(
      image("images/out-15-2-2.png", width: ws2)
    )
  ], 
  [
    #figure(
      image("images/out-15-2-3.png", width: ws2)
    )
  ]
)

[16] 9-3. 10~13 쪽

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-16-1.png", width: ws2)
    )
  ], 
  [
    #figure(
      image("images/out-16-2.png", width: ws2)
    )
  ]
)
#pagebreak()

[17] 9-3. 15 쪽

#figure(
  image("images/out-17.png", width: wf)
)

[18] 9-3. 17~19 쪽

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-18-1-1.png", width: ws2)
    )
  ], 
  [
    #figure(
      image("images/out-18-1-2.png", width: ws2)
    )
  ]
)


