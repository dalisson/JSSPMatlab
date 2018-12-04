function [ makespan, sequencia, avg_fit, best_fit ] = JSSP( instancia )
%JSSP Summary of this function goes here
%   Detailed explanation goes here
fi = dlmread(instancia);
ind_mutacao = 0.2;
prob_cruz = 0.6;
geracoes = 1000;
tarefas = size(fi,1);

tamanho_populacao = 300;

populacao = zeros(tamanho_populacao, tarefas);

for i = (1:tamanho_populacao)
    populacao(i,:) = randperm(tarefas);
end

proxima_geracao = zeros(tamanho_populacao, tarefas);

todo_make_span = zeros(1,tamanho_populacao);

make_geracoes_medio = zeros(1, geracoes);

melhor_make_geracoes = zeros(1, geracoes);


melhor_make_todos = 100000000;

melhor_sequencia = zeros(1,tarefas);

for n = 1:geracoes
    
%Estabelecendo o valor fitness de cada membro
    gradeVector = zeros(1,tamanho_populacao);
    for i = 1:tamanho_populacao
        makespanatual = get_make_span(populacao(i,:), fi);
        todo_make_span(i) = makespanatual;
        gradeVector(i) = 1/makespanatual;
    
    end
    
    m_atual = min(todo_make_span);
    melhor_make_geracoes(n) = m_atual;
    
    if(m_atual < melhor_make_todos)
        melhor_make_todos = m_atual;
        for itt = (1:tamanho_populacao)
            if(todo_make_span(itt) == melhor_make_todos)
                melhor_sequencia = populacao(i,:);
            end
        end
    end
    
    %codigo para janelamento
    
    %pior fitness de todos
    
    
    pior_individuo = min(gradeVector);
    %janelamento
    for i = 1:tamanho_populacao
        gradeVector(i) = gradeVector(i) - pior_individuo;
          
    end
    
    %final do codigo para janelamento
    
    %soma de toda o fitness
    sumOfGrades = sum(gradeVector);
   
    %Construino o ranking
    
    %iniciando a roleta
    roleta = zeros(1,tamanho_populacao);
    
    
    %construindo a roleta proporcional ao fitness
    for i = 1:tamanho_populacao
        %roleta armazena o fitness do individuo dividido pelo fitness total
        roleta(i) = gradeVector(i)/sumOfGrades;
    end
    
    
    
    %cada cruzamento gera dois filhos entao metade havera  metade do
    %tamanho da populacao de cruzamentos
    for i = 1:tamanho_populacao
        %escolhendo o primeiro pai
        % rodando a roleta
        roulleteSpin = rand(1);
        
        %onde a roleta vai parar
        spin = 0;
        %cada rodada reduz o fitness proporcional do individuo da roleta
        %quando a roleta < 0 o individuo e selecionado
        while roulleteSpin > 0
            roulleteSpin = roulleteSpin - roleta(spin + 1);
            spin = spin + 1;
        end
        
        
        %indice do primeiro pai escolhido
        firstParent = spin;
        
        %mesma coisa para escolher o segundo pai
        roulleteSpin = rand(1);
        spin = 0;
            
        while roulleteSpin > 0
            roulleteSpin = roulleteSpin - roleta(spin + 1);
            spin = spin + 1;
        end
        
      
        %segundo pai
        secondParent = spin;
       
        %criando dois filhos
        filhote = cruzamento(populacao(firstParent, :), populacao(secondParent, :), prob_cruz);
  
        %mutacao sobre os filhos
        filhotinho = mutar(filhote, ind_mutacao);
        
        % construindo a proxima geracao
        
        proxima_geracao(i,:) = filhotinho(1,:);
    
        
    
    end
    
    %substituindo a populacao atual pela proxima geracao
    populacao = proxima_geracao;
    
    
    make_geracoes_medio(n) = mean(todo_make_span);
    
    
end



makespan = melhor_make_todos;
sequencia = melhor_sequencia;
avg_fit = make_geracoes_medio;
best_fit = melhor_make_geracoes;



end

