function out = kValues(key,k)
% out = kValues(key,k)
% key - row vector of characteres
% k   - number of the hash functions
% out - row vector with k hash values (each value between 0 and 2^32-1)   

    out= zeros(1,k);
    key=double(key);
    value = 0; 
    for i=1:length(key)
        value = mod(value*65599+key(i), 2^32-1);
    end
    for i= 1:k
        value = mod(value*65599+double(num2str(i)),2^32-1);
        out(i)= value;
    end
end