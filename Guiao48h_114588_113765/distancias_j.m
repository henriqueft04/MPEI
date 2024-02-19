function distancias = distancias_j(Nu,k,assinaturas)

    distancias = zeros(Nu);
    for n1= 1:Nu
        for n2 = n1+1:Nu
            intersection = sum(assinaturas(:,n1) == assinaturas(:,n2));
            uniao = k; % o número de hashes, uma estimativa da união
            similaridade = intersection / uniao;
            distancias(n1, n2) = 1 - similaridade;
            distancias(n2, n1) = distancias(n1, n2);
        end
    end
end