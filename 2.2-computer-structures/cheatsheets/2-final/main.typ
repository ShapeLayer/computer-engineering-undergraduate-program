#import "@preview/cetz:0.2.2"
#import "@preview/fletcher:0.5.0" as fletcher: diagram, node, edge
#import cetz.draw: *

#let subtext(content) = {
  text(size: .5em, fill: luma(40%))[#content]
}
#set page("a4",
  flipped: true,
  columns: 3,
  margin: (x: 10pt, y: 10pt),
  header: subtext([컴퓨터구조 기말고사 오픈북 대응 Cheat Sheet]),
  footer: subtext(align(right)[by Park, Jonghyeon])
)
#let serif = ("Noto Serif CJK KR", )
#let sans = ("Noto Sans CJK KR", "Gothic A1", )
#set text(
  font: serif,
  size: 6pt
)
#set table(
  stroke: .05em,
  align: horizon,
  inset: 3pt
)
#let c(content) = {
  table.cell(align: center + horizon)[#content]
}

= 3장. 컴퓨터 산술과 논리 연산
= 5장. 기억장치
- 주기억장치 / 보조저장장치
- 내부 기억장치: CPU 직접 제어 / 외부 기억장치: 제어기 통해 제어
== 5.1. 기억장치 분류와 특성
- 순차적 액세스: 처음부터 순차적으로 액세스 (자기테이프)
- 직접 액세스: 근처로 이동한 후 순차 검색 (자기디스크, CD)
- 임의 액세스: 어디를 액세스하든 일정한 유형 (반도체)
- 연관 액세스: 액세스 요청에 비트 패턴 있음 $=>$ 패턴으로 찾음 (일정)
\
- 주요 특성: 용량 / 액세스 속도
- 전송 단위: 한번의 액세스로 읽을 수 있는 단위 (~= word)
- 블록: 단어보다 큰 단위의 전송 단위
\
- 주소지정 단위: 하나의 주소에 의해 액세스되는 비트들의 그룹\
  주소비트 수 $A$, 주소지정 가능 기억 장소 수 $N$ $=>$ $2^A=N$\
  주소 지정 가능한 기억장치 용량: $N$ 바이트\
  $A$개의 주소 비트들로 주소지정 가능한 전체 용량: $N$ 단어, $4N$바이트
\
*기억장치의 주요한 특성*
- 액세스 시간: $triangle$(R/W 신호의 장치 도달 순간, R/W동작 완료되는 순간의 시간)
- 기억장치 사이클 시간: 액세스 시간 + 데이터 복원 시간(자기 코어 등에서만)
- 데이터 전송률: 초당 R/W 가능한 비트 수 \
  \= (1/액세스 시간)$times$(한번 읽히는 데이터 바이트 수)
== 5.2 계층적 기억장치시스템
- 속도가 빠를 수록 가격이 높아져서 용량을 무한정 증가시킬 수 없기 때문에 계층적으로 tradeoff
- *지역성의 원리*
=== 5.3. 반도체 지역장치
==== RAM: Random Access Memory
- `ADDRESS`$times$`SIZE` 용량의 RAM
  - `BITLEN`(`ADDRESS`) 개의 주소 선 필요
  - `SIZE` 개의 출력 선 필요
- i.e. 16$times$4 비트 조직
  - 4개의 주소 선 필요
  - 4개의 출력 선 필요

- RAS: Row Address Strobe: 행 주소 래치 신호
- CAS: Column Address Strobe: 열 주소 래치 신호
==== ROM: Read Only Memory
- PROM: Programmable ROM
- EPROM: Erasable PROM
- EEPROM: Electrically Erasable PROM
- Flash Memory

