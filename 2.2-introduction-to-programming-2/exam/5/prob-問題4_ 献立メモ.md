# 문제 4: 식단 메모

날짜를 나타내는 4자리 문자열 `MMDD`를 키로,
메뉴명(공백 없는 문자열)을 값으로 저장하는 사전을 관리한다.

먼저 `Q`개의 등록이 주어진다.
같은 날짜가 여러 번 등록되면 마지막 값으로 덮어쓴다.

등록 입력이 끝나면 프로그램은 아래 문구를 출력한다.

```text
a と b を入力
```

그 다음 입력되는 `a`, `b`(둘 다 `MMDD`)에 대해,
`a <= date <= b` 범위의 항목을 날짜 오름차순으로 출력한다.

해당 항목이 없으면 `EMPTY`만 출력한다.

## 입력

```text
Q
date menu
...
a b
```

제약:
- `1 <= Q <= 200000`
- `date`, `a`, `b`: 길이 4 숫자 문자열(`MMDD`)
- `menu`: 공백 없는 문자열

비교는 날짜 문자열의 사전순 비교를 사용한다.

## 출력

1. 먼저 `a と b を入力`
2. 범위 내 항목이 있으면
   - `date menu` 형식으로 날짜 오름차순 출력
3. 없으면
   - `EMPTY`

## 입출력 예 1

입력:

```text
5
0130 curry
0131 sushi
0201 ramen
0131 udon
0210 pizza
0131 0201
```

출력:

```text
a と b を入力
0131 udon
0201 ramen
```

## 입출력 예 2

입력:

```text
3
0130 curry
0201 ramen
0210 pizza
0101 0120
```

출력:

```text
a と b を入力
EMPTY
```

## 입출력 예 3

입력:

```text
18
1231 soba
0707 tanabata
0808 okonomiyaki
0707 somen
0701 curry
0715 yakiniku
0101 osechi
0101 ozoni
0601 salad
0602 ramen
0602 tsukemen
1111 pizza
0909 sushi
1001 udon
0707 kakigori
0708 tempura
0706 unagi
0706 yakitori
0707 0708
```

출력:

```text
a と b を入力
0707 kakigori
0708 tempura
```

## 입출력 예 4

입력:

```text
6
0101 osechi
0102 ozoni
0103 curry
0104 ramen
0105 sushi
0106 udon
0103 0103
```

출력:

```text
a と b を入力
0103 curry
```
