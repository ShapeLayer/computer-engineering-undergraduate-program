1. 풀링 레이어를 사용하는 이유를 설명하여라
2. 컨볼루션 신경망을 사용하는 이유를 설명하여라
3. LSTM과 RNN의 차이를 설명하여라
4. 데이터 증대 기법을 사용하는 이유를 설명하여라
5. DNN 사용 시 발생하는 가중치 소실을 수치적으로 그래프를 그려서 설명하여라
6. 다음은 시그모이드 함수의 계산 그래프이다. 빈 칸을 채워라
7. 덧셈 노드와 곱셈 노드의 순전파와 역전파 계산 그래프를 그려라.
8. 코드를 읽은 후, 내용의 빈 칸을 채워라.
    ```py
    model = Sequential()
    model.add(Conv2D(64, activation='relu', kernel_size=(3, 3), input_shape=(32, 32, 3)))
    model.add(MaxPooling2D(pool_size=(2, 2)))
    model.add(Conv2D(32, activation='relu', kernel_size=(3, 3)))
    model.add(Flatten())
    model.add(Dense(80, activation='relu'))
    model.add(Dense(10, activation='softmax'))
    model.summary()
    ```
    ```
    Model: "sequential"
    ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┓
    ┃ Layer (type)                    ┃ Output Shape           ┃       Param # ┃
    ┡━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━┩
    │ conv2d (Conv2D)                 │ (None, __, __, __)     │         _____ │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ max_pooling2d (MaxPooling2D)    │ (None, __, __, __)     │         _____ │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ conv2d_1 (Conv2D)               │ (None, __, __, __)     │         _____ │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ flatten (Flatten)               │ (None, __)             │         _____ │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ dense (Dense)                   │ (None, __)             │         _____ │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ dense_1 (Dense)                 │ (None, __)             │         _____ │
    └─────────────────────────────────┴────────────────────────┴───────────────┘
    Total params: _____
    Trainable params: _____
    Non-trainable params: _____
    ```

9. 코드를 읽은 후, 내용의 빈 칸을 채워라.
    ```py
    model = Sequential()
    model.add(Conv2D(kernel_size=3, filters=32, padding='same', input_shape=(32, 32, 3)))
    model.add(Activation('relu'))
    model.add(Conv2D(kernel_size=3, filters=32, padding='same'))
    model.add(Activation('relu'))
    model.add(MaxPool2D(pool_size=(2, 2), strides=2, padding='same'))
    model.add(Conv2D(kernel_size=3, filters=64, padding='same'))
    model.add(Activation('relu'))
    model.add(Conv2D(kernel_size=3, filters=64, padding='same'))
    model.add(Activation('relu'))
    model.add(MaxPool2D(pool_size=(2, 2), strides=2, padding='same'))
    model.add(Conv2D(kernel_size=3, filters=128, padding='same'))
    model.add(Activation('relu'))
    model.add(Conv2D(kernel_size=3, filters=128, padding='same'))
    model.add(Activation('relu'))
    model.add(MaxPool2D(pool_size=(2, 2), strides=2, padding='same'))
    model.add(Flatten())
    model.add(Dense(256, Activation('relu')))
    model.add(Dense(10, Activation('softmax')))
    model.compile(optimizer=Adam(1e-4), loss='sparse_categorical_crossentropy', metrics=['accuracy'])
    model.summary()
    ```

    ```
    Model: "sequential"
    ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┓
    ┃ Layer (type)                    ┃ Output Shape           ┃       Param # ┃
    ┡━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━┩
    │ conv2d (Conv2D)                 │ (None, __, __, __)     │         _____ │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ activation (Activation)         │ (None, __, __, __)     │         _____ │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ conv2d_1 (Conv2D)               │ (None, __, __, __)     │         _____ │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ activation_1 (Activation)       │ (None, __, __, __)     │         _____ │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ max_pooling2d (MaxPooling2D)    │ (None, __, __, __)     │         _____ │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ conv2d_2 (Conv2D)               │ (None, __, __, __)     │         _____ │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ activation_2 (Activation)       │ (None, __, __, __)     │         _____ │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ conv2d_3 (Conv2D)               │ (None, __, __, __)     │         _____ │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ activation_3 (Activation)       │ (None, __, __, __)     │         _____ │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ max_pooling2d_1 (MaxPooling2D)  │ (None, __, __, __)     │         _____ │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ conv2d_4 (Conv2D)               │ (None, __, __, __)     │         _____ │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ activation_4 (Activation)       │ (None, __, __, __)     │         _____ │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ conv2d_5 (Conv2D)               │ (None, __, __, __)     │         _____ │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ activation_5 (Activation)       │ (None, __, __, __)     │         _____ │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ max_pooling2d_2 (MaxPooling2D)  │ (None, __, __, __)     │         _____ │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ flatten (Flatten)               │ (None, __)             │         _____ │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ dense (Dense)                   │ (None, __)             │         _____ │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ dense_1 (Dense)                 │ (None, __)             │         _____ │
    └─────────────────────────────────┴────────────────────────┴───────────────┘
    Total params: _____
    Trainable params: _____
    Non-trainable params: _____
    ```
