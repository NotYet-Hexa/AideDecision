function [matDis,matConc] = partie3
    matriceX=remisePoid;
    matrice = preCleanMatrix(matriceX);
    matConc=matriceConcordance(matrice)
    matDis=matriceDiscordance(matrice)
    MatSeuil = ComparatifSeuil(matConc,matDis)
    
    
end

function matriceDisc = matriceDiscordance(matriceJug)
  
    [lsize,~]=size(matriceJug);
    matriceDisc = zeros(lsize);
    for indexligne1  = 1:lsize 
        x1 = matriceJug(indexligne1,:);
        for indexligne2 = 1:(lsize)
            if indexligne2==indexligne1
                matriceDisc(indexligne2,indexligne1)=NaN;
            else
                x2 = matriceJug(indexligne2,:);
                matriceDisc(indexligne2,indexligne1)=maxDifferenceVector(x1,x2)/10;
            end
            
            
        end 
    end 
end


function matriceConc = matriceConcordance(matriceJug)
    [lsize,csize]=size(matriceJug);
    matriceConc = zeros(lsize);
    for indexligne1  = 1:lsize 
        x1 = matriceJug(indexligne1,:);
        for indexligne2 = 1:(lsize)
            if indexligne2==indexligne1
                matriceConc(indexligne2,indexligne1)=NaN;
            else
                x2 = matriceJug(indexligne2,:);
                [compteur,~]= comparerDeuxVecteur(x1,x2);
                matriceConc(indexligne2,indexligne1)=compteur/csize;
            end
        end 
    end 
end

function matrice = preCleanMatrix(matriceJug)
    %Vire ceux qui se font domin�s
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
    % res renvoie 1 si toutes les �l�ments du vecteur 1 sont supp � ceux du
    %Vecteur 2
    %et le compteur sert � voir cb d'�lement sont sup ou �gaux
    %(Pour la matrice de Concordance)
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

function matriceResultat = ComparatifSeuil(matriceConcordance,matriceDiscordance)
    [imax,jmax]=size(matriceConcordance);
    matriceRes = zeros(imax,jmax);
    for seuilC = 1:10
        for seuilD=1:10
            for indexLigne = 1:imax
                for indexColonne = 1:jmax
                    if matriceConcordance(indexLigne,indexColonne)> seuilC/10 && matriceDiscordance(indexLigne,indexColonne)<seuilD/10
                        matriceRes(indexLigne,indexColonne)=1;
                    end
                end  
            end
            for colonne = 1:jmax 
                if isequal(matriceRes(:,colonne),zeros(imax,1)) && ~isequal(matriceRes,zeros(imax,jmax))
                    matriceResultat=matriceRes;
%                     display(matriceRes);
%                     display(colonne)
%                     display(seuilC)
%                     display(seuilD)
                end 
            end 
        end 
    end 
end

function matrice=remisePoid
      matriceJug = [ 6 5 4 5 ;
                   5 2 6 7 ;
                   4 3 2 5 ;
                   3 7 5 4 ;
                   1 7 2 9 ;
                   2 5 3 3 ;
                   5 4 2 9 ;
                   3 5 7 4 ];
    [imax,jmax]=size(matriceJug);
    matrice = zeros(imax,jmax);
    for jcolonne = 1:jmax 
        colonne=matriceJug(:,jcolonne);
        for iligne = 1:imax
            matrice(iligne,jcolonne)=changementEchelle(matriceJug(iligne,jcolonne),min(colonne),max(colonne),0,10);
        end 
        
    end 
end

function y=changementEchelle(x,DebInt1,FinInt1,DebInt2,FinInt2)
    y=x*(FinInt2-DebInt2)/(FinInt1-DebInt1)+(FinInt1*DebInt2-DebInt1*FinInt2)/(FinInt1-DebInt1);
end