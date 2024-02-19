%%
load("input.mat");

%% a)
dimensions = size(list)

count = 0;
for i=1:dimensions(1)
    if list{i} == "Adão"
        count = count+1;
    end
end
count

BF = initialize_filter(500);
for i=1:dimensions(1)
    BF = inserir_elemento_count(list{i}, BF);
end
estimateCount(BF, 'Adão')

%% b)
n = length(extra);

counters = zeros(1,n);
for i=1:n
    c = estimateCount(BF, extra{i});
    counters(c+1) = counters(c+1) + 1;
end
fprintf("Prob 0: %.5f\n", counters(0+1) / n)
fprintf("Prob 1: %.5f\n", counters(1+1) / n)
fprintf("Prob 2: %.5f\n", counters(2+1) / n)
fprintf("Prob 3+: %.5f\n", sum(counters((3+1):n)) / n)

