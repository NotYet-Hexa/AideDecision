function [resultat,res] = Commercial

% Maximisé la production avec un ecart de production des famille de produit
% limité par un epsilon

% Résultat optimal à 250 d'écart mais seulment 20 produits de différence
% sur production total. Donc on ajoute la contrainte epsilon = 0 et on
% obtient la production suivante : 
% [ 181.8182 , 5.9091 , 0.0000 , 0.0000 , 148.6364 , 39.0909 ] 
matrice1 = [18 5 0 5 0 10;
               17 2 12 15 7 12;
               8 1 11 0 10 25;
               2 10 5 4 13 7;
               15 0 8 7 10 15;
               5 5 3 12 8 6;
               13 3 5 8 10 7;
               1 2 1 2 0 4;
               2 1 1 5 2 1;
               1 1 3 2 2 0;
               1 1 1 -1 -1 -1;
               -1 -1 -1 1 1 1];

    epsiAbcisse = zeros(1,300);
    sumOrdonne = zeros(1,300);
    
    for epsilon = 0:389
        
           
    matrice2 = [4800;
                4800;
                4800;
                4800;
                4800;
                4800;
                4800;
                350;
                820;
                485;
                epsilon;
                epsilon];
            
             somme = - 1 *ones(6,1);
            
             res = linprog(somme,matrice1,matrice2,[],[],zeros(6,1), []);
             resultat = sum(res);
             epsiAbcisse(epsilon + 1) = epsilon;
             sumOrdonne(epsilon + 1) = resultat;
             if(epsilon == 0)
                 res
                 resultat
             end
    end
    plot(epsiAbcisse,sumOrdonne);
end

