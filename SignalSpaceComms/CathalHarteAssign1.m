%% Simulating 8-ary 2 dimensional channel subject to AWGN
% Author Cathal Harte
clear
close all

signal.train = 30;
signal.dim = [ 2 4 ];

[ inBin, inVec ] = SignalGenerator(signal);

plot(inVec(1,1:20),inVec(2,1:20), '.') 
% Has a fairly good chance of drawing the signal space

%%
[ rcvVec ] = AddNoise(inVec, 0.02);
[ outVec ] = Decide(signal, rcvVec);
[ outBin ] = Convert2GrayCode(signal, outVec);
[ ser ] = SER(inBin, outBin);
[ ber ] = BER(inBin, outBin);
