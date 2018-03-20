function ser = SER(in, out)
    ser = 0;
    len = size(in, 1);
    for i = 1:len
        ser = ser + ~ strcmp(in(i,:),out(i,:));
    end
    ser = ser/len;