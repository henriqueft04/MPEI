%% a)
T = [0 0 0.8 0 0;
     1 0 0 0 0;
     0 0.9 0 0 0;
     0 0.1 0 1 0;
     0 0 0.2 0 1]

%% b)
N = length(T);

EI = zeros(N, 1);
EI(1) = 1;

P12 = T^12 * EI;
p12 = P12(1);
fprintf("%.5f\n", p12)

%% c)
T_can = T; % T ja esta na forma canonica

T_can
Q=T_can(1:3, 1:3)

F = (eye(length(Q)) - Q)^(-1)

sF=sum(F)
sF(1) % resultado

%% d)

R = T_can(4:5, 1:3);
Probs = R*F

Probs(1,1) % resultado
