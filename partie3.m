function resultat = partie3
    resultat = preCleanMatrix;
end

function matriceDisc = matriceDiscordance(matriceJug)
  
    [lsize,~]=size(matriceJug);
    matriceDisc = zeros(lsize);
    for indexligne1  = 1:lsize 
        x1 = matriceJug(indexligne1,:);
        for indexligne2 = 1:(lsize)
            x2 = matriceJug(indexligne2,:);
            matriceDisc(indexligne2,indexligne1)=maxDifferenceVector(x1,x2)/10;
        end 
    end 
end

function max = maxDifferenceVector(vector1,vector2)
    [~,nbrelement] = size(vector1);
    max=0;
    for index= 1:nbrelement
        temp=vector1(index)-vector2(index);
        if (temp>max)
            max=temp;
        end 
    end
    
end
function matriceConc = matriceConcordance(matriceJug)
    [lsize,csize]=size(matriceJug);
    matriceConc = zeros(lsize);
    for indexligne1  = 1:lsize 
        x1 = matriceJug(indexligne1,:);
        for indexligne2 = 1:(lsize)
            x2 = matriceJug(indexligne2,:);
            [compteur,~]= comparerDeuxVecteur(x1,x2);
            matriceConc(indexligne2,indexligne1)=compteur/csize;
        end 
    end 
end

function matriceJuge = preCleanMatrix
    %Vire ceux qui se font dominés
      matriceJug = [ 6 5 4 5 ;
                   5 2 6 7 ;
                   4 3 2 5 ;
                   3 7 5 4 ;
                   1 7 2 9 ;
                   2 5 3 3 ;
                   5 4 2 9 ;
                   3 5 7 4 ];
        listeAJeter=[];
       [nbrLigne,nbrColonne]=size(matriceJug);
       for indexligne1  = 1:nbrLigne 
            x1 = matriceJug(indexligne1,:);
            for indexligne2 = 1:(nbrLigne)
                x2 = matriceJug(indexligne2,:);
                [~,res] = comparerDeuxVecteur(x1,x2);
                if res==1
                    listeAJeter=[listeAJeter indexligne2];
                end 
            end 
       end 
       listeAJeter
       listeAJeter= unique(listeAJeter);
       [~,NbElement]=size(listeAJeter);
       matrice = zeros(nbrLigne - NbElement, nbrColonne);
       indexAncienneMatrice=1;
       for indexMat = 1:(nbrLigne-NbElement)
            if ismember(indexAncienneMatrice,listeAJeter)
                indexAncienneMatrice=indexAncienneMatrice+1;
                matrice(indexMat,:)=matriceJug(indexAncienneMatrice,:);
            else 
                matrice(indexMat,:)=matriceJug(indexAncienneMatrice,:);
            end 
            indexAncienneMatrice=indexAncienneMatrice+1;
       end 
       
end

function [compteur,res] = comparerDeuxVecteur(Vecteur1, Vecteur2)
    %renvoie True si toutes les éléments du vecteur 1 sont supp à ceux du
    %Vecteur 2
    [~,nbrelement]=size(Vecteur1);
    res=0;
    compteur=0;
    for index = 1:nbrelement
        if Vecteur1(index)>=Vecteur2(index) 
            compteur = compteur +1;
        end
    end
    if compteur == nbrelement && sum(Vecteur1)>sum(Vecteur2)
        res = 1;
        res
    end 
end 

