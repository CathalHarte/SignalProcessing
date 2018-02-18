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
stepsize = 0.02; %alpha
M = 100;
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

%%
signal = (error); %mixed signal

N =length(signal);
nDelays = 4;
stepsize = 0.1; %alpha
M = 30;
filtercoffs = zeros(1,M);
delay = zeros(1, nDelays);
sr = zeros(1,M); % x[n-j], from differentiation of E{error^2}
error2 = zeros(1,N); %error

for k =1:N
    sr = [delay(end) sr(1:end-1)];
    delay = [signal(k) delay(1:end-1)];
    filteroutput=filtercoffs*sr';
    error2(k) = filteroutput- signal(k);
    filtercoffs = filtercoffs - stepsize*error2(k)*sr;   
end
soundsc(error2)
%%
close all
plot(abs(fft(filteroutput)))
hold on 
plot(abs(fft(signal)))
%%

figure 
hold on
plot(abs(fft(error(1:1+N/100))))
for i = 1:9
    start = i*N/100;
    plot(abs(fft(error(start:start+N/10))))
end