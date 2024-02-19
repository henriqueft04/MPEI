%% Script para guardar variáveis

% guardar turistas.data
turistas_data = load('turistas1.data');
turistas = turistas_data(:,1);
restaurantes = turistas_data(:,2);
score = turistas_data(:,4);

% guardar restaurantes.txt
rest = readcell('restaurantes.txt', 'Delimiter','\t');
restaurantes_nomes = rest(:,2);

[Set,users] = create_struct(turistas_data(:,1:2));
Nu = length(users);
k = 200;
mat = formar_matriz(Set);
[a,b,c,pp] = dispersao(k);
assinaturas = minHash(mat,k,a,b,c,pp);

save("matriz_turistas","turistas_data");
save("id_turistas","turistas");
save("id_restaurantes","restaurantes");
save("evaluations","score");
save("cell_rest","rest");
save("nomes_restaurantes","restaurantes_nomes");
save("matriz_assinaturas","assinaturas");
