function [ noisyVector ] = AddNoise(vector, std)
    noisyVector = vector + std*randn(size(vector));