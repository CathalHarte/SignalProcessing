%% Simulating 8-ary 2 dimensional channel subject to AWGN
% Author Cathal Harte
clear
close all
tic
d = 1; % setting d to 1 is most logical
E_s = 3/2 * d^2;

N_0 = logspace(-1.5,0,10); % a log array works better when plotting a decibel x axis
esno = E_s./N_0;

q = qfunc(sqrt(2/3 * esno));
theoretical_ser = 1/2*(5*q - 3*q.^2);
signal.dim = [ 2 4 ];
signal.train = 0;
i = 0;
[ ser, ber ] = deal(1,zeros(length(N_0))); % initialize
fprintf('finished at %d\n', length(N_0))
for foo = N_0
    signal.train = round(10^4/foo); % longer train when a lower SER is expected
    i = i + 1;
    for delete = 0:log10(i-1) % Count progress in place
        fprintf('\b');
    end
    fprintf('%d', i); 
    [ inBin, inVec ] = SignalGenerator(signal);
    [ rcvVec ] = AddNoise(inVec, sqrt(foo)/2);
    [ outVec ] = Decide(signal, rcvVec); 
    [ outBin ] = Convert2GrayCode(signal, outVec);
    [ ser(i) ] = SER(inBin, outBin);
    [ ber(i) ] = BER(inBin, outBin);
    
end

semilogy(10*log10(esno), theoretical_ser, '-ob')
hold on 
semilogy(10*log10(esno), ser, '-xr')

semilogy(10*log10(esno), ber, '-^g')

legend('Theoretical SER', 'Simulated SER', 'Simulated BER')
xlabel('E_S/N_0 (dB)')
ylabel('Error Rate')
toc
