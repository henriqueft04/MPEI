% Funçao para inicializar a estrutura de dados do Filtro de Bloom

% m -> número de membros do conjunto
% n -> número de posiçoes ou células do filtro
% k -> número de funçoes de dispersao utilizadas

function bloomFilter = Initialize(m, n, k)
    bloomFilter.m = m;
    bloomFilter.n = n;
    bloomFilter.k = k;
    bloomFilter.bits = zeros(1,n); % inicializar o vetor de bits, com zeros
end

