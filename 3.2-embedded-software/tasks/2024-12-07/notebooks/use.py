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
