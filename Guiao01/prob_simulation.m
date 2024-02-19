function [p, amostragem] = prob_simulation(probabilidade_cara, lancamentos, caras_pretendidas, N)

    experiencias = rand(lancamentos, N) > probabilidade_cara;

    result = sum(experiencias);
    sucessos = result==caras_pretendidas;

    p = sum(sucessos)/N;
    
    index = 0;
    
    amostragem = cell(lancamentos,2);

    for i = 1:length(result)

        found = false;
        atual = result(i);

        for j = 1:index
            if amostragem{j, 1} == atual
                amostragem{j,2} = amostragem{j, 2} + 1;
                found = true;
                break;
            end
        end

        if ~found
            index = index+1;
            amostragem{index,1} = atual;
            amostragem{index,2} = 1;
        end
    end

    for i = 1:size(amostragem, 1)
        amostragem{i, 2} = amostragem{i, 2} / N;
    end    

    amostragem = amostragem(1:index, :);

    amostragem = sortrows(amostragem,1);

    amostragem = cell2mat(amostragem);


end