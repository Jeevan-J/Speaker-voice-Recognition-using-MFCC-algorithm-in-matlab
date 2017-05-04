# Speaker-voice-Recognition-using-MFCC-algorithm-in-matlab
Detecting the speaker based on his voice. In this project, we mainly deal with Text-Dependent Speaker recognition system i.e., speaker has to speak a specific word to detect his voice.

# NOTE:
The files mfcc.m, vec2frames.m, trifbank.m are copyrighted to Kamil Wojcicki.
Copyright (c) 2011, Kamil Wojcicki 
All rights reserved.

Redistribution and use in source and binary forms, with or without 
modification, are permitted provided that the following conditions are 
met:

* Redistributions of source code must retain the above copyright 
notice, this list of conditions and the following disclaimer. 
* Redistributions in binary form must reproduce the above copyright 
notice, this list of conditions and the following disclaimer in 
the documentation and/or other materials provided with the distribution 
* Neither the name of the University of Texas at Dallas nor the names 
of its contributors may be used to endorse or promote products derived 
from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
POSSIBILITY OF SUCH DAMAGE.

The file simmx.m is copyrighted to Dan Ellis, 2003-2009.

# Description of Project:
1. We record an audio sample of each speaker and save them in a folder called 'Train' with their Speaker ID
2. During testing phase, we record an audio sample of any speaker and compute MFCC(Mel Freq Cepstral Co-efficients) using mfcc alogorithm and also save it in a folder called 'Test'.
3. We then compute MFFC of all samples saved in 'Train' folder and find Euclidian distance between MFCC of test file and MFCC's of train files.
4. The least distance between the test model and train model gives the speaker ID.
5. To train any speaker model, first go to the directory where this files are located and type the command "name = train('Train/name')". name - speaker ID
6. To find the speaker who is speaking, type the command "test('Test/name')". name - Speaker ID
7. Output will give all the Euclidian Distances and Final Speaker ID.
8. NOTE : Try to record the audio samples in same environment and in same length.
