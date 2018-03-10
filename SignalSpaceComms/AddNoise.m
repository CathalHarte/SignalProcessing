function [ noisyVector ] = AddNoise(vector, variance)
    noisyVector = vector + sqrt(variance)*randn(size(vector));