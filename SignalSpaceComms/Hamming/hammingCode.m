% Digital Communications Assignment 2 Cathal Harte
% 7 bit Hamming code
P = [ 1 1 0
      0 1 1 
      1 1 1 
      1 0 1 ];
G = [ P , eye(size(P,1)) ];
H = [ eye(size(P,2)), P' ];
LUT = [ 0 0 0 0 0 0 0
        0 0 1 0 0 0 0
        0 1 0 0 0 0 0
        0 0 0 0 1 0 0 
        1 0 0 0 0 0 0 
        0 0 0 0 0 0 1
        0 0 0 1 0 0 0
        0 0 0 0 0 1 0 ];
    
% Use modulo 2 as a way of implementing binary addition
generator = @(u) mod(u*G,2); 
% Add AWGN to each bit
addNoise = @(c,sigma) c + sigma*randn(size(c));
% make a hard decision on each bit
demod = @(r) r>0.5;
% find the syndrome for each code
syndrome = @(r) mod(r*H',2);
% Lookup the most likely error associated with a particular syndrome
lookup = @(s) LUT(sum(ones(size(s,1),1)*2.^([size(s,2):-1:1]-1).*s,2)+1,:);
% Apply the Hamming correction
hammingCorrect = @(s,r) mod(r+lookup(s),2);
% Decode the symbol back down to the data bits
% This is easy as it is a systematic form code
hammingDecode = @(c) c(:,4:end);
% bit error rate, where parity bits count as bits
ber = @(u,udash) sum(sum(mod(u+udash,2)))/prod(size(u));

%% Set up esno
E_s = 1/2 * 7/4; % Assuming that the parity bits have equal likelihood of
% being one or zero, transmitted as a binary pulse
N_0 = logspace(-1.5,0,10); 
% a log array works better when plotting a decibel x axis
esno = E_s./N_0;

%% Now run simulation for a particular case
% Create random train of signals to send
fprintf('finished at: %d\nCurrently: ', length(N_0))
i = 0;
[ BERUN, BER ] = deal(zeros(1,length(N_0))); % init bit error rate array
% uncoded, coded
tic
for foo = N_0
    i = i + 1;
    for delete = 0:log10(i-1) % Count progress in place
        fprintf('\b');
    end
    fprintf('%d', i); 
    u = randi([0 1],round(5000000),4); % Data bits
    uNoisy = addNoise(u, sqrt(foo)/2); % Noisy data bits
    rUN = demod(uNoisy); 
    rUN = demod(rUN);
    c = generator(u); % Coded bits
    r = addNoise(c, sqrt(foo)/2); % Noisy coded bits
    r = demod(r); % Hard decision on noisy code
    s = syndrome(r);
    cdash = hammingCorrect(s,r); % Correct for most likely errors
    udash = hammingDecode(cdash); % transform back to data bits
    BERUN(i) = ber(u,rUN);
    BER(i) = ber(u,udash);
end
fprintf('\n')
toc

%% Plot the results

semilogy(10*log10(esno), BER, '-xb')
hold on
semilogy(10*log10(esno*4/7), BERUN, '-^r')

legend('Hamming Coded', 'Uncoded')
xlabel('E_B/N_0 (dB)')
ylabel('Error Rate')