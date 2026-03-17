# 문제 1: 영수증 발행

슈퍼마켓에서 구매한 상품 목록을 입력받아 영수증을 출력하는 프로그램을 작성하라.

## 규칙

1. 상품 개수 `N`(최대 10)을 입력받는다.
2. 각 상품에 대해 `상품명`, `단가`, `수량`을 입력받는다.
3. 소비세율은 상품명 길이로 결정한다.
- 상품명 길이 5자 이상: 10%
- 상품명 길이 4자 이하: 8%
4. 각 상품의 세금 포함 소계를 계산한다.
- `소계 = round(단가 x 수량 x (1 + 세율))`
5. 모든 상품의 “세전 합계”가 5000엔 이상이면, 세전 합계에 3% 할인을 적용한다.
6. 할인 적용 후 최종 합계(세금 포함)를 출력한다.

## 입력

```text
N
itemName_1 itemPrice_1 itemQuantity_1
...
itemName_N itemPrice_N itemQuantity_N
```

- `1 <= N <= 10`
- `itemName`: 공백 없는 문자열
- `itemPrice`, `itemQuantity`: 정수

## 출력

```text
itemName_1 : subtotalAfterTax_1 yen
...
itemName_N : subtotalAfterTax_N yen
Total : finalAfterTax yen
```

## 입출력 예 1

입력:

```text
3
apple 120 3
milk 150 2
bread 100 1
```

출력:

```text
apple : 396 yen
milk : 324 yen
bread : 110 yen
Total : 830 yen
```

## 입출력 예 2

입력:

```text
2
orange 200 5
egg 300 2
```

출력:

```text
orange : 1100 yen
egg : 648 yen
Total : 1748 yen
```

## 입출력 예 3

입력:

```text
3
banana 300 10
tea 200 5
coffee 500 4
```

출력:

```text
banana : 3300 yen
tea : 1080 yen
coffee : 2200 yen
Total : 6383 yen
```
