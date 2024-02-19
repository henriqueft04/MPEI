% Funçao para adicionar um elemento ao Filtro de Bloom

% supondo que a funçoes de dispersao têm o nome de "hashFunctin_i"

function bloomFilter = Insert(bloomFilter, element)
    for i = 1:bloomFilter.k
        % aplicar a funçao de dispersao ao elemento 
        h = hashFunction(element, i, bloomFilter.n);
        % incrementar a posição h do vetor -> filtro de Bloom com contagem
        bloomFilter.bits(h) = bloomFilter.bits(h) + 1;
    end
end

