function [] = test(name) 
    % defining a function with name 'test' and input parameter 'name'. name refers to path of location where audio sample is going to store.
    % Suppose Speaker with unknown ID is speaking and I want to know who it is. I execute the fundtion by following command.
    % test('Test/unknown1.wav')
    % Above command saves the audio sample with name 'unknown1.wav' in Test folder
    display('Start Speaking'); % displays the string Start Speaking in command window
    sig = audiorecorder(44100,16,1); % Creates an audio object with 44100 sampling rate, 16-bits and 1-audio channel.
    recordblocking(sig,3); % records audio for 3 secs
    display('Stop Speaking'); % displays the string Stop Speaking in command window
    name1 = getaudiodata(sig); % getting data from audio object as a vector
    audiowrite(name,name1,44100); % saving the audio sample in test folder

    % refer to mfcc.m file and understand the terms below and assign values as per your requirement 
    Tw=25;
    Ts=10;
    alpha=0.97;
    R = [300 3700];
    M = 20;
    C = 13;
    L = 22;
    hamming = @(N)(0.54-0.46*cos(2*pi*[0:N-1].'/(N-1)));
    dis=zeros(1,9);
    [ tMFCCs, ~, ~ ] = mfcc( name1, 44100, Tw, Ts, alpha, hamming, R, M, C, L );

    % After finding MFCC of test sample, we will find MFCC of each speaker model in Train folder and 
    % also Euclidian distance between the speaker model and test sample
    [speaker1,Fs]=audioread('train/raj.wav');                % Get the data of speaker model to a variable
    [MFCCs1,~,~] = mfcc(speaker1, Fs, Tw, Ts, alpha, hamming, R, M, C, L );% Calculate MFCC of speaker model 
    dis(1) = dtw(tMFCCs,MFCCs1);                                           % find the euclidian distance using "dtw" function and store it in a array
    display(dis(1));                                                       % displays the euclidian distance
    % Continue this for all speaker models
    [speaker2,Fs]=audioread('train/chaitu.wav');
    [MFCCs2,~,~] = mfcc(speaker2, Fs, Tw, Ts, alpha, hamming, R, M, C, L );
    dis(2) = dtw(tMFCCs,MFCCs2);
    display(dis(2));
    [speaker3,Fs]=audioread('train/deepak.wav');
    [MFCCs3,~,~] = mfcc(speaker3, Fs, Tw, Ts, alpha, hamming, R, M, C, L );
    dis(3) = dtw(tMFCCs,MFCCs3);
    display(dis(3));
    [speaker4,Fs]=audioread('train/gella.wav');
    [MFCCs4,~,~] = mfcc(speaker4, Fs, Tw, Ts, alpha, hamming, R, M, C, L );
    dis(4) = dtw(tMFCCs,MFCCs4);
    display(dis(4));
    [speaker5,Fs]=audioread('train/challa sir.wav');
    [MFCCs5,~,~] = mfcc(speaker5, Fs, Tw, Ts, alpha, hamming, R, M, C, L );
    dis(5) = dtw(tMFCCs,MFCCs5);
    display(dis(5));
    [speaker6,Fs]=audioread('train/akhil.wav');
    [MFCCs6,~,~] = mfcc(speaker6, Fs, Tw, Ts, alpha, hamming, R, M, C, L );
    dis(6) = dtw(tMFCCs,MFCCs6);
    display(dis(6));
    [speaker7,Fs]=audioread('train/surya.wav');
    [MFCCs7,~,~] = mfcc(speaker7, Fs, Tw, Ts, alpha, hamming, R, M, C, L );
    dis(7) = dtw(tMFCCs,MFCCs7);
    display(dis(7));
    [speaker8,Fs]=audioread('train/manoj.wav');
    [MFCCs8,~,~] = mfcc(speaker8, Fs, Tw, Ts, alpha, hamming, R, M, C, L );
    dis(8) = dtw(tMFCCs,MFCCs8);
    display(dis(8));
    [speaker9,Fs]=audioread('train/sir.wav');
    [MFCCs9,~,~] = mfcc(speaker9, Fs, Tw, Ts, alpha, hamming, R, M, C, L );
    dis(9) = dtw(tMFCCs,MFCCs9);
    display(dis(9));
    dis1=sort(dis); % since we have stored all euclidian distances in an array 'dis', we will sort the array in ascending order so that our first element value is least euclidian distance.
    spe={'raj','chaitanya','deepak','gella','challa sir','akhil','surya','manoj','sir'}; % we write the speaker ID's in order that we stored MFCC in an array
    for i=1:1:9
        if(dis1(1)==dis(i))
            display(spe(i)); % Now that we know minimum euclidian distance, we can find the Speaker ID with closest matching to the test sample.
            a = arduino('com5','uno','libraries','ExampleLCD/LCDAddon','ForceBuild',true); %connect to arduino board using serial communication
            lcd = addon(a,'ExampleLCD/LCDAddon',{'D7','D6','D5','D4','D3','D2'}); % See this link for more info: https://in.mathworks.com/help/supportpkg/arduinoio/ug/add-lcd-library.html
            initializeLCD(lcd);
            printLCD(lcd,string(spe(i)));
            clearLCD(lcd);
        end
    end
end
