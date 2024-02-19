function distancias = distancias_j(assinaturas)

    [Nu,k]  = size(assinaturas);
    distancias = zeros(Nu);
    for n1= 1:Nu
        for n2 = n1+1:Nu
            distancias(n1,n2) = sum((assinaturas(n1,:) ~= assinaturas(n2,:))/k);
        end
    end
    distancias = distancias + distancias';
end