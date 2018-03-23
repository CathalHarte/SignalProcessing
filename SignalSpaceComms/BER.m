function ber = BER(inS, outS)
    % inS = transmitted symbols
    % outS = received symbols
    % symbols are string matrices
    ber = 0;
    dim = size(inS);
    if ~ all(dim == size(outS))
        error('Input and output must be same size')
    end
    
    % find every bit which has flipped
    for j = 1:dim(2) % column major for loop is faster
        for i = 1:dim(1)
            ber = ber + ~ (inS(i,j) == outS(i,j)); % as is compute in place
        end
    end
    ber = ber /(dim(1) * dim(2));
    