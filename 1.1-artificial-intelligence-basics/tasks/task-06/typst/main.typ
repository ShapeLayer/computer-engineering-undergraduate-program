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

Homework 06
\

\
이름: 박종현\
학번: 214823

\

== Caution

1. 수업 자료에서 사용하는 라이브러리의 버전과 실행 환경에서 사용하는 라이브러리의 버전이 달라, 자료의 코드를 조금 수정하여 대응하였습니다. \
  - 익명 Q&A 게시판 21번 게시물,	"과제 6 수행 중 발생하는 문제 및 해결책 정리: keras_model.h5, Image.ANTIALIAS, df.append 관련" #text(fill: blue)[#underline[https://sel.jnu.ac.kr/mod/ubboard/article.php?id=1134310&bwid=700874]]
2. 스크린샷에 이름과 학번이 포함되어야한다는 조건을 충족하기 위해, 터미널 타이틀 바에 이름과 학번이 나오도록 설정하였습니다. (2번 과제부터 적용)

== Content

[1] 12-1. 5~10 쪽

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-01-1.png", width: ws2)
    )
  ], [
    #figure(
      image("images/out-01-2.png", width: ws2)
    )
  ], [
    #figure(
      image("images/out-01-2.png", width: ws2)
    )
  ],
  [
    #figure(
      image("images/out-01-4.png", width: wf)
    )
  ]
)



[2] 12-1. 27~29 쪽 

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


#pagebreak()

[3] 12-3. 14 쪽

#figure(
  image("images/out-03.png", width: wf)
)


[4] 12-3. 16 쪽

#figure(
  image("images/out-04.png", width: wf)
)

#pagebreak()

[5] 12-3. 18~20 쪽

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-05-1.png", width: ws2)
    )
  ], [
    #figure(
      image("images/out-05-2.png", width: ws2)
    )
  ], [
    #figure(
      image("images/out-05-3.png", width: ws2)
    )
  ], [
    #figure(
      image("images/out-05-4.png", width: ws2)
    )
  ]
)

#pagebreak()

[6] 12-3. 24~28 쪽

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-06-1.png", width: ws2)
    )
  ], [
    #figure(
      image("images/out-06-2.png", width: ws2)
    )
  ], [
    #figure(
      image("images/out-06-3.png", width: ws2)
    )
  ], [
    #figure(
      image("images/out-06-4.png", width: ws2)
    )
  ]
)

#pagebreak()

[7] 13-1. 15~16 쪽

#figure(
  image("images/out-07.png", width: wf)
)

[8] 13-1. 19~23 쪽

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

[9] 13-1. 28~32 쪽

#figure(
  image("images/out-09-1.png", width: wf)
)
#figure(
  image("images/out-09-2.png", width: wf)
)
#figure(
  image("images/out-09-3.png", width: wf)
)

[10] 13-2. 11~12 쪽

#figure(
  image("images/out-10.png", width: wf)
)

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/fig-10-1.png", width: ws2)
    )
  ], [
    #figure(
      image("images/fig-10-3.png", width: ws2)
    )
  ]
)

[11] 13-2. 14~19 쪽

#figure(
  image("images/out-11-1.png", width: wf)
)

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/fig-11-1-1.png", width: ws2)
    )
  ], [
    #figure(
      image("images/fig-11-1-2.png", width: ws2)
    )
  ]
)

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-11-2.png", width: ws2)
    )
  ], [
    #figure(
      image("images/fig-11-2.png", width: ws2)
    )
  ]
)

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-11-3.png", width: ws2)
    )
  ], [
    #figure(
      image("images/fig-11-3.png", width: ws2)
    )
  ]
)

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-11-4.png", width: ws2)
    )
  ], [
    #figure(
      image("images/fig-11-4.png", width: ws2)
    )
  ]
)

#pagebreak()

[12] 13-2. 25~26 쪽

#figure(
  image("images/out-12.png", width: wf)
)

#figure(
  image("images/fig-12.png", width: wf)
)

[13] 13-2. 28 쪽

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
      image("images/fig-13.png", width: ws2)
    )
  ]
)

[14] 13-3. 18~23 쪽


#figure(
  image("images/out-14-1.png", width: wf)
)

#figure(
  image("images/out-14-2.png", width: wf)
)

#figure(
  image("images/out-14-3.png", width: wf)
)

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-14-4.png", width: ws2)
    )
  ], [
    #figure(
      image("images/fig-14-4.png", width: ws2)
    )
  ]
)

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-14-5.png", width: ws2)
    )
  ], [
    #figure(
      image("images/fig-14-5.png", width: ws2)
    )
  ]
)

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-14-6.png", width: ws2)
    )
  ], [
    #figure(
      image("images/fig-14-6.png", width: ws2)
    )
  ]
)

#pagebreak()

[15] 13-3. 25~28 쪽

#figure(
  image("images/out-15-1.png", width: wf)
)

#table(
  columns: 2,
  inset: 0pt,
  stroke: none,
  [
    #figure(
      image("images/out-15-2.png", width: ws2)
    )
  ], [
    #figure(
      image("images/out-15-3.png", width: ws2)
    )
  ]
)

#pagebreak()

[16] 13-3. 29~31 쪽

#figure(
  image("images/out-16.png", width: wf)
)

#figure(
  image("images/fig-16.png", width: wf)
)
