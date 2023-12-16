%probabilidade

p = 0.5;
%numero de vezes que aconteceu

k = 2;

%repeticoes

n = 3;

prob= nchoosek(n,k)*p^k*(1-p)^(n-k)

