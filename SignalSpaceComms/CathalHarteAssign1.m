%% Simulating 8-ary 2 dimensional channel subject to AWGN
% Author Cathal Harte
clear
close all


signal.dim = [ 2 4 ];
signal.train = 30;
[ inBin, inVec ] = SignalGenerator(signal);

% plot(inVec(1,1:20),inVec(2,1:20), '.') 
% Has a fairly good chance of drawing the signal space
E_s = 3/2; % minimum energy constellation

%%
d = 1;
E_s = 3/2 * d^2;

N_0 = logspace(-1.5,0,20);
esno = E_s./N_0;

q = qfunc(sqrt(2/3 * esno));
theoretical_ser = 1/2*(5*q - 3*q.^2);
signal.train = 0;
i = 0;
[ ser, ber ] = deal(1,zeros(length(N_0)));
fprintf('finished at %d\n', length(N_0))
for foo = N_0
    signal.train = round(10^5/foo);
    i = i + 1;
    for delete = 0:log10(i-1)
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

semilogy(10*log10(esno), theoretical_ser, 'b')
hold on 
semilogy(10*log10(esno), ser, 'r')

semilogy(10*log10(esno), ber, 'g')

legend('Theoretical SER', 'Simulated SER', 'Simulated BER')
