function [ individuo_mutado ] = mutar( individuo, prob )
%MUTAR Summary of this function goes here
%   Detailed explanation goes here
    
    tamanho_genetico = size(individuo, 2);
    
    ind = individuo;
    
    n = rand(1);
    
    if(prob > n)
        
        primeiro = randi(tamanho_genetico);
        segundo = randi(tamanho_genetico);
        
        temp = individuo(primeiro);
        ind(primeiro) = individuo(segundo);
        ind(segundo) = temp;
        
    end

    individuo_mutado = ind;
end

