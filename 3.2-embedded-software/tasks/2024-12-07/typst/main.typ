#import "@preview/charged-ieee:0.1.3": ieee


#show: ieee.with(
  title: [#text(font: ("noto serif cjk kr", "Noto Serif KR"))[임베디드 소프트웨어: 손글씨 인식 개인 과제]],
  abstract: [
    #text(font: ("noto serif cjk kr", "Noto Serif KR"))[CNN 실습 과정 중의 MNIST 데이터 학습 실습 내용을 참고하여 손글씨 인식 모델을 새로 학습시켰습니다. 이어서 직접 작성한 0부터 9까지 10개 수를 직접 작성하여 모델의 성능 실험에 사용하였습니다.]
  ],
  authors: (
    (
      name: "Park Jonghyeon",
      department: [#text(font: ("noto serif cjk kr", "Noto Serif KR"))[컴퓨터정보통신공학과]],
      organization: [#text(font: ("noto serif cjk kr", "Noto Serif KR"))[전남대학교 공과대학]],
      email: "jonghyeon@jnu.ac.kr"
    ),
  ),
  index-terms: (),
  figure-supplement: [Fig.],
)
#set text(font: ("noto serif cjk kr", "Noto Serif KR"))

= 모델 정의 및 학습

#show raw: set text(font: "D2Coding")

#text(size: .5em, font: "D2Coding")[
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┓
┃ Layer (type)                    ┃ Output Shape           ┃       Param # ┃
┡━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━┩
│ conv2d (Conv2D)                 │ (None, 28, 28, 32)     │           832 │
├─────────────────────────────────┼────────────────────────┼───────────────┤
│ conv2d_1 (Conv2D)               │ (None, 28, 28, 32)     │        25,632 │
├─────────────────────────────────┼────────────────────────┼───────────────┤
│ max_pooling2d (MaxPooling2D)    │ (None, 14, 14, 32)     │             0 │
├─────────────────────────────────┼────────────────────────┼───────────────┤
│ dropout (Dropout)               │ (None, 14, 14, 32)     │             0 │
├─────────────────────────────────┼────────────────────────┼───────────────┤
│ conv2d_2 (Conv2D)               │ (None, 14, 14, 64)     │        18,496 │
├─────────────────────────────────┼────────────────────────┼───────────────┤
│ conv2d_3 (Conv2D)               │ (None, 14, 14, 64)     │        36,928 │
├─────────────────────────────────┼────────────────────────┼───────────────┤
│ max_pooling2d_1 (MaxPooling2D)  │ (None, 7, 7, 64)       │             0 │
├─────────────────────────────────┼────────────────────────┼───────────────┤
│ dropout_1 (Dropout)             │ (None, 7, 7, 64)       │             0 │
├─────────────────────────────────┼────────────────────────┼───────────────┤
│ flatten (Flatten)               │ (None, 3136)           │             0 │
├─────────────────────────────────┼────────────────────────┼───────────────┤
│ dense (Dense)                   │ (None, 128)            │       401,536 │
├─────────────────────────────────┼────────────────────────┼───────────────┤
│ dropout_2 (Dropout)             │ (None, 128)            │             0 │
├─────────────────────────────────┼────────────────────────┼───────────────┤
│ dense_1 (Dense)                 │ (None, 10)             │         1,290 │
└─────────────────────────────────┴────────────────────────┴───────────────┘
```
]

\
= 성능 실험

이렇게 학습시킨 모델의 성능을 확인하기 위해 직접 0부터 9까지 10개 수를 4회 작성하였습니다. 몇 개 수는 필체를 조금씩 변주하였으나, 대부분의 경우 동일한 필체입니다.

#figure(
  caption: [추정 테스트에 사용한 손글씨 데이터],
  image("assets/handwritten.jpeg")
)

== 전처리

이렇게 수기 작성한 40개 수는 이미지 편집 프로그램을 이용하여 40개의 이미지 파일로 분할하였습니다. 이후에 코드에서 추가 전처리를 수행할 수 있으므로, 이미지 파일의 해상도와 종횡비를 고려하지 않았습니다. 각 파일의 해상도는 일정하지 않습니다.

#figure(
  caption: [각 수에 대한 정답 데이터 생성],
  ```py
  for i in range(1, 41):
    with open(f'slice{i}.index.txt') as f:
      f.write(f'{(f - 1) // 4}')
  ```
)

#figure(
  caption: [손글씨 이미지 분할 및 정답 데이터 생성],
  placement: top,
  image("assets/handwritten_files.png")
)

이와 같이 생성한 데이터는 성능 평가 과정에서 그레이스케일, $28 times 28$ 픽셀 해상도로 변환하여 모델에 입력합니다. 이와 같이 변환한 것은 1채널 $28 times 28$ 벡터로 모델의 입력층을 설정하였기 때문입니다.


= 성능 평가

성능 평가 결과는 @result-a 와 @result-b 를 참조해주십시오.

최초의 성능 평가는 부적절한 전처리를 거쳐 제대로 추정하지 못했습니다. 모델 학습에 사용한 MNIST 데이터는 배경을 $0$, 획을 $1$로 처리하였습니다. 이에 반해 성능 부적절한 전처리를 거쳐 성능 평가를 수행할 때는 배경을 $1$, 획을 $0$으로 처리하였기 때문에 모든 시도에서 결과를 제대로 추정하지 못했습니다.

이 전처리 문제를 해결한 뒤에는 시도 \#17 \#22 \#27 등과 같이 5개 시도를 제외하고는 정확한 결과를 도출하여 $87.5%$의 정확도를 보였습니다.
\

= 부록
== 손글씨 데이터

#let n = 1
#grid(
  columns: 2,
  inset: 1pt,
  align: center + horizon,
  ..while n < 40 {
    n = n + 1
    (figure(
      caption: "시도 #" + str(n) + "에 사용한 손글씨 데이터",
      image("assets/handwritten/slice" + str(n) + ".jpg")
    ),)
  }
)

== 적절한 전처리를 거친 데이터의 평가 결과 <result-a>

#let n = 1
#grid(
  columns: 2,
  inset: 1pt,
  align: center + horizon,
  ..while n < 40 {
    n = n + 1
    (figure(
      caption: "시도 #" + str(n) + "의 추정 결과",
      image("assets/out/preprocessed/result" + str(n) + ".png")
    ),)
  }
)

== 부적절한 전처리를 거친 데이터의 평가 결과 <result-b>

#let n = 1
#grid(
  columns: 2,
  inset: 1pt,
  align: center + horizon,
  ..while n < 40 {
    n = n + 1
    (figure(
      caption: "시도 #" + str(n) + "의 추정 결과",
      image("assets/out/invalid-preprocessed/result" + str(n) + ".png")
    ),)
  }
)
#set page(columns: 1)

== 소스코드

=== `use.py`
```py
import tensorflow as tf
import numpy as np
from PIL import Image
import matplotlib.pyplot as plt

model = tf.keras.models.load_model('model.keras')

def load_and_predict(image_path):
    img = Image.open(image_path).convert('L').resize((28, 28))
    
    img_array = np.array(img)
    img_array = img_array.astype('float32') / 255.0
    img_array = 1 - img_array
    
    img_array = np.expand_dims(img_array, axis=0)
    
    predictions = model.predict(img_array)
    
    return predictions

import pathlib

def main():
    basepath = pathlib.Path('assets/handwritten')
    for i in range(1, 41):
        image_path = basepath / f'slice{i}.jpg'
        index_path = basepath / f'slice{i}.index.txt'
        result = load_and_predict(image_path)
        print(f'Image {i}:')
        index = -1
        with open(index_path, 'r') as f:
            index = int(f.read())
            print(f'Expected: {index}')
        print(f'Predictions: {tf.math.argmax(result, axis=1)[0]}')
        print(result)
        print(tf.nn.softmax(result))

        x_axis = np.arange(10)
        plt.xticks(range(10), range(10))
        plt.bar(x_axis - .2, [0 if i != index else 1 for i in range(10)], .4, label='Expected')
        plt.bar(x_axis + .2, result[0], .4, label='Predictions')
        plt.legend()
        plt.savefig(f'assets/out/preprocessed/result{i}.png', dpi=300)
        plt.clf()

if __name__ == '__main__':
    main()

```