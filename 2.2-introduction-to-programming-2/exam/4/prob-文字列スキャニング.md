# 문제 4: 문자열 스캐닝

한 줄 문자열 `s`가 입력된다.
이 문자열에서

- 단어 개수
- 가장 긴 단어

를 구해 출력하라.

## 단어 정의

- 단어는 공백 문자가 아닌 문자가 1개 이상 연속한 부분 문자열
- 공백 문자는 `space`, `tab`, `newline` 등 `isspace`로 판정되는 문자

## 입력

- 한 줄 문자열 `s`

## 출력

다음 두 줄을 출력한다.

```text
Words: <단어 수>
Longest word: <가장 긴 단어>
```

규칙:

- 가장 긴 단어가 여러 개면 가장 먼저 등장한 단어 출력
- 단어가 하나도 없으면
	- `Words: 0`
	- `Longest word:` (콜론 뒤 비워둠)

## 입출력 예 1

입력:

```text
cat dog bird fish
```

출력:

```text
Words: 4
Longest word: bird
```

## 입출력 예 2

입력:

```text
AI-2025 is the best-of-the-best system!!
```

출력:

```text
Words: 5
Longest word: best-of-the-best
```

## 입출력 예 3

입력:

```text
The quick brown fox jumps over the lazy dog multiple times and still manages to surprise everyone with incredible agility
```

출력:

```text
Words: 20
Longest word: incredible
```

