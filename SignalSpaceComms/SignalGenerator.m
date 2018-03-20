function [ bin, vector ] = SignalGenerator(signal)
    % creates an n-dimensional signal vector by treating randomly generated
    % number as mixed-radix n-tuples.
    % signal is a structure which which specifies the dimensionality of the
    % the train of vectors for transmission
    
    tuple = randi(prod(signal.dim), 1, signal.train) - 1;
    i = 1;
    vector = zeros(length(signal.dim),signal.train);
    for bar = signal.dim
        % Encode the data one bases at a time
        vector(i,:) = mod(tuple,bar); 
        tuple = floor(tuple/bar); 
        i = i + 1;
    end
    
    [ bin ] = Convert2GrayCode(signal, vector);