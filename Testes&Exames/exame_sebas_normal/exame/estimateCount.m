function count = estimateCount(Filter, key)

n=length(Filter);

hashes = kHashValues(key, 4);
hashes = mod(hashes, n) + 1;
count = min(Filter(hashes));

end
