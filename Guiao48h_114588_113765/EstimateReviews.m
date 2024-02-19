% Função para estimar o número de avaliações de um restaurante

function estimativa = EstimateReviews(bloomFilter, element)
    contagens = zeros(1, bloomFilter.k);
    for i = 1:bloomFilter.k
        % aplicar a função de dispersão (hash) ao elemento
        h = hashFunction(element, i, bloomFilter.n);
        % contagem para cada função de hash
        contagens(i) = bloomFilter.bits(h);
    end
    % a estimativa é o mínimo das contagens coletadas
    estimativa = min(contagens);
end
