function [ vector ] = Decide(signal, vector)
    for i = 1:length(signal.dim)
        temp = round(vector(i,:));
        temp(temp<0) = 0;
        max = signal.dim(i)-1;
        temp(temp>max) = max;
        vector(i,:) = temp;
    end