%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%						Thème de la généalogie

/* Humain Homme ou femme, de nom 'paul' */
humain(h,paul). 
humain(f,pauline).
humain(h,jack).
humain(f,jackie).
humain(f,julie).
humain(f,cindy).
humain(f,jane).
humain(h,pierre).

/* Liens de parenté (parent,enfant) */
parent(paul,pauline). 
parent(paul,jackie).
parent(jack,paul).
parent(cindy,paul).
parent(jack,jane).
parent(cindy,jane).
parent(jack,pierre).
parent(julie,pauline).

/* Teste des liens de parentés existants */
est_parent(X,Y) :- parent(X,Y).

% ?- parent(X,Y).
% ?- est_parent(X,Y).  	
% ?- est_parent(X,paul).		
% ?- est_parent(paul,X).		
% ?- est_parent(paul,pauline).

/* Anctre directs et indirects */
est_ancetre(X,Y) :- est_parent(X,Y).
est_ancetre(X,Y) :- est_parent(X,Z), est_ancetre(Z,Y).

% ?- est_ancetre(X,jack).
% ?- est_ancetre(X,paul).
% ?- est_ancetre(paul,X).
% ?- est_ancetre(X,pauline).
% ?- est_ancetre(X,Y).

/* Pere et mere */
est_pere(X,Y) :- est_parent(X,Y), humain(h,X).
est_mere(X,Y) :- est_parent(X,Y), humain(f,X).

% ?- est_mere(X,pauline).
% ?- est_pere(X,pauline).
% ?- est_mere(X,paul).

/* Freres et soeurs */

sont_frere_soeur(X,Y) :- est_parent(Z,X), est_parent(Z,Y), not(X==Y).

% ?- sont_frere_soeur(X,Y).
% ?- sont_frere_soeur(jane,paul).
% ?- sont_frere_soeur(pauline,jackie).

/* Version avec couples (X,Y) et (Y,X) et qui exclut les demi-freres et demi-soeurs */
sont_frere_soeur_complet(X,Y) :- est_pere(H,X), est_pere(H,Y), est_mere(F,X), est_mere(F,Y), not(X==Y).

% ?- sont_frere_soeur_complet(X,Y).
% ?- sont_frere_soeur_complet(jane,paul).
% ?- sont_frere_soeur_complet(pauline,jackie).

/* Version avec unicité des tuples (X,Y) */
couple(jack,cindy).
couple(paul,julie).

/* pour eviter la redondance du resultat lorsque les parents des freres-soeurs sont en couple
- la 1ere ligne ne valide la relation pour un couple que si le parent testé est l homme en couple
- la 2me ligne valide le parent testé qui n est pas en couple */
sont_frere_soeur2(X,Y) :- est_parent(C1,X),est_parent(C1,Y),not(X==Y),couple(C1,_).
sont_frere_soeur2(X,Y) :- est_parent(C1,X),est_parent(C1,Y),not(X==Y), not(couple(C1,_)), not(couple(_,C1)).


/* Oncle Tante */
est_tante(T,Y) :- humain(f,T), est_parent(P,Y), sont_frere_soeur3(T,P).
est_oncle(T,Y) :- humain(h,T), est_parent(P,Y), sont_frere_soeur3(T,P).

% ?- est_tante(X,Y).
% ?- est_tante(X,jackie).
% ?- est_tante(jane,Y).
% ?- est_oncle(X,Y).
% ?- est_oncle(X,jackie).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%						Manipulation de listes

/* element(Element,Liste,ListePriveeDeElement) */
element(Obj,[Obj|R],R).
element(Obj,[X|Q],[X|R]) :- element(Obj,Q,R).

/* extract(Liste,ExtraitDeListe) */
extract(_,[]).
extract(L,[X|Tail]) :- element(X,L,R),extract(R,Tail).


/* Concatenation de liste */
append([ ], L1, L1).
append([A|L1],L2,[A|L3]) :- append(L1,L2,L3).


/* inverse les éléments de deux listes */
inv([],[]).
inv(List,List_inv) :- nonvar(List),List=[T|Q],inv(Q,Q_inv),append(Q_inv,[T],List_inv).
inv(List,List_inv) :- var(List),nonvar(List_inv),inv(List_inv,List).

% tests:	
% ?- inv([],L).
% ?- inv([a],L).
% ?- inv([a,b,c,d,e],L).
% ?- inv([1,2,3],L).	
	
