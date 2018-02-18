filename = 'SinceIveBeen.wav';
[sinceIveBeen,Fs] = audioread(filename);
signal = (sinceIveBeen(:,1)); %mixed signal
signal = downsample(signal, 8);