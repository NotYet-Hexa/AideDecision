function resultat = stock
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
           -1 -1 -1 -1 -1 -1];
     vectorX = zeros(6,1);
     vectorY = zeros(6,1);
    for i = 1:100
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
                    -i*389/100];
    

        [~, resAteltier] = atelier;
        %faire graphique 0-1 pas 0.1 resAtelier
        res = linprog(gestionstock,matrice1,matrice2,[],[],zeros(6,1));
        resultat = (gestionstock')*res;
        vectorY(i)=resultat;
        if i==80
            res
            resultat
        end
        vectorX(i)=i*389/100;

     end
     plot(vectorX,vectorY);
end

function resultat = gestionstock
    resultat = [5;5;6;10;5;6];
end