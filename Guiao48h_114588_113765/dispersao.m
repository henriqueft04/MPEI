function [a,b,c,pp] = dispersao(k)
    pp = 100003;

    while (~isprime(pp))
        pp = pp + 2;
    end

    a = randi([1, pp - 1], 1, k);
    b = randi([0, pp - 1], 1, k);
    c = randi([1, pp - 1], 1, k);
end