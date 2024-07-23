#let layout(body) = {
  set page("a4",
    margin: (x: 3em, y: 2em)
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

Homework 07
\

\
이름: 박종현\
학번: 214823

\

[1] 14-1. 8~16 쪽

#figure(
  image("images/out-1-1.png", width: wf)
)
#figure(
  image("images/out-1-2.png", width: wf)
)
#figure(
  image("images/out-1-3.png", width: wf)
)
#figure(
  image("images/out-1-4.png", width: wf)
)

#pagebreak()
[2] 14-1. 17~18 쪽

#figure(
  image("images/out-2-1.png", width: wf)
)
#figure(
  image("images/out-2-2.png", width: wf)
)

#pagebreak()
[3] 14-1. 23~25 쪽

#figure(
  image("images/out-3-1.png", width: wf)
)
#figure(
  image("images/out-3-2.png", width: wf)
)

#pagebreak()
[4] 14-1. 32~35 쪽
#figure(
  image("images/out-4-1.png", width: wf)
)
#figure(
  image("images/out-4-2.png", width: wf)
)
#pagebreak()
[5] 14-2. 7~11 쪽

#figure(
  image("images/out-5-1.png", width: wf)
)
#figure(
  image("images/out-5-2.png", width: wf)
)
#figure(
  image("images/out-5-3.png", width: wf)
)

[6] 14-2. 22~28 쪽
#figure(
  image("images/out-6-1.png", width: wf)
)
#figure(
  image("images/out-6-2.png", width: wf)
)
#figure(
  image("images/out-6-3.png", width: wf)
)
#figure(
  image("images/out-6-4.png", width: wf)
)
#figure(
  image("images/out-6-5.png", width: wf)
)

#pagebreak()
[7] 14-3. 9~15 쪽

#figure(
  image("images/out-7-1.png", width: wf)
)
#figure(
  image("images/out-7-2.png", width: wf)
)
#figure(
  image("images/out-7-3.png", width: wf)
)
#figure(
  image("images/out-7-4.png", width: wf)
)
#figure(
  image("images/out-7-5.png", width: wf)
)

[8] 14-3. 24~29 쪽

#figure(
  image("images/out-8-1.png", width: wf)
)
#figure(
  image("images/out-8-2.png", width: wf)
)
#figure(
  image("images/out-8-3.png", width: wf)
)
#figure(
  image("images/out-8-4.png", width: wf)
)

[9] 14-3. 34~38 쪽

#figure(
  image("images/out-9-1.png", width: wf)
)
#figure(
  image("images/out-9-2.png", width: wf)
)
#figure(
  image("images/out-9-3.png", width: wf)
)
#figure(
  image("images/out-9-4.png", width: wf)
)
#figure(
  image("images/out-9-5.png", width: wf)
)
#figure(
  image("images/out-9-6.png", width: wf)
)
