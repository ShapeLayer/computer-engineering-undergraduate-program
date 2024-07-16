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

Homework 05
\

\
이름: 박종현\
학번: 214823

\

[1] 10-1. 22~27 쪽

#figure(
  image("images/out-01-1.png", width: wf)
)


#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-01-2.png", width: ws2)
    )
  ], [
    #figure(
      image("images/out-01-3.png", width: ws2)
    )
  ]
)

#pagebreak()

[2] 10-2. 9~10 쪽

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-02-1.png", width: ws2)
    )
  ], [
    #figure(
      image("images/out-02-2.png", width: ws2)
    )
  ]
)

[3] 10-2. 15~22 쪽

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-03-1.png", width: ws2)
    )
  ], [
    #figure(
      image("images/out-03-2.png", width: ws2)
    )
  ], [
    #figure(
      image("images/out-03-3.png", width: ws2)
    )
  ], [
    #figure(
      image("images/out-03-4.png", width: ws2)
    )
  ], [
    #figure(
      image("images/out-03-5.png", width: ws2)
    )
  ], [
    #figure(
      image("images/out-03-6.png", width: ws2)
    )
  ],
  table.cell(colspan: 2)[
    #figure(
      image("images/out-03-7.png", width: wf)
    )
  ]
)

#pagebreak()

[4] 10-2. 24~26 쪽

#figure(
  image("images/out-04.png", width: wf)
)

#pagebreak()

[5] 10-3. 8~11 쪽

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
  ]
)

[6] 10-3. 15 쪽

#figure(
  image("images/out-06.png", width: wf)
)

#pagebreak()

[7] 10-3. 18 쪽

#figure(
  image("images/out-07.png", width: wf)
)

[8] 10-3. 20~21 쪽

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-08-1.png", width: ws2)
    )
  ], [
    #figure(
      image("images/out-08-2.png", width: ws2)
    )
  ]
)

#pagebreak()
[9] 11-2. 13~14 쪽
#figure(
  image("images/out-09.png", width: wf)
)

#table(
  columns: 4,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/ui-09-1-1.png", width: ws2)
    )
  ], [
    #figure(
      image("images/ui-09-1-2.png", width: ws2)
    )
  ], [
    #figure(
      image("images/ui-09-2-1.png", width: ws2)
    )
  ], [
    #figure(
      image("images/ui-09-2-1.png", width: ws2)
    )
  ]
)

#pagebreak()

[10] 11-2. 16~17 쪽

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-10.png", width: ws2)
    )
  ], [
    #figure(
      image("images/ui-10.png", width: wf)
    )
  ]
)

[11] 11-2. 20 쪽

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-11.png", width: ws2)
    )
  ], [
    #figure(
      image("images/ui-11.png", width: wf)
    )
  ]
)

#pagebreak()

[12] 11-2. 25~30 쪽

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-12-1.png", width: ws2)
    )
  ], [
    #figure(
      image("images/ui-12-1.png", width: wf)
    )
  ]
)

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-12-2-1.png", width: ws2)
    )
  ],
  [
    #figure(
      image("images/out-12-2-2.png", width: ws2)
    )
  ], 
  [
    #figure(
      image("images/out-12-2-3.png", width: ws2)
    )
  ],
  [
    #figure(
      image("images/out-12-2-4.png", width: ws2)
    )
  ]
)

#figure(
  image("images/ui-12-2.png", width: wf)
)

[13] 11-3. 7 쪽

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-13.png", width: ws2)
    )
  ], [
    #figure(
      image("images/ui-13.png", width: wf)
    )
  ]
)

#pagebreak()

[14] 11-3. 11~12 쪽

#figure(
  image("images/out-14.png", width: wf)
)

#table(
  columns: 4,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/ui-14-1.png", width: ws2)
    )
  ], [
    #figure(
      image("images/ui-14-2.png", width: ws2)
    )
  ], [
    #figure(
      image("images/ui-14-3.png", width: ws2)
    )
  ], [
    #figure(
      image("images/ui-14-4.png", width: ws2)
    )
  ]
)

#pagebreak()

[15] 11-3. 22 쪽

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-15.png", width: ws2)
    )
  ], [
    #figure(
      image("images/ui-15.png", width: wf)
    )
  ]
)

[16] 11-3. 27~31 쪽

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-16-1.png", width: ws2)
    )
  ], [
    #figure(
      image("images/ui-16-1.png", width: ws2)
    )
  ], [
    #figure(
      image("images/out-16-2.png", width: ws2)
    )
  ], [
    #figure(
      image("images/ui-16-2.png", width: ws2)
    )
  ]
)
