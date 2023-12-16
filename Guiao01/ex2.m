

experiencias = rand(3,1000);
lancamentos = experiencias>0.5;

resultados = sum(lancamentos);

sucessos = resultados ==2;
probSimulacao1 = sum(sucessos)/1000


N= 1e5; %nu´mero de experieˆncias
p = 0.5; %probabilidade de cara
k = 2; %nu´mero de caras
n = 3; %nu´mero de lanc¸amentos
lancamentos = rand(n,N) > p;
sucessos= sum(lancamentos)==k;
probSimulacao2 = sum(sucessos)/N




