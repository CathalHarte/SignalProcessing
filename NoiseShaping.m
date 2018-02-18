clear
close all
LoadZeppelin
noisevariance = 0.01;
beforeNoise = signal;
noise = sqrt(noisevariance)*randn(length(signal),1);
lenNoise = length(noise);
noise = conv(noise, [ .1 .2 .5 .2 .1 ]);
noise = noise(1:lenNoise);
N =length(signal);
nDelays = 4;
stepsize = 0.002; %alpha
M = 300;
filtercoffs = zeros(1,M);
delay = zeros(1, nDelays);
sr = zeros(1,M); % x[n-j], from differentiation of E{error^2}
srn = sr;
error = zeros(1,N); %error
filteroutput = zeros;
filterednoise = zeros;
delayn = delay;

% Create white noise, and consruct the song out of it
noise2 = sqrt(noisevariance)*randn(length(signal),1);
for k =1:N
    sr = [delay(end) sr(1:end-1)];
    srn = [delayn(end) srn(1:end-1)];
    delay = [signal(k) delay(1:end-1)];
    delayn = [noise2(k) delayn(1:end-1)];
    filteroutput(k) = filtercoffs*sr';
    filterednoise(k) = filtercoffs*srn';
    error(k) = filteroutput(k) - signal(k);
    filtercoffs = filtercoffs - stepsize*error(k)*sr;  
    filtercoffs = filtercoffs/(1+abs(error(k)));
end
soundsc(filterednoise)
