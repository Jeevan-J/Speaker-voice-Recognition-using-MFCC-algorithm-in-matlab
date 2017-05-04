function [name1] = train(name)   % Define a function with name 'train' and an input parameter which is the location of audio sample to save
% Example to use this function
% Suppose speaker ID is James, then the command follows like this,
% James = train('Train/James.wav');
display('Start Speaking');       % Displays the string "Start Speaking" in command window
sig = audiorecorder(44100,16,1); % Creates an audio recorder object with name 'sig', sampling rate - 44100, bits - 16 and 1 - audio channel
recordblocking(sig,3);           % Records the audio for 3 secs and store it in 'sig' object
display('Stop Speaking');        % Displays the string "Stop Speaking" in command window
name1 = getaudiodata(sig);       % Gets the audio data from 'sig' object and stores it in variable named 'name1'
audiowrite(name,name1,44100);    % Saves the audio sample with '.wav' extension as mentioned in the input parameter
