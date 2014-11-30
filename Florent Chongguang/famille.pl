homme(pierre).
femme(manon).
homme(bernard).
femme(jocelyne).
homme(hugue).
femme(laurence).
femme(julia).
homme(thierry).
femme(dusi).



parents(pierre,manon,bernard).
parents(pierre,manon,jocelyne).
parents(bernard,laurence,hugue).
parents(bernard,laurence,julia).
parents(thierry,jocelyne,dusi).

couple(pierre,manon).
couple(thierry,jocelyne).
couple(bernard,laurence).

frere(X,Y) :- homme(Y),X\=Y,parents(F,M,X),parents(F,M,Y).
soeur(X,Y) :- femme(Y),X\=Y,parents(F,M,X),parents(F,M,Y).

ancetre(X,Z) :- parents(Z,_,X) ; parents(_,Z,X).
ancetre(X,Y) :- parents(P,M,X),(ancetre(P,Y);ancetre(M,Y)).

oncle(X,Y) :- parents(P,M,X),(frere(P,Y);frere(M,Y);(soeur(P,Z),couple(Y,Z));(soeur(M,Z),couple(Y,Z))).
tante(X,Y) :- parents(P,M,X),(soeur(P,Y);soeur(M,Y);(frere(P,Z),couple(Z,Y));(frere(M,Z),couple(Z,Y))).