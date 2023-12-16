%numero de lancamentos
p = 20;

%numero de caras pertendidas
caras = 4;

%numero de experiencias
numero = 100;

experiencias(caras, numero);
lancamentos = experiencias > 0.5;

resultados = sum(lancamentos);
seguidas = resultados == caras;

prob = sum(seguidas)/100

lancamentosvet = [20,40,100];

stem(lancamentosvet,prob)




