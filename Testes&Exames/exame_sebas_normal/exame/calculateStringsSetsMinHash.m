function MinHash = calculateStringsSetsMinHash(StringsSets, k)
[N1, N2] = size(StringsSets);

MinHash = inf(N1, k);

for i=1:N1
    for j=1:N2
        for h=1:k
            hash = hf24(convertStringsToChars(StringsSets{i,j}), h);
            MinHash(i,h) = min([MinHash(i,h), hash]);
        end
    end
end

end
