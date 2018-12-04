function [ output ] = get_make_span( sequencia, matriz_de_tempos )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

n_tarefas = size(matriz_de_tempos,1); %quantidade de tarefas
maquinas = size(matriz_de_tempos,2); %quantidade de maquinas

tarefas = zeros(maquinas, n_tarefas);

%tarefas_ordenadas = zeros(n_tarefas,maquinas);
%for i = (1:n_tarefas)
%    tarefas_ordenadas(i,:) = 0
%end
    
contador = 1;

for j = sequencia
    for i = (1:maquinas)
        tarefas(i,contador) = matriz_de_tempos(j,i);
    end
    contador = contador + 1;
end


make = zeros(maquinas, n_tarefas);


make(1,1) = tarefas(1,1);

for i = (2:maquinas)
    for j = (2:n_tarefas)
        make(1,j) = make(1,j-1) + tarefas(1,j);
        make(i,1) = make(i-1,1) + tarefas(i,1);
    end
end

for i = (2:maquinas)
    for j = (2:n_tarefas)
        if make(i, j-1) > make(i-1, j)
            make(i,j) = make(i,j-1) + tarefas(i,j);
        else
            make(i,j) = make(i -1, j) + tarefas(i,j);
        end
    end
end



output = make(end,end);

