%% Simulating 8-ary 2 dimensional channel subject to AWGN
% Author Cathal Harte
clear
close all

signal.train = 10^6;
signal.dim = [ 2 4 ];

[ in, vector ] = SignalGenerator(signal);

plot(vector(1,:),vector(2,:), '.')

%%
[ rcvVector ] = AddNoise(vector, 0.02);
[ out ] = Decode(signal, rcvVector);
[ ser ] = SER(in, out);
