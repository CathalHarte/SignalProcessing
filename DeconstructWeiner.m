clear
close all
filename = 'SinceIveBeen.wav';
[sinceIveBeen,Fs] = audioread(filename);
signal = (sinceIveBeen(:,1)); %mixed signal
signal = downsample(signal, 8);
noisevariance = 0.01;
beforeNoise = signal;
noise = sqrt(noisevariance)*randn(length(signal),1);
lenNoise = length(noise);
noise = conv(noise, [ .1 .2 .5 .2 .1 ]);
noise = noise(1:lenNoise);
N =length(signal);
nDelays = 4;
stepsize = 2; %alpha
M = 20;
filtercoffs = zeros(1,M);
delay = zeros(1, nDelays);
sr = zeros(1,M); % x[n-j], from differentiation of E{error^2}
srn = sr;
error = zeros(1,N); %error
filteroutput = zeros;
delayn = delay;
for k =1:N
    sr = [delay(end) sr(1:end-1)];
    delay = [signal(k) delay(1:end-1)];
    filteroutput(k) = filtercoffs*sr';
    error(k) = filteroutput(k) - signal(k);
    filtercoffs = filtercoffs - stepsize*error(k)*sr;  
    filtercoffs = filtercoffs/(1+abs(error(k)));
end
soundsc(filteroutput)
plot(signal, 'r')
hold on
plot(filteroutput, 'b')