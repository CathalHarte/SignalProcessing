function ser = SER(in, out)
    foo = in - out;
    foo = abs(foo);
    foo(foo>0) = 1;
    ser = sum(foo)/length(foo);