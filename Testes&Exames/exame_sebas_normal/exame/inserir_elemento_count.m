function BF = inserir_elemento_count(elem, BF)

n=length(BF);


hc = kHashValues(elem, 4);
hc = mod(hc, n) + 1;
for i=1:length(hc)
    BF(hc(i)) = BF(hc(i)) + 1;
end


end

