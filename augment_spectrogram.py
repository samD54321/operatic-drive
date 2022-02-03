import random
import numpy as np
from copy import deepcopy


def time_mask(mel_sgram, num_masks, time=1000):
    """
        Performs time masking on the given numpy array.
    """
    sgram_data = deepcopy(mel_sgram)
    max_freq, max_time = mel_sgram.shape
    
    for _ in range(num_masks):
        mask_start = random.randrange(0, max_time)
        mask_end = mask_start + random.randrange(0, time)
        sgram_mean = sgram_data.mean()
        for i in range(max_freq):
            for j in range(max_time):
                if j > mask_start and j < mask_end:
                    sgram_data[i][j] = sgram_mean
    return sgram_data 

def freq_mask(mel_sgram, num_masks, F=10):
    """
        Performs frequency masking on the given numpy array.
    """
    sgram_data = deepcopy(mel_sgram)
    max_freq, max_time = mel_sgram.shape
    
    for _ in range(num_masks):
        mask_start = random.randrange(0, max_freq)
        mask_end = mask_start + random.randrange(0, F)
        sgram_mean = sgram_data.mean()
        for i in range(max_freq):
            for j in range(max_time):
                if i > mask_start and i < mask_end:
                    sgram_data[i][j] = sgram_mean
    return sgram_data 