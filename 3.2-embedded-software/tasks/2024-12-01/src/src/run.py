import pyaudio
from array import array

import numpy as np
from scipy import signal
class AudioHandler:
    def __init__(self):
        self.CHUNK = 1024
        self.FORMAT = pyaudio.paInt16
        self.CHANNELS = 1
        self.RATE = 44100
        self.SILENCE_THRESHOLD = 1000  # Adjust this value based on your mic
        self.SILENCE_CHUNKS = 30  # How many chunks of silence before stopping
        
    def record_until_silence(self):
        p = pyaudio.PyAudio()
        stream = p.open(format=self.FORMAT,
                       channels=self.CHANNELS,
                       rate=self.RATE,
                       input=True,
                       frames_per_buffer=self.CHUNK)
        
        print("Listening... Speak now!")
        
        frames = []
        silent_chunks = 0
        is_speaking = False
        
        while True:
            data = stream.read(self.CHUNK)
            array_data = array('h', data)
            max_volume = max(abs(vol) for vol in array_data)
            
            # If sound is above threshold, record
            if max_volume > self.SILENCE_THRESHOLD:
                is_speaking = True
                silent_chunks = 0
                frames.append(data)
            
            # If we were speaking but now there's silence
            elif is_speaking:
                frames.append(data)
                silent_chunks += 1
                
                # If enough silence, stop recording
                if silent_chunks > self.SILENCE_CHUNKS:
                    break
        
        print("Done recording")
        
        stream.stop_stream()
        stream.close()
        p.terminate()
        
        return frames

    def frames_to_waveform(self, frames):
        # Convert frames to numpy array
        audio_data = np.frombuffer(b''.join(frames), dtype=np.int16)
        
        # Normalize to [-1, 1] float
        audio_float = audio_data.astype(np.float32) / 32767.0
        
        # Resample from 44100 to 16000
        samples = int(len(audio_float) * 16000 / self.RATE)
        resampled = signal.resample(audio_float, samples)
        
        # Pad/trim to exactly 16000 samples
        if len(resampled) > 16000:
            resampled = resampled[:16000]
        else:
            resampled = np.pad(resampled, (0, 16000 - len(resampled)))
            
        return tf.convert_to_tensor(resampled, dtype=tf.float32)

import tensorflow as tf

def record_and_pred():
    audio_handler = AudioHandler()
    frames = audio_handler.record_until_silence()
    waveform = audio_handler.frames_to_waveform(frames)

    imported = tf.saved_model.load("saved")
    res = imported(waveform[tf.newaxis, :])

    print(res)

    from train import commands
    import matplotlib.pyplot as plt
    plt.bar(commands, tf.nn.softmax(res['predictions'])[0])
    plt.show()

from os import mkdir
from train import commands
import matplotlib.pyplot as plt
import pathlib
def manual_human_testing():
    audio_handler = AudioHandler()
    imported = tf.saved_model.load("saved")
    runout = pathlib.Path('run.out')
    epoch = 30
    if not runout.exists():
        mkdir(runout)
    results = []
    for i in range(1, epoch+1):
        frames = audio_handler.record_until_silence()
        waveform = audio_handler.frames_to_waveform(frames)
        res = imported(waveform[tf.newaxis, :])
        _sftmx = tf.nn.softmax(res['predictions'])[0]
        plt.bar(commands, _sftmx)
        plt.savefig(f'run.out/{i}.png', dpi=300)
        plt.close()
        results.append(_sftmx)
        print('saved')
    results_array = np.array(results)
    means = np.mean(results_array, axis=0)
    stds = np.std(results_array, axis=0)

    plt.figure(figsize=(12, 6))
    x = np.arange(len(commands))
    
    # Plot bars with error bars
    plt.bar(x, means, yerr=stds, capsize=5, alpha=0.5, label='mean')
    
    # Plot individual points
    for result in results_array:
        plt.scatter(x, result, color='red', alpha=0.3, s=30)
    
    plt.scatter([], [], color='red', alpha=0.3, label='tests')
    
    plt.xticks(x, commands, rotation=45)
    plt.ylabel('prob')
    plt.legend()
    plt.tight_layout()
    plt.savefig('run.out/summary.png', dpi=300)
    plt.close()

import argparse
def parse_args():
    parser = argparse.ArgumentParser(description='Audio classification tool')
    parser.add_argument('--test', action='store_true')

    return parser.parse_args()

def main():
    args = parse_args()
    
    if args.test:
        manual_human_testing()
    else:
        record_and_pred()

if __name__ == '__main__':
    main()
