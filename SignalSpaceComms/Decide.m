function [ vector ] = Decide(signal, vector)
    % For each orthogonal basis of the vector, make a decision
    for i = 1:length(signal.dim)
        temp = round(vector(i,:)); % round to nearest value
        temp(temp<0) = 0; % correct upwards if out of range
        max = signal.dim(i)-1; 
        temp(temp>max) = max; % correct downwards if out of range
        vector(i,:) = temp;
    end