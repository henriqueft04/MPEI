function Distances = calculateDistances(M)
[Nt, k] = size(M);
Distances = zeros(Nt, Nt);

% Calcular distancias
for t1=1:Nt
    for t2=t1+1:Nt
        Distances(t1, t2) = sum((M(t1, :) ~= M(t2, :)) / k);
    end
end

Distances = Distances + Distances';

end
