function [name1] = train(name)
display('Start Speaking');
sig = audiorecorder(44100,16,1);
recordblocking(sig,3);
display('Stop Speaking');
name1 = getaudiodata(sig);
audiowrite(name,name1,44100);