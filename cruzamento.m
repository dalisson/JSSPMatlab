function [ filhote ] = cruzamento( pai_um, pai_dois, probabilidade_cruzamento )
%CRUZAMENTO Summary of this function goes here
%   Detailed explanation goes here

tamanho_genetico = size(pai_um, 2);
    filho = pai_um;
    
    if(rand(1) < probabilidade_cruzamento)
    
    inicio = randi(tamanho_genetico);
    fim = randi(tamanho_genetico);
 
    
    
    if(fim < inicio)
        temp = inicio;
        inicio = fim;
        fim = temp;
   
    end
  
    gene_pai_um = pai_um(1, inicio:fim);
    
    
    filho = zeros(1,tamanho_genetico);

    index = 1;
    filho(1,inicio:fim) = gene_pai_um(1,:);
    
    
    for i = (1:tamanho_genetico)
        if(filho(i) == 0)
            
            while(ismember(pai_dois(index),gene_pai_um))
                index = index + 1;
                
            end
            gene_pai_um = [gene_pai_um, pai_dois(index)];
           filho(i) = pai_dois(index);
       end
    end
    
    end
    filhote = filho;

   
end

