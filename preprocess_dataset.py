import os
import librosa
import librosa.display
from pathlib import Path 
import numpy as np
import matplotlib as mpl
mpl.use('TkAgg')
import matplotlib.pyplot as plt
from augment_spectrogram import time_mask, freq_mask

plt.figure(figsize=(19.20,10.8))

def load_song(file_name):
    samples, sampling_rate = librosa.load(file_name, sr=None)
    return samples, sampling_rate

def create_spectrogram(samples, sampling_rate, file_name, do_t_mask=False, do_f_mask=False):
    '''
        Create spectrogram of the given decoded audio file.
    '''
    if do_t_mask and do_f_mask:
        raise ValueError("Both time and freq mask can't be true.")

    plt.figure(figsize=(19.20,10.8))

    sgram = librosa.stft(samples)
    sgram_mg, _ = librosa.magphase(sgram)
    mel_scale_sgram = librosa.feature.melspectrogram(S=sgram_mg, sr=sampling_rate)
    mel_sgram = librosa.amplitude_to_db(mel_scale_sgram, ref=np.min)
    if do_t_mask:
        mel_sgram_tmask = time_mask(mel_sgram, 5) 
        librosa.display.specshow(mel_sgram_tmask, sr=sampling_rate)
    elif do_f_mask:
        mel_sgram_fmask = freq_mask(mel_sgram, 5) 
        librosa.display.specshow(mel_sgram_fmask, sr=sampling_rate)
    else:
        librosa.display.specshow(mel_sgram, sr=sampling_rate)
    plt.savefig(file_name)

def load_dataset():
    '''
        Preprocess all the songs in our dataset.
    '''
    NO_SONGS = 1000
    SONG_COUNTER = 0
    # Create the filename.
    base_dir = Path('/home/nishan/Music/clips_full')
    project_base_dir = Path('/home/nishan/Workspace2/minor')
    # Check if directory exists
    print(os.path.isdir(os.path.join(project_base_dir, 'processed_dataset')))
    if os.path.isdir(os.path.join(project_base_dir, 'processed_dataset')) == False:
        os.mkdir(os.path.join(project_base_dir, 'processed_dataset'))
        os.mkdir(os.path.join(project_base_dir, 'processed_dataset/train'))
        os.mkdir(os.path.join(project_base_dir, 'processed_dataset/test'))
    # Loop over every song in the base_dir.
    for i in range(NO_SONGS+1):
        #print("Song:" +  str(i))
        SONG_COUNTER += 1
        # Check if the song exists.
        raw_file_name = str(i) + '.mp3'
        full_file_path = os.path.join(base_dir, raw_file_name) #base_dir + raw_file_name
        #print("Full_File_Path: " + full_file_path)
        print(full_file_path)
        print(os.path.isfile(full_file_path))
        if os.path.isfile(full_file_path):
            print("Full_File_Path: " + full_file_path)
            # Load the song and create its spectrograms.
            # Give the number of times it's to be masked.
            # Save in either test or train folder.
            samples, sampling_rate = load_song(full_file_path)
            # Create a folder for our song.
            

            if SONG_COUNTER <= 619:
                # Save to train folder.
                final_directory_name = 'processed_dataset/train/' + str(i)
                final_directory_name = os.path.join(project_base_dir, final_directory_name)
                if os.path.exists(final_directory_name) == False:
                    os.mkdir(final_directory_name)
                # Save the original
                final_file_name = final_directory_name + '/original.jpg'
                create_spectrogram(samples, sampling_rate, final_file_name)
                # Save the time_masked_spectrogram
                for i in range(5):
                    final_file_name = final_directory_name + '/time_masked_' + str(i) + ".jpg"
                    create_spectrogram(samples, sampling_rate, final_file_name, do_t_mask=True)
                # Save the freq_masked spectrogram
                for i in range(5):
                    final_file_name = final_directory_name + '/freq_masked_' + str(i) + ".jpg"
                    create_spectrogram(samples, sampling_rate, final_file_name, do_f_mask=True)    
            else: 
                # Save to test folder.
                final_directory_name = 'processed_dataset/test/' + str(i)
                os.mkdir(final_directory_name)
                # Save the original
                final_file_name = final_directory_name + '/original.jpg'
                create_spectrogram(samples, sampling_rate, final_file_name)
                # Save the time_masked_spectrogram
                for i in range(5):
                    final_file_name = final_directory_name + '/time_masked_' + str(i) + ".jpg"
                    create_spectrogram(samples, sampling_rate, final_file_name, time_mask=True)
                # Save the freq_masked spectrogram
                for i in range(5):
                    final_file_name = final_directory_name + '/freq_masked_' + str(i) + ".jpg"
                    create_spectrogram(samples, sampling_rate, final_file_name, freq_mask=True) 


if __name__=="__main__":
    # Call the method on all of the songs.
    plt.figure(figsize=(19.20,10.8))
    load_dataset()
