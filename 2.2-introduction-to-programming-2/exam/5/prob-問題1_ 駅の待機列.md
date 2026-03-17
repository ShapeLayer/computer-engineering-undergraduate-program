# 문제 1: 역 대기열

역에는 다음 두 개의 대기 구조가 있다.

- 홈 대기열: 먼저 줄 선 사람부터 탑승하는 일반 큐(FIFO)
- 환승 도선(임시 레인): 마지막에 들어온 사람이 먼저 탑승하는 스택(LIFO)

이벤트를 위에서부터 순서대로 처리하고, `WHO`가 나올 때마다 “다음에 탑승할 사람”을 출력하라.

## 규칙

### 1) 홈 대기열

- 기본적으로 승객은 홈 대기열 뒤에 선다.
- 탑승 시 홈 대기열에서는 맨 앞 사람이 먼저 탑승한다.

### 2) 환승 도선(임시 레인)

- `TRANSFER k`가 발생하면, 홈 대기열의 맨 뒤에서 최대 `k`명을 꺼내 환승 도선에 옮긴다.
- 홈 대기열 인원이 `k`보다 적으면 가능한 인원 전부를 옮긴다.
- 꺼낸 사람들을 환승 도선에 넣을 때는 “홈 대기열에 있던 상대적 순서”를 유지해서 넣는다.
	- 예: 홈 대기열이 `[Mei, Ken, Yui]`, `k=2`이면 옮겨지는 집합은 `[Ken, Yui]`이며, 이 순서로 도선에 들어간다.
- 환승 도선에서 탑승할 때는 마지막에 들어간 사람이 먼저 탑승한다.
- `TRANSFER`는 여러 번 발생할 수 있고, 환승 도선의 기존 내용은 유지된 채로 위에 계속 쌓인다.

## 이벤트 종류

### `ENTER name`

- `name`이 홈 대기열 맨 뒤에 들어간다.

### `TRANSFER k`

- 홈 대기열 맨 뒤에서 최대 `k`명을 꺼내 환승 도선에 옮긴다.

### `BOARD`

- 실제로 1명이 탑승한다. 우선순위는 다음과 같다.
1. 환승 도선이 비어 있지 않으면, 환승 도선의 맨 위(가장 최근 이동자) 탑승
2. 그렇지 않고 홈 대기열이 비어 있지 않으면, 홈 대기열 맨 앞 탑승
3. 둘 다 비어 있으면 아무 일도 하지 않음

### `WHO`

- “다음에 탑승할 사람”을 출력한다.
1. 환승 도선이 비어 있지 않으면, 환승 도선 맨 위 이름 출력
2. 아니면 홈 대기열 맨 앞 이름 출력
3. 둘 다 비어 있으면 `EMPTY` 출력

## 입력

- 첫 줄: 이벤트 수 `N`
- 다음 `N`줄: 이벤트(`ENTER`, `TRANSFER`, `BOARD`, `WHO`)가 한 줄에 하나씩 주어진다.

제약:

- `1 <= N <= 200000`
- `name`은 영문 대소문자와 숫자로만 이루어진 길이 `1` 이상 `20` 이하 문자열
- `TRANSFER k`에서 `0 <= k <= 200000`

## 출력

- 각 `WHO` 이벤트마다 결과를 한 줄에 하나씩 출력한다.

## 입출력 예 1

입력:

```text
9
ENTER Mei
ENTER Ken
ENTER Yui
TRANSFER 2
WHO
BOARD
WHO
BOARD
WHO
```

출력:

```text
Yui
Ken
Mei
```

## 입출력 예 2

입력:

```text
10
WHO
ENTER Aki
WHO
TRANSFER 5
WHO
BOARD
WHO
BOARD
WHO
WHO
```

출력:

```text
EMPTY
Aki
Aki
EMPTY
EMPTY
EMPTY
```

## 입출력 예 3

입력:

```text
15
ENTER Hana
ENTER Taro
ENTER Sora
TRANSFER 0
WHO
TRANSFER 1
WHO
BOARD
WHO
TRANSFER 2
WHO
BOARD
WHO
BOARD
WHO
```

출력:

```text
Hana
Sora
Hana
Taro
Hana
EMPTY
```

## 입출력 예 4

입력:

```text
12
ENTER A
ENTER B
ENTER C
TRANSFER 3
BOARD
ENTER D
WHO
TRANSFER 2
WHO
BOARD
WHO
WHO
```

출력:

```text
B
D
A
A
```
