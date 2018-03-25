clear
close all
LoadZeppelin

channelB = [0.407,0.815,0.407];
channelouput = conv(signal,channelB);
noisevariance = 0.01;
noise = sqrt(noisevariance)*randn(length(channelouput),1);
receivedsignal = channelouput+noise;

NfMMSE = 110;
Hmmse = toeplitz([channelB(1),zeros(1,NfMMSE-1)],[channelB,zeros(1,NfMMSE-length(channelB))]);
delay = round((length(channelB)+NfMMSE)/2);
wMMSE = (Hmmse*Hmmse'+noisevariance*eye(NfMMSE))\Hmmse(:,delay);
MMSEequalizedsignal = conv(wMMSE,receivedsignal);
z = MMSEequalizedsignal;
N =length(z);
nDelays = 8;
stepsize = 0.1; %alpha
M = 300;
filtercoffs = zeros(1,M);
delay = zeros(1, nDelays);
sr = zeros(1,M); % x[n-j], from differentiation of E{error^2}
[ error2, filteroutput ] = deal(zeros(1,N)); %error
for k =1:N
    sr = [delay(end) sr(1:end-1)];
    delay = [z(k) delay(1:end-1)];
    filteroutput(k) = filtercoffs*sr';
    error2(k) = filteroutput(k) - z(k);
    filtercoffs = filtercoffs - stepsize*error2(k)*sr;   
end
soundsc(filteroutput)