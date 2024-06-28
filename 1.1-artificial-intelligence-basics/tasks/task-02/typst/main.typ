#import "@preview/codly:0.2.0": *
#set page("a4",
  margin: (x: 3em, y: 4em)
)
#set text(font: ("Noto Sans CJK KR", "Noto Sans KR"), size: .9em)
#show: codly-init.with()
#codly(languages: (
  py: (name: "Python", icon: "", color: rgb("#3572A5")),
))

#show heading.where(level: 2): it => text(size: 1.4em, it.body + v(.5em))

Homework 02
\

\
이름: 박종현\
학번: 214823

\

[1] 3-3. 30쪽

#figure(
  image("images/out-01.png", width: 60%)
)

[2] 4-1. 9쪽

#figure(
  image("images/out-02.png", width: 60%)
)

[3] 4-1. 16-17쪽

#figure(
  image("images/out-03.png", width: 60%)
)

#pagebreak()

[4] 4-1. 26쪽

#figure(
  image("images/out-04.png", width: 60%)
)

[5] 4-2. 7-10쪽

#figure(
  image("images/out-05.png", width: 30%)
)

[6] 4-3. 6쪽

#figure(
  image("images/out-06.png", width: 40%)
)

#pagebreak()

[7] 4-3. 12쪽

#figure(
  image("images/out-07.png", width: 60%)
)

[8] 4-3. 20-21쪽

#figure(
  image("images/out-08.png", width: 60%)
)
