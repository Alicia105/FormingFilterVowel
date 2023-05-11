# Vowel Filter Eurorack Module 

This project was developed by:

- Alicia CANDE
- Benjamin COLAS
- Mathys DANIEL

Under the supervision of Mr. Papazoglou and Mr. Fiack.

## Project Description

The aim of this project is to create a formant filter for vowels in the form of a Eurorack module. The idea is to have a Eurorack module with two potentiometers representing the coordinates in x and y. This allows us to move a "virtual" point on a plane where certain areas represent vowel sounds. The objective is to filter an input signal to bring out vowel sounds, with the coefficients of this filter being controlled by the potentiometers.

### Part 1:

We modeled our filters in Matlab to easily visualize their feasibility and effect.
Our code is divided into two parts:
- a slicing function, which will permit to allow us to change the inputs in real time in order to evolve the filter we apply
- the vowel filter itself, which will filter our input noise to output only the vowel sound that the user wants in real time


### Part 2:

Transcription of the previously written Matlab code into C.

### Part 3:

Creation of a VCV Rack Plug-In to test our module. The advantage of this is to free us from all memory problems related to our processor and hardware provided.

### Part 4:

Implementation in hardware and deployment of the physical module.

## Sources

- Git Source Projet Fiack: https://github.com/lfiack/witns_wvtbl
- Formation vowels: https://www.singwise.com/articles/vowels-formants-modifications
- Formants definition: https://www.techno-science.net/definition/6667.html
- Formation vowels and frequency profile: http://hyperphysics.phy-astr.gsu.edu/hbase/Music/vowel.html
- Table of vowel frequency values: https://www.researchgate.net/figure/Formant-frequencies-for-English-vowels-for-RTH-in-Hz_tbl2_277835798
- Tutorial to code in VCV Rack "Why and how to code your first VCV Rack Plugin (C++ for beginners)": https://www.youtube.com/watch?v=d670AFZKGnw
- Open Source VCV Rack Module Code: https://github.com/StudioSixPlusOne/rack-modules/tree/master/src/modules
- VCV Library: https://vcvrack.com/manual/GettingStarted
- VCV Plugin Development: https://vcvrack.com/manual/PluginDevelopmentTutorial