/* subsAll(ElementARemplacer,ElementRemplacant,Liste,Resultat) */
subsAll(_,_,[],[]).
subsAll(A,B,[A|Q],[B|Q_subs]) :- subsAll(A,B,Q,Q_subs).
subsAll(A,B,[T|Q],[T|Q_subs]) :- A\=T, subsAll(A,B,Q,Q_subs).

% tests:
% ?- subsAll(a,b,[],L).
% ?- subsAll(a,b,[c,d,e],L).
% ?- subsAll(a,b,[a,b,c,d],L).

/* Pareil que subsAll mais ne remplace qu un element */
subsOne(_,_,[],[]).
subsOne(A,B,[A|Q],[B|Q]).
subsOne(A,B,[T|Q],[T|Q_subs]) :- subsOne(A,B,Q,Q_subs).

% tests:
% ?- subsOne(a,b,[],L).
% ?- subsOne(c,b,[a,b,a,a],L).
% ?- subsOne(a,b,[a,b,a,a],L).


/* Pareil que subsAll mais ne remplace que le premier element */
subsPremier(_,_,[],[]).
subsPremier(A,B,[A|Q],[B|Q]).
subsPremier(A,B,[T|Q],[T|Q_subs]) :- A\=T, subsPremier(A,B,Q,Q_subs).

% tests:
% ?- subsPremier(a,b,[],L).
% ?- subsPremier(a,b,[c,d,e],L).
% ?- subsPremier(b,c,[a,b,c,b,d],L).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%						Thème Arithmétique

element2(1,X,[X|_]).
element2(N,X,[_|T]) :- nonvar(N) -> N1 is N-1, element2(N1,X,T); element2(N1,X,T),N is N1+1.

% ?- element2(I,a,[a,b,a]).
% ?- element2(I,X,[a,b,a]).
% ?- element2(1,a,[]).
% ?- element2(X,a,L).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%						Thème Ensembles

/* tester un ensemble */
isListEns(X):-forall(member(Var,X),(select(_, X, R),not(member(Var,R)))).

% ?- isListEns([a,b,c,d]). 		
% ?- isListEns([a,b,b,d]). 		 
% ?- isListEns([]). 

/* enlever les doublons d une liste */
list2ens([],[]):-!.
list2ens([T|Q],NouveauQ):-member(T,Q),list2ens(Q,NouveauQ),!.
list2ens([T|Q],[T|NouveauQ]):-not(member(T,Q)),list2ens(Q,NouveauQ).

% ?- list2ens([a,b,c,d,e],Y). 			
% ?- list2ens([a,b,b,d,d],Y). 	
% ?- list2ens([],Y). 


/* Faire l union entre deux liste transformé en ensemble */
unionOfList(X,Y,Res):-append(X,Y,L),list2ens(L,Res),!.

% ?- unionOfList([a],[b],Res). 	
% ?- unionOfList([a,b,c],[b,b],Res). 		
% ?- unionOfList([],[b,b],Res).			
% ?- unionOfList([],[],Res). 


/* Faire l intersection entre deux liste transformé en ensemble */
intersectOfList([],_,[]):-!.
intersectOfList([X|Y],Z,[X|T]):- member(X,Z),intersectOfList(Y,Z,T),!.
intersectOfList([_|Y],Z,T):- intersectOfList(Y,Z,T).

% ?- intersectOfList([],[],Res).  	
% ?- intersectOfList([a,b,c],[d,e,f],Res). 	
% ?- intersectOfList([a,b,c],[a,b,f],Res). 	

/* Faire la différence entre deux liste transformé en ensemble */
differenceOfList([],_,[]):-!.
differenceOfList([X|Y],Z,[X|T]):- not(member(X,Z)),differenceOfList(Y,Z,T),!.
differenceOfList([_|Y],Z,T):- differenceOfList(Y,Z,T).

% ?- differenceOfList([a,b,c],[],Res). 
% ?- differenceOfList([],[a,b,c],Res).	
% ?- differenceOfList([a,b,c],[a,d,c],Res).


/* Faire l egalité entre deux liste transformé en ensemble */
egaliteOfList(X,Y):-forall(member(Var,X),(member(Var,Y))),forall(member(Var,Y),(member(Var,X))),!.

% ?- egaliteOfList([],[]).
% ?- egaliteOfList([a,b,c],[a,b,c]). 		
% ?- egaliteOfList([a,b],[b,c]). 


