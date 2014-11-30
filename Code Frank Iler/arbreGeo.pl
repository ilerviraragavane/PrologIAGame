personne(eric, g, []).
personne(myreille, f, []).
personne(christian, g, []).
personne(valerie, f, []).
personne(jean-michelle, g, []).
personne(bernadette, f, []).
personne(stefan, g, []).
personne(morgan, f, []).
personne(marc, g, []).
personne(maude, f, []).
personne(paul, g, []).
personne(pauline, f, []).

personne(cloe, f, [eric, myreille]).
personne(maurice, g, [christian, valerie]).
personne(patrick, g, [stefan, morgan]).
personne(cid, g, [marc, maude]).
personne(marie, f, [paul, pauline]).

personne(luc, g, [jean-michelle, bernadette]).
personne(claire, f, [jean-michelle, bernadette]).
personne(jeanne, f, [jean-michelle, bernadette]).

personne(jean, g, [cloe, luc]).
personne(pierre, g, [cloe, luc]).
personne(clarice, f, [cloe, luc]).

personne(amandine, f, [jeanne, patrick]).
personne(arnaud, g, [jeanne, patrick]).
personne(christine, f, [jeanne, patrick]).
personne(manu, g, [jeanne, patrick]).

personne(linda, f, [maurice, claire]).
personne(eleonore, f, [maurice, claire]).

personne(vincent, g, [cid, marie]).

personne(leo, g, [vincent, linda]).
personne(sandra, f, [vincent, linda]).
personne(clara, f, [vincent, linda]).

fraterie(X,Y,S):-personne(X,_,L),personne(Y,S,L),L\=[],X\=Y. /*Est ce que Y est le frère ou la soeur de X*/
fraterieList(X,S,T):-setof(Y,S^fraterie(X,Y,S),T).

patrie(X,Y):-personne(X,_,T),member(Y,T). /*Est ce que Y est le père ou la mère de X*/
parentDe(X,T):-setof(Y,X^patrie(X,Y),T).
enfantDe(X,T):-setof(Y,X^patrie(Y,X),T).

oncleDe(X,T):-parentDe(X,L),member(Y,L),fraterieList(Y,g,T).
tanteDe(X,T):-parentDe(X,L),member(Y,L),fraterieList(Y,f,T).
oncleEtTanteDe(X,T):-oncleDe(X,L),tanteDe(X,V),append(L,V,T).

rechercheCousin(X,T):-oncleEtTanteDe(X,L),member(Y,L),enfantDe(Y,T).
cousinDe(X,Y):-setof(T,X^rechercheCousin(X,T),L),flatten(L,Y).



