function assinaturas = option3(str, shingle_size, k, a, b, c, pp)
    
    % Verificar se o tamanho da string é suficiente para o shingle
    if length(str) < shingle_size
        % Retornar matriz vazia ou lidar com strings curtas de outra maneira
        assinaturas = zeros(k, 0); % ou outra abordagem conforme necessário
        return;
    end

    % Criar shingles
    numero_shingles = length(str) - shingle_size + 1;
    shingles = cell(1, numero_shingles);

    for i = 1:numero_shingles
        shingles{i} = str(i:i + shingle_size - 1);
    end

    % Inicializar matriz de assinaturas
    assinaturas = inf(1,k);

    % Apontar assinaturas MinHash
    for i = 1:k
        
        min_hash = inf;
        for j = 1:numero_shingles
            hash_val = 0;          
            for l = 1:shingle_size
                %tenho de tornar o shingle num número
                shingle_num = sum(double(shingles{j}(l)) * (256^(l-1)));

                %calcular dispersão com os parâmemetros aleatórios
                hash_val = hash_val + mod(a(i) * shingle_num + b(i) + c(i), pp);
                
            end
            min_hash = min(min_hash, hash_val);
            
        end
        assinaturas(i) = min_hash;
    end
end


