## 4.9
다음 코드 실행 결과 스택에 남은 내용을 작성하라.

```py
q = deque()
for i in range(10):
  if i % 3 == 0:
    q.append(i)
```

```py
q = deque()
for i in range(20):
  if i % 3 == 0:
    q.append(i)
  elif i % 4 == 0:
    q.pop()
```

## 4.13
중위식을 후위식으로 변환하라.

$
(X + Y) - (W * Z) / V
$

## 4.15
후위식을 중위식으로 변환하라.

$
A B C D E * + / +
$

## 5.10
다음 코드 실행 결과 큐에 남은 내용을 작성하라.

```py
q = deque()
for i in range(20):
  if i % 3 == 0:
    q.append(i)
```

```py
q = deque()
for i in range(20):
  if i % 3 == 0:
    q.append(i)
  elif i % 4 == 0:
    q.popleft()
```

## 5.17
우선순위 큐와 거리가 먼 것.
1. 큐에 우선순위 개념 도입
2. 선형 자료구조
3. 입력 순서와 무관하게 순위 높은 순
4. 가장 일반적으로 사용

## 6.7
링크드 리스트에서 중간에 노드를 추가하는 코드의 빈 칸을 채워라.

```py
new_node = Node(N, None)
(?)
pre_node.link = new_node
```

## 6.9
링크드 리스트를 역순으로 변환하는 함수의 빈 칸을 채워라.

```py
def rev(head):
  p, q = head, None
  while p != None:
    r = q
    q = p
    p = p.link
    (?)
  return q
```
