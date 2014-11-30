/* Theme Ensemble TP prolog */

%tester un ensemble
isListEns(X):-forall(member(Var,X),(select(_, X, R),not(member(Var,R)))).

%enlever les doublons d'une liste
%attention si l'element et plus de deux fois affiche plusieurs fois la meme liste a revoir le problème RESOLU
list2ens([],[]):-!.
list2ens([T|Q],NouveauQ):-member(T,Q),list2ens(Q,NouveauQ),!.
list2ens([T|Q],[T|NouveauQ]):-not(member(T,Q)),list2ens(Q,NouveauQ).

%Faire l'union entre deux liste transformé en ensemble
unionOfList(X,Y,Res):-append(X,Y,L),list2ens(L,Res),!.

%Faire l'intersection entre deux liste transformé en ensemble 
insertionElement(X,Y,Res):- append(P1,[A|P2],Y),append(P1,[X,A|P2],Res),!.
/*intersectOfList([],X,[]):-!.
intersectOfList(X,Y,R):-forall(member(Var,X),(member(Var,Y),insertionElement(Var,[],R))).*/

%la prochaine fois regarde un peu ton cours au lieu de te compliqué la vie
intersectOfList([],_,[]):-!.
intersectOfList([X|Y],Z,[X|T]):- member(X,Z),intersectOfList(Y,Z,T),!.
intersectOfList([_|Y],Z,T):- intersectOfList(Y,Z,T).

%Faire la différence entre deux liste transformé en ensemble 
differenceOfList([],_,[]):-!.
differenceOfList([X|Y],Z,[X|T]):- not(member(X,Z)),differenceOfList(Y,Z,T),!.
differenceOfList([_|Y],Z,T):- differenceOfList(Y,Z,T).

%Faire l'egalité entre deux liste transformé en ensemble 
egaliteOfList(X,Y):-list2ens(X,L),list2ens(Y,T),forall(member(Var,L),(member(Var,T))),forall(member(Var,T),(member(Var,L))),!.