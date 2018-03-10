function [ binary, vector ] = SignalGenerator(signal)
    binary = randi(prod(signal.dim), 1, signal.train) - 1;
    foo = binary; % temporary value for pulling apart the "binary" scalar
    i = 1;
    vector = zeros(length(signal.dim),signal.train);
    for bar = signal.dim
        % Encode the data one bases at a time
        vector(i,:) = mod(foo,bar); 
        foo = floor(foo/bar); 
        i = i + 1;
    end
    
