clear
close all
LoadZeppelin
z = signal;
noisevariance = 0.01;
beforeNoise = z;
noise = sqrt(noisevariance)*randn(length(z),1);
lenNoise = length(noise);
noise = conv(noise, [ .1 .2 .5 .2 .1 ]);
noise = noise(1:lenNoise);
% z = noise + z;
N =length(z);
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
noise2 = sqrt(noisevariance)*randn(length(z),1);
% noise2 = ones(1,length(z));
for k =1:N
    sr = [delay(end) sr(1:end-1)];
    srn = [delayn(end) srn(1:end-1)];
    delay = [z(k) delay(1:end-1)];
    delayn = [noise2(k) delayn(1:end-1)];
    filteroutput(k) = filtercoffs*sr';
    filterednoise(k) = filtercoffs*srn';
    error(k) = filteroutput(k) - z(k);
    filtercoffs = filtercoffs - stepsize*error(k)*sr;  
    filtercoffs = filtercoffs/(1+abs(error(k)));
end
soundsc(filterednoise)

%%
z = (error); %mixed signal

N =length(z);
nDelays = 4;
stepsize = 0.1; %alpha
M = 30;
filtercoffs = zeros(1,M);
delay = zeros(1, nDelays);
sr = zeros(1,M); % x[n-j], from differentiation of E{error^2}
error2 = zeros(1,N); %error

for k =1:N
    sr = [delay(end) sr(1:end-1)];
    delay = [z(k) delay(1:end-1)];
    filteroutput=filtercoffs*sr';
    error2(k) = filteroutput- z(k);
    filtercoffs = filtercoffs - stepsize*error2(k)*sr;   
end
soundsc(error2)
%%
close all
plot(abs(fft(filteroutput)))
hold on 
plot(abs(fft(z)))
%%

figure 
hold on
plot(abs(fft(error(1:1+N/100))))
for i = 1:9
    start = i*N/100;
    plot(abs(fft(error(start:start+N/10))))
end