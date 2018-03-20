function binS = Convert2GrayCode(signal, vector) 
% Outputs a binary gray code string array (binS) 
% based on the the dimensionality of the
% input vector (contained in signal) 
% and the actual sequence of vectors (contained in vector)

    binS = ''; % initialize output
    for i = 1:length(signal.dim) 
        % arrange for loop so that the following 
        % function is called as minimal number of times
        foo = GrayCodeGenerator(sqrt(signal.dim(i)));
        bar = repmat('', signal.train, 1);
        for j = 1:signal.train
            bar(j,:) = foo(round(vector(i,j))+1,:);
        end
        binS = [ bar binS ]; %#ok<AGROW>
    end
            
        
    