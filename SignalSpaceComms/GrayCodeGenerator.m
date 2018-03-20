function binS = GrayCodeGenerator(n_bit)
    if n_bit > 16
        error('Consider a different method of decoding than an LUT')
    end
    binS = [ '0'
            '1'
          ];
    for i = 1:n_bit-1 
        len = size(binS,1);
        % we cannot pre allocate with this method, so it is a little slow,
        % but is very clear
        binS = [ repmat('0', len, 1) binS
                repmat('1', len, 1) flip(binS)
              ]; %#ok<AGROW>
    end
    