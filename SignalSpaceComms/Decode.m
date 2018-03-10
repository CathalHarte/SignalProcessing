function [ binary ] = Decode(signal, vector)
    binary = zeros(1,signal.train);
    foo = 1; % multiplier for converting the vector back into a scalar
    i = 1;
    for bar = vector'
        % Decode the data one bases at a time
        binary = binary + foo*bar';
        foo = foo*signal.dim(i);
        i = i + 1;
    end
    