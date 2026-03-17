# 문제 5: 스시 레인 이벤트 처리

스시 레인에는 `N`개의 접시가 왼쪽에서 오른쪽 순서로 놓여 있다.
각 접시는 다음 정보를 가진다.

- 종류 `type` (문자열)
- 신선도 `freshness` (정수)
- 인기점수 `popularity` (정수)

주어지는 이벤트는 1개이며, `eventType` 값에 따라 아래 중 하나를 수행한다.

## 이벤트 1: 신선도 감소 후 제거

- 모든 접시에 대해 `freshness -= D`
- `freshness <= 0`인 접시는 레인에서 제거
- 남은 접시 종류를 순서대로 출력

출력 형식:

```text
Updated Lane: type1 type2 ...
```

## 이벤트 2: 구간 정렬

- 0-indexed 구간 `[L, R]`만 인기점수 내림차순으로 정렬
- 구간 바깥 순서는 유지
- 인기점수가 같을 때의 상대 순서는 자유

출력 형식:

```text
Sorted Lane: type1 type2 ...
```

## 이벤트 3: 고인기 연속 구간 추출

- `popularity >= P`인 접시만 선택
- 선택된 접시가 이루는 연속 구간마다 그룹을 만든다
- 왼쪽부터 그룹 ID를 1, 2, 3 ... 부여

출력 형식:

```text
Saved Group ID X: type1 type2 ...
```

- 해당 구간이 없으면 아무 줄도 출력하지 않음

## 입력

```text
N
type_1 freshness_1 popularity_1
...
type_N freshness_N popularity_N
eventType
```

- `eventType = 1`이면 다음 줄에 `D`
- `eventType = 2`이면 다음 줄에 `L R`
- `eventType = 3`이면 다음 줄에 `P`

## 입출력 예 1 (이벤트 1)

입력:

```text
10
tai 10 7
ebi 8 6
anago 6 3
maguro 4 9
salmon 2 8
hamachi 1 5
kappa 5 1
squid 9 4
egg 8 2
uni 3 7
1
4
```

출력:

```text
Updated Lane: tai ebi anago kappa squid egg
```

## 입출력 예 2 (이벤트 2)

입력:

```text
5
ebi 5 8
salmon 9 7
salmon 8 4
ebi 4 6
maguro 7 10
2
1 3
```

출력:

```text
Sorted Lane: ebi salmon ebi salmon maguro
```

## 입출력 예 3 (이벤트 3)

입력:

```text
7
maguro 5 4
otoro 8 9
ebi 7 8
kappa 4 2
uni 3 9
uni 4 9
squid 8 3
3
8
```

출력:

```text
Saved Group ID 1: otoro ebi
Saved Group ID 2: uni uni
```

