%% Guião Avaliação 48 horas %%
% Henrique Teixeira 114588
% Rui Machado 113765
load('matriz_turistas.mat');
load('id_turistas.mat');
load('id_restaurantes.mat');
load("evaluations.mat");
load("matriz_assinaturas.mat");

% guardar restaurantes.txt
load("cell_rest.mat");
load("nomes_restaurantes.mat");

% Aplicação

ID = input('Enter user ID: ');
while ~any(turistas == ID)
    fprintf('ID not found!\n')
    ID = input('Enter user ID: ');
end

fprintf('ID found!\n');

options = {'1 - Restaurants evaluated by you';
           '2 - Set of restaurants evaluated by the most similar user';
           '3 - Search Restaurant';
           '4 - Find most similar restaurants';
           '5 - Estimate the number of evaluations for each restaurant';
           '6 - Exit'};

[Set,users] = create_struct(turistas_data(:,1:2));

while 1
    fprintf('Menu:\n');
    fprintf('%s \n', options{:,1});
    selected = input('Select choice: ');

    if selected >= 1 && selected <= length(options)
        if selected == 6
            break
        else
            fprintf('Option selected:\n %s \n\n', options{selected});
            switch selected
                case 1
                    option1(Set{ID},rest);
                case 2

                    distancias = distancias_j(Nu,k,assinaturas);
                    
                    distanciasTemp = distancias(ID, :);
                    distanciasTemp(ID) = Inf;
                    
                    % Encontrar o valor mínimo e seu índice
                    [minimo, indiceColuna] = min(distanciasTemp);
                    
                    % Verificar se o mínimo é zero e encontrar o próximo mínimo
                    if minimo == 0
                        distanciasTemp(indiceColuna) = Inf; % Excluir o zero encontrado
                        [minimo, indiceColuna] = min(distanciasTemp); % Encontrar o próximo mínimo
                    end                 
                    
                    % Exibe o valor mínimo e o índice da coluna correspondente
                    fprintf('The user with the most similarity to user %d is user %d with a similarity of %.4f\n',ID, indiceColuna, minimo);
                    fprintf('List of restaurants evaluated by the most similar user:\n\n');
                    for i = 1:length(Set{indiceColuna})
                        id_i = Set{indiceColuna}(i);
                        fprintf('ID = %-3d | %s\n', id_i, restaurantes_nomes ...
                            {id_i});
                    end
                    fprintf('\n');
                case 3
                    opt3 = '';
                    while length(opt3) < 2
                        opt3 = input('Write a string: ','s');
                    end
                    shingle_size = 2;
                    k = 200;
                    [a,b,c,pp] = dispersao(k);
                    assinaturas_input = option3(opt3, shingle_size, k,a,b,c,pp);

                    %tornar a cell com os restaurantes s/ caracteres special
                    
                    similaridades_total = zeros(1, length(restaurantes_nomes));

                    for i = 1:length(restaurantes_nomes)
                        nome_restaurante = restaurantes_nomes{i};
                    
                        % Verificar se o nome do restaurante é longo o suficiente
                        if length(nome_restaurante) >= shingle_size
                            matriz_restaurantes = option3(nome_restaurante, shingle_size, k,a,b,c,pp);
                    
                            % Verificar se a matriz retornada é não-vazia
                            if ~isempty(matriz_restaurantes)
                                similaridades_total(i) = sum(assinaturas_input == matriz_restaurantes) / k;
                            else
                                % Lidar com a situação em que a matriz é vazia
                                similaridades_total(i) = 0;
                            end
                        else
                            % Lidar com nomes de restaurantes muito curtos
                            similaridades_total(i) = 0;
                        end
                    end
                    

                    distancias_J = 1-similaridades_total;
                    % Ordenar as distâncias de Jaccard
                    [distances_sorted, indices_sorted] = sort(distancias_J);
                    
                    % Imprimir os 5 restaurantes com menores distâncias
                    fprintf('The restaurants closest to "%s" are:\n', opt3);
                    if any(distances_sorted(1:5) > 0.99)
                        fprintf('There are no restaurants simliar enough (d <= 0.99 )to the string entered');
                        return
                    else
                        for i = 1:5
                            fprintf('%-40s | ID = %-3d\n', restaurantes_nomes{indices_sorted(i)}, indices_sorted(i));                    
                        end
                    end
                    fprintf('\n');
                case 4

                    %listar restaurantes visitados pelo user atual
                    fprintf('Restaurants evaluated by the user:\n')
                    visited_res=option1(Set{ID},rest);

                    %escolher um restaurante
                    if isempty(visited_res)
                        fprintf('User %d is yet to evaluate a restaurant!', ID);
                        break;
                    else
                        idRestauranteEscolhido = input('Choose the restaurant ID: ');
                        while ~any(visited_res == idRestauranteEscolhido)
                            fprintf('Erro: The restaurant chosen has not been evaluated by the user.\n');
                            idRestauranteEscolhido = input('Choose the restaurant ID: ');
                        end
                    end

                    %similaridade entre todos os parametros
                    
                    rest_chopped = rest(:,3:end);

                    k = 200;
                    [a,b,c,pp]=dispersao(k);
                    shingle_size = 2;
                    
                    count = 0;
                    
                    similaridade_rest = zeros(1,length(rest_chopped));
                    for j = 1:width(rest_chopped)
                        componente = rest_chopped{idRestauranteEscolhido,j};
                        if all(~ismissing(componente)) && all(length(componente) >= shingle_size)
                            assinat_escol = option3(componente,shingle_size,k,a,b,c,pp);
                            count = count + 1;                           
                    
                            for i = 1:length(rest_chopped)
                                word = rest_chopped{i,j};
                                lio = length(word);
                                if all(~ismissing(word)) && all(length(word) >= shingle_size)
                                    hash_rest = option3(word,shingle_size,k,a,b,c,pp);
                                    similaridade_rest(i) = similaridade_rest(i) + sum(assinat_escol == hash_rest) / k;                            
                                end
                            end
                        end
                    end
                    
                    if count > 0
                        similaridade_media = similaridade_rest / count;
                    else
                        similaridade_media = 0;
                    end
                    
                    % Ordena as similaridades em ordem decrescente
                    [rest_sim_sorted, rest_indice_sorted] = sort(similaridade_media, 'descend');
                    indices_para_remover = find(rest_sim_sorted == 1);
                    
                    rest_sim_sorted(indices_para_remover) = [];
                    rest_indice_sorted(indices_para_remover) = [];
                    
                    similaridade_media_sorted = [rest_sim_sorted',rest_indice_sorted'];


                    %%%%%%%%%%%%%%%%% segundo nível
                    
                    [Set_rest, index] = create_struct(turistas_data(:,[2,4]));
                    average_review = zeros(1,length(Set_rest));
                    for i = 1:length(Set_rest)
                        average_review(i) = sum(Set_rest{i})/length(Set_rest{i});
                    end
                    
                    % Inicialização da lista de grupos de desempate
                    gruposDesempate = cell(1, 3);
                    indiceGrupo = 1;
                    
                    % Percorre todos os restaurantes ordenados por similaridade
                    for indiceAtual = 1:length(rest_sim_sorted)
                        if indiceGrupo > 3
                            % Interrompe a criação de novos grupos após três grupos
                            break;
                        end
                    
                        similaridadeAtual = rest_sim_sorted(indiceAtual);
                        grupoAtual = similaridadeAtual;
                    
                        % Percorre enquanto houver restaurantes com a mesma similaridade
                        while indiceAtual + 1 <= length(rest_sim_sorted) && rest_sim_sorted(indiceAtual + 1) == similaridadeAtual
                            indiceAtual = indiceAtual + 1;
                            grupoAtual = [grupoAtual, rest_sim_sorted(indiceAtual)];
                        end
                    
                        % Adiciona o grupo atual à lista de grupos de desempate
                        gruposDesempate{indiceGrupo} = grupoAtual;
                        indiceGrupo = indiceGrupo + 1;
                        indiceAtual = indiceAtual + 1;
                    end
                    

                    
                    % aplicar o desempate por média de avaliações
                    % Aplicar o desempate por média de avaliações
                    podio = zeros(1, 3);
                    for i = 1:length(gruposDesempate)
                        grupo = gruposDesempate{i};
                        if length(grupo) > 1 % Se houver mais de um restaurante no grupo

                            indicesGrupo = find(ismember(similaridade_media, grupo));

                            avaliacoes = average_review(indicesGrupo);

                            [~, ordem] = sort(avaliacoes, 'descend');
                            indicesOrdenados = indicesGrupo(ordem);

                            lugaresLivres = find(podio == 0, min(length(indicesOrdenados), 3));
                            podio(lugaresLivres) = indicesOrdenados(1:length(lugaresLivres));
                        else
                            % Caso haja apenas um restaurante no grupo
                            index = find(similaridade_media == grupo);
                            if length(index) == 1 % Garante que index seja um único valor
                                if any(podio == 0) % Se houver lugar livre no pódio
                                    primeiroLivre = find(podio == 0, 1);
                                    podio(primeiroLivre) = index;
                                end
                            end
                        end
                    end
                    fprintf('The restaurants the most similar to: ID = %d | %s are:\n\n', idRestauranteEscolhido, restaurantes_nomes{idRestauranteEscolhido});
                    for i = 1:min(3, length(podio))
                        fprintf('%d.%-40s | ID = %-3d\n',i, restaurantes_nomes{podio(i)}, podio(i));                                            
                    end
                    fprintf('\n');
                                        
                case 5
                    % pedir o ID do restaurante & respetiva validação

                    IDRes = input("Restaurant ID: ");
                    
                    while IDRes < 0 ||  IDRes > 213
                        fprintf("Invalid ID")
                        IDRes = input("Restaurant ID: ");
                    end
                
                    p = 0.01;
                    m = length(restaurantes_nomes);
                    n = round(-(m*log(p))/(log(2))^2);

                    n_rui = 2042;
                    k = round((n*log(2))/m);
                    
                    % inicializar o Filtro de Bloom
                    BloomFilter = Initialize(m , n , k);
                    
                    % inserir todas as avalições no filtro
                    
                    %for loop no ficheiro de turistas e dá insert a cada segunda linha da
                    %coluna
                    
                    for i = 1:size(turistas)
                        idRestaurante = restaurantes(i); 
                        BloomFilter = Insert(BloomFilter, idRestaurante);
                    end
                    
                    %estimar o número de avaliaçoes
                    estimativa = EstimateReviews(BloomFilter, IDRes);

                    fprintf('The estimated number of evaluations for restaurant\n %s | ID = %d is %d\n', restaurantes_nomes{IDRes}, IDRes, estimativa);
      
            end
        end
    else
        fprintf('Invalid Option! Please try again!\n');
    end

end
