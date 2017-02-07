function resultat = comptable
    matrice1 = [18 5 0 5 0 10;
           17 2 12 15 7 12;
           8 1 11 0 10 25;
           2 10 5 4 13 7;
           15 0 8 7 10 15;
           5 5 3 12 8 6;
           13 3 5 8 10 7;
           1 2 1 2 0 4;
           2 1 1 5 2 1;
           1 1 3 2 2 0];

    matrice2 = [4800;
                4800;
                4800;
                4800;
                4800;
                4800;
                4800;
                350;
                820;
                485];

    res = linprog(-1*benef,matrice1,matrice2,[],[],zeros(6,1), []);
    resultat = (benef')*res;
    res
end

function resultat = benef
    resultat = [f(18,17,8,2,15,5,13,20,1,2,1);
                f(5,2,1,10,0,5,3,27,2,1,1);
                f(0,12,11,5,8,3,5,26,1,1,3);
                f(5,15,0,4,7,12,8,30,2,5,2);
                f(0,7,10,13,10,8,10,45,0,2,2);
                f(10,12,25,7,15,6,7,40,4,1,0)];
end

function resultat = f(x1,x2,x3,x4,x5,x6,x7,v,p1,p2,p3)
    resultat = v-(2*p1+4*p2+1*p3)-(x1*1+x2*3+x3*1+x4*4+x5*2+x6*3+x7*1)/60;
end

