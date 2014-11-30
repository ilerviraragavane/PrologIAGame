%%%%%%%%%%%%%%%%%%%%%%%%%%%%Exercice2. Manipulation de listes%%%%%%%%%%%%%%%%%%%%%%%%%%%
%element/2
element(Obj,[Obj|_]).
element(Obj,[_|Tail]) :- element(Obj,Tail).

%element/3
element(Obj,[Obj|R],R).
element(Obj,[X|L],[X|R]) :- element(Obj,L,R).

%extrait
%remarque: l'ordre des elements de la liste extraite n'est pas toujours pareil que dans la liste originale.
%on peux choisir la taille de la liste extraite.
extract(_,[]).
extract(L,[X|Tail]) :- element(X,L,R),extract(R,Tail).

%append
append([ ], L1, L1).
append([A|L1],L2,[A|L3]) :- append(L1,L2,L3).

%inversion
inv([],[]).
inv([T|Q],List_inv) :- inv(Q,Q_inv),append(Q_inv,[T],List_inv).

%substitution
subsAll(a,b,[],[]).
subsAll(a,b,[a|Q],[b|Q_subs]) :- subsAll(a,b,Q,Q_subs). %si le premier element est a, on le remplace par b et on fait une substitution sur la queue.
subsAll(a,b,[T|Q],[T|Q_subs]) :- a\=T, subsAll(a,b,Q,Q_subs). %si le premier element n'est pas a, on le garde et on fait une substitution sur la queue.

subsPremier(a,b,[],[]).
subsPremier(a,b,[a|Q],[b|Q]).
subsPremier(a,b,[T|Q],[T|Q_subs]) :- a\=T, subsPremier(a,b,Q,Q_subs).

subsOne(a,b,[],[]).
subsOne(a,b,[a|Q],[b|Q]).
subsOne(a,b,[T|Q],[T|Q_subs]) :- subsOne(a,b,Q,Q_subs).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%Exercice3. Th¨¨me arithm¨¦tique%%%%%%%%%%%%%%%%%%%%%
element_arith(0,T,[T|Q]).
element_arith(X,E,[T|Q]) :- element_arith(Xq,E,Q),X is Xq+1.

%%%%%%%%%%%%%%%%%%%%%%%%%%Exercice4. Th¨¨me ensembles%%%%%%%%%%%%%%%%%%%%%%%%%%
%ensemble
isEnsemble([]).
isEnsemble([T|Q]) :- \+element(T,Q).

list2ens([],[]).
list2ens([T|Q],[T|Q_ens]) :- list2ens(Q,Q_ens),\+element(T,Q_ens).
list2ens([T|Q],Q_ens) :- list2ens(Q,Q_ens),element(T,Q_ens).

%union
union(L1,L2,U) :- append(L1,L2,L3),list2ens(L3,U).

%intersection
intersection([],Ens,[]).
intersection([T|Q],Ens,I) :- element(T,Ens),!,intersection(Q,Ens,Iq),append(Iq,[T],I). 
intersection([T|Q],Ens,I) :- \+element(T,Ens),intersection(Q,Ens,I). 

%difference difference(E1,E2,D). l'ensemble D contient les elements qui sont dans E2 mais pas dans E1.
difference(E1,[],[]).
difference(E1,[T|Q],Dq) :- element(T,E1),difference(E1,Q,Dq).
difference(E1,[T|Q],D) :- \+element(T,E1),difference(E1,Q,Dq),append([T],Dq,D).

%egalite
egale([],[]).
egale([T|Q],E2) :- element(T,E2,R),egale(Q,R).
