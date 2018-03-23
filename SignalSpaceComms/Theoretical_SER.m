%% Theoretical E_s/N_0 to symbol error rate
close all
d = 1;
E_s = 3/2 * d^2;

N_0 = logspace(-1.5,0,20);
esno = E_s./N_0;

q = qfunc(sqrt(4/3 * esno));
theoretical_SER = 1/2*(5*q - 3*q.^2);

semilogy(10*log10(esno), theoretical_SER)