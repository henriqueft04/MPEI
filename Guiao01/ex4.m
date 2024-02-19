experiencias = rand(15,1000);
lancamentos = experiencias > 0.5;

resultados = sum(lancamentos);
seguidas = resultados>=6;

prob = sum(seguidas)/100