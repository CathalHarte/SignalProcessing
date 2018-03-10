%% Simulating 8-ary 2 dimensional channel subject to AWGN
% Author Cathal Harte

signal.train = 30;
signal.dim = [ 2 4 ];

[ in, vector ] = SignalGenerator(signal);
[ receivedVector ] = AddNoise(vector, 1);
[ out ] = Decode(signal, vector);
% [ ser ] = SER(in, out);

plot(in)
hold on
plot(out)
