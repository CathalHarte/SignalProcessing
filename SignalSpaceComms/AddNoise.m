function [ noisyVector ] = AddNoise(vector, sigma)
    % adds AWGN with zero mean and variance sigma^2
    noisyVector = vector + sigma*randn(size(vector));